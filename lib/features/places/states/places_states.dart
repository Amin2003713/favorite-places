import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/palce.dart';

class PlaceStateNotifier extends StateNotifier<List<Place>> {
  PlaceStateNotifier() : super([]);

  void removePlace(String id) {
    state = state.where((p) => p.id != id).toList();
  }

  void addNewPlace(Place place) {
    if (state.contains(place)) {
      state = state.where((element) => element.id != place.id).toList();
      return;
    } else {
      state = [...state, place];
      return;
    }
  }
}

final PlaceProvider = StateNotifierProvider((ref) {
  return PlaceStateNotifier();
});
