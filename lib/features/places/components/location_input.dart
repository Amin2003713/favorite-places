import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

  void _showPreview(double lat, double lng) {
    final staticMapUrl = Uri.parse(
      'https://maps.googleapis.com/maps/api/staticmap'
      '?center=$lat,$lng'
      '&zoom=15&size=600x300&maptype=roadmap'
      '&markers=color:red%7Clabel:A%7C$lat,$lng'
      '&key=YOUR_API_KEY', // 🔐 جایگزین کن با کلید واقعی
    );

    setState(() {
      _previewImageUrl = staticMapUrl.toString();
    });
  }

  void _getCurrentLocation() {
    // 👇 اینجا باید مختصات واقعی رو بگیری
    const dummyLat = 35.6892;
    const dummyLng = 51.3890; // تهران

    _showPreview(dummyLat, dummyLng);
  }

  void _selectOnMap() {
    // 👇 شبیه‌سازی انتخاب دستی مکان روی نقشه
    const selectedLat = 35.70;
    const selectedLng = 51.42;

    _showPreview(selectedLat, selectedLng);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Choose Location',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _getCurrentLocation,
              icon: Icon(Icons.my_location),
              label: Text('Use Current Location'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _selectOnMap,
              icon: Icon(Icons.map_outlined),
              label: Text('Select Location on Map'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.indigo,
                foregroundColor: Colors.white,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 20),
            if (_previewImageUrl != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  _previewImageUrl!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 200,
                ),
              )
            else
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'No location chosen',
                  style: TextStyle(color: Colors.grey),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
