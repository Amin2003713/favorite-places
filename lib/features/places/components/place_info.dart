import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_fave/features/places/components/location_input.dart';
import 'package:transparent_image/transparent_image.dart';

import '../states/places_states.dart';

class PlaceInfo extends ConsumerStatefulWidget {
  const PlaceInfo({super.key, required this.placeId});

  final String placeId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PlaceInfoState();
}

class _PlaceInfoState extends ConsumerState<PlaceInfo> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final place = ref
        .watch(PlaceProvider)
        .firstWhere((element) => element.id == widget.placeId);

    return Scaffold(
      appBar: AppBar(title: Text(place.name)),

      body: Card(
        elevation: 0,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: FileImage(place.image),
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
