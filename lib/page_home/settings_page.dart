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
  String _username = "";

  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      await prefs.remove("token");
    }
    if (prefs.containsKey("username")) {
      await prefs.remove("username");
    }

    Navigator.popAndPushNamed(context, "/login");
  }

  Future<void> _getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey("username")) {
      await _logout();
      return;
    }

    String username = prefs.getString("username")!;

    setState(() {
      _username = username;
    });
  }

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(80.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Welcome back, " + _username,
              style: AppStyles.welcomeMessage,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Container(
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
          ],
        ),
      ),
    );
  }
}
