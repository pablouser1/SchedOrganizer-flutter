class Group {
  final int id;
  final int year;
  final String group;

  Group({
    required this.id,
    required this.year,
    required this.group,
  });

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'],
      year: json['year'],
      group: json['group'],
    );
  }
}
