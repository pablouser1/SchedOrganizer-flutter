class Room {
  final int id;
  final String location;
  final String description;

  Room({
    required this.id,
    required this.location,
    required this.description,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      id: json['id'],
      location: json['location'],
      description: json['description'],
    );
  }
}
