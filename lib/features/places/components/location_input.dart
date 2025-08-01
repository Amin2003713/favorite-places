import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSave});

  final void Function(LocationData location) onSave;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? _storedLocation;
  String? _prev;
  bool isLoading = false;

  void showPreview(LocationData location) {
    try {
      final staticMapUrl = Uri.parse(
        'https://maps.googleapis.com/maps/api/staticmap'
        '?center=${location.longitude!}${location.latitude!}'
        '&zoom=15&size=600x300&maptype=roadmap'
        '&markers=color:red%7Clabel:A%7C${location.longitude!},${location.latitude!}'
        '&key=AIzaSyAOVYRIgupAurZup5y1PRh8Ismb1A3lLao',
      );
      setState(() {
        _prev = staticMapUrl.toString();
      });
    } catch (e) {}

    widget.onSave(location);
  }

  Future<void> getCurrentLocation() async {
    final location = Location();

    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) return;
    }

    setState(() => isLoading = true);

    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) return;
    }

    final locationData = await location.getLocation();

    setState(() {
      isLoading = false;
      _storedLocation = locationData;
    });

    showPreview(locationData);
  }

  void selectOnMap() {
    // final location = LocationData.fromMap();
    //
    // showPreview(location);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Location',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: _prev != null
                  ? Image.network(
                      _prev!,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      height: 180,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Text(
                        (_storedLocation == null
                            ? 'No location selected'
                            : 'lat${_storedLocation?.latitude}\nlng${_storedLocation?.longitude}'),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
            ),
            if (isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black.withAlpha(120),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: IconButton.filledTonal(
                onPressed: getCurrentLocation,
                icon: const Icon(Icons.my_location),
                tooltip: 'Get current location',
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: IconButton.filledTonal(
                onPressed: selectOnMap,
                icon: const Icon(Icons.map_outlined),
                tooltip: 'Pick from map',
                style: IconButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
