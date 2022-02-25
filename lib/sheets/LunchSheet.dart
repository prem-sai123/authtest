import 'dart:convert';
class LunchSheet {
  LunchSheet({
    this.name,
    this.food,
    this.egg,
  });

  String? name;
  int? food;
  int? egg;

  factory LunchSheet.fromJson(dynamic json) => LunchSheet(
        name: "${json['name']}",
        food: "${json['food']}" as int,
        egg: "${json['egg']}" as int,
      );

  Map toJson() => {
        "name": name,
        "food": food,
        "egg": egg,
      };
}
