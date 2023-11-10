class Timezone {
  final int id;
  final String start;
  final String finish;

  Timezone({
    required this.id,
    required this.start,
    required this.finish,
  });

  factory Timezone.fromJson(Map<String, dynamic> json) {
    return Timezone(
      id: json['id'],
      start: json['start'],
      finish: json['finish'],
    );
  }

  @override
  String toString() {
    return "$start - $finish";
  }
}
