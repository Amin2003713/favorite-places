import 'dart:io';

import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Place {
  Place({required this.name, required this.image, required this.location})
    : id = uuid.v4();

  final String id;
  final String name;
  final File image;
  final LocationData location;
}
