import 'package:flutter/widgets.dart';

class EntryCategory {
  EntryCategory({
    required this.identifier,
    required this.name,
    required this.icon,
  });

  final int identifier;
  final String name;
  final IconData icon;
}
