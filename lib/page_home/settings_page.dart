import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wealth_and_health_frontend/styles.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      await prefs.remove("token");
    }

    Navigator.pushNamed(context, "/login");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: AppStyles.primaryBackground,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: () {
              _logout();
            },
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("Logout", style: AppStyles.paragraph),
            ),
          ),
        ),
      ),
    );
  }
}
