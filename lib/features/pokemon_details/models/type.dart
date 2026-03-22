import 'dart:convert';

class Type {
  final int slot;
  final String name;

  Type({required this.slot, required this.name});

  factory Type.fromJson(Map<String, dynamic> json) {
    return Type(
      slot: json['slot']?.toInt() ?? 0,
      name: json['type']['name'] ?? '',
    );
  }
}
