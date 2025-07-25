import 'package:favorite_places/features/places/components/add_place.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<StatefulWidget> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
  void _addNewPlace() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (context) => AddPlace()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Great Places'),
      actions: [IconButton(onPressed: _addNewPlace, icon: Icon(Icons.add))],
      elevation: 1.2,
    ),
    body: Text('data'),
  );
}
