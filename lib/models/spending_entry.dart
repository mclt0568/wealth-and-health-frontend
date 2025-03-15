import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wealth_and_health_frontend/constants/entry_categories.dart';
import 'package:wealth_and_health_frontend/models/entry_category.dart';

class SpendingEntry {
  final String id;
  final double price;
  final EntryCategory category;
  final DateTime date;
  final LatLng location;
  final String remark;

  const SpendingEntry({
    required this.id,
    required this.price,
    required this.category,
    required this.date,
    required this.location,
    required this.remark,
  });

  factory SpendingEntry.fromJson(dynamic json) {
    /*     print("JSON:");
    print(json);

    if (json.runtimeType != Map) {
      throw const FormatException('Failed to load spending entry.');
    }

    final jsonObj = json as Map<String, dynamic>;

    for (var field in [
      "_id",
      "price",
      "category",
      "datetime",
      "remark",
      "location",
    ]) {
      if (!jsonObj.containsKey(field)) {
        throw const FormatException('Failed to load spending entry.');
      }
    }

    final id = jsonObj["_id"];
    final price = jsonObj["price"];
    final category = categories[jsonObj["category"]];
    final datetime = jsonObj["datetime"];
    final id = jsonObj["_id"];
    final id = jsonObj["_id"]; */

    return switch (json) {
      {
        '_id': String id,
        'price': double price,
        'category': int categoryIndex,
        "date": String isoDate,
        "remark": String remark,
        "location": String _,
        "user": String _,
      } =>
        SpendingEntry(
          id: id,
          price: price,
          category: categories[categoryIndex],
          date: DateTime.parse(isoDate),
          remark: remark,
          location: LatLng(0, 0),
        ),
      {
        '_id': String id,
        'price': int price,
        'category': int categoryIndex,
        "date": String isoDate,
        "remark": String remark,
        "location": String _,
        "user": String _,
      } =>
        SpendingEntry(
          id: id,
          price: price.toDouble(),
          category: categories[categoryIndex],
          date: DateTime.parse(isoDate),
          remark: remark,
          location: LatLng(0, 0),
        ),
      _ => throw const FormatException('Failed to load spending entry.'),
    };
  }
}
