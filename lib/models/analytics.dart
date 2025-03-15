import 'package:wealth_and_health_frontend/constants/entry_categories.dart';
import 'package:wealth_and_health_frontend/models/entry_category.dart';
import 'package:wealth_and_health_frontend/models/location.dart';

class AnalyticsEntry {
  final String id;
  final MapLocation location;
  final EntryCategory category;
  final double average;
  final int n;

  AnalyticsEntry({
    required this.id,
    required this.location,
    required this.category,
    required this.average,
    required this.n,
  });

  factory AnalyticsEntry.fromJsonWithLocation(
    dynamic json,
    Map<String, MapLocation> locLookup,
  ) {
    return switch (json) {
      {
        "_id": String id,
        "location": String locId,
        "category": int cadId,
        "average": double avg,
        "numberOfSpendings": int n,
      } =>
        AnalyticsEntry(
          id: id,
          location: locLookup[locId] ?? fallbackLocation,
          category: categories[cadId],
          average: avg,
          n: n,
        ),
      {
        "_id": String id,
        "location": String locId,
        "category": int cadId,
        "average": int avg,
        "numberOfSpendings": int n,
      } =>
        AnalyticsEntry(
          id: id,
          location: locLookup[locId] ?? fallbackLocation,
          category: categories[cadId],
          average: avg.toDouble(),
          n: n,
        ),
      _ => throw const FormatException('Failed to load analytics.'),
    };
  }
}
