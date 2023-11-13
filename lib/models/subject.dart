import 'package:schedorganizer/models/room.dart';
import 'package:schedorganizer/models/group.dart';

class Subject {
  final int id;
  final String name;
  final String shortName;
  final String? url;
  final Group group;
  final List<Room> rooms;

  Subject(
      {required this.id,
      required this.name,
      required this.shortName,
      this.url,
      required this.group,
      required this.rooms});

  factory Subject.fromJson(Map<String, dynamic> json) {
    List l = json['rooms'];
    Iterable<Room> rooms = l.map((e) => Room.fromJson(e));
    return Subject(
      id: json['id'],
      name: json['name'],
      shortName: json['short_name'],
      url: json['url'],
      group: Group.fromJson(json['group']),
      rooms: rooms.toList(),
    );
  }
}
