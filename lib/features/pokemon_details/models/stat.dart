class Stat {
  final int baseStat;
  final int effort;
  final String name;

  Stat({required this.baseStat, required this.effort, required this.name});


  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      baseStat: json['base_stat']?.toInt() ?? 0,
      effort: json['effort']?.toInt() ?? 0,
      name: json['stat']['name'] ?? '',
    );
  }
}
