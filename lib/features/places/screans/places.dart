import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/add_place.dart';
import '../components/place_info.dart';
import '../states/places_states.dart';

class PlacesScreen extends ConsumerStatefulWidget {
  const PlacesScreen({super.key});

  @override
  ConsumerState<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends ConsumerState<PlacesScreen> {
  void _addNewPlace() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddPlace()));
  }

  void _onDismiss(String placeId) {
    ref.read(PlaceProvider.notifier).removePlace(placeId);
  }

  _navigateToPage(String id) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => PlaceInfo(placeId: id)));
  }

  @override
  Widget build(BuildContext context) {
    final places = ref.watch(PlaceProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Great Places'),
        actions: [
          IconButton(onPressed: _addNewPlace, icon: const Icon(Icons.add)),
        ],
        elevation: 1.2,
      ),
      body: places.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Nothing here yet...'),
                  const SizedBox(height: 10),
                  ElevatedButton.icon(
                    onPressed: _addNewPlace,
                    icon: const Icon(Icons.add),
                    label: const Text('Add Item'),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: places.length,
              itemBuilder: (ctx, index) {
                final item = places[index];
                return Dismissible(
                  key: ValueKey(item.id),
                  background: Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).colorScheme.error.withAlpha(51),
                    ),
                    child: const Icon(Icons.delete, color: Colors.red),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (_) => _onDismiss(item.id),
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    elevation: 3,
                    child: ListTile(
                      onTap: () => _navigateToPage(item.id),
                      title: Text(
                        item.name,
                        style: TextStyle(
                          color: Theme.of(
                            context,
                          ).textTheme.displayMedium!.color,
                        ),
                      ),
                      leading: const Icon(Icons.place), // or an avatar
                      trailing: Icon(Icons.chevron_right),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
