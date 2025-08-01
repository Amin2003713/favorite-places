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
  Widget build(BuildContext context) {
    final place = ref
        .watch(PlaceProvider)
        .firstWhere((element) => element.id == widget.placeId);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(place.name), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Material(
              elevation: 4,
              borderRadius: BorderRadius.circular(16),
              clipBehavior: Clip.antiAlias,
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  AspectRatio(
                    aspectRatio: 16 / 9,
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: FileImage(place.image),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black.withAlpha(150),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Text(
                      place.name,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
