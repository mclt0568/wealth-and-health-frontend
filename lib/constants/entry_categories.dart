import 'package:carbon_icons/carbon_icons.dart';
import 'package:wealth_and_health_frontend/models/entry_category.dart';

final List<EntryCategory> categories = [
  EntryCategory(
    identifier: 0,
    icon: CarbonIcons.shopping_cart,
    name: "Grocery",
  ),
  EntryCategory(identifier: 1, icon: CarbonIcons.plane_private, name: "Travel"),
  EntryCategory(
    identifier: 2,
    icon: CarbonIcons.noodle_bowl,
    name: "Eating Out",
  ),
  EntryCategory(identifier: 3, icon: CarbonIcons.pills, name: "Health Care"),
  EntryCategory(identifier: 4, icon: CarbonIcons.idea, name: "Utility"),
  EntryCategory(identifier: 5, icon: CarbonIcons.hotel, name: "Rent"),
  EntryCategory(identifier: 6, icon: CarbonIcons.currency, name: "Other"),
];
