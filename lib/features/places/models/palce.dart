import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Place {
  Place({required this.name}) : id = uuid.v4();

  final String id;
  final String name;
}
