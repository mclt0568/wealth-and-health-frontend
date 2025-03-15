import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

import 'package:wealth_and_health_frontend/components/app_skeleton.dart';
import 'package:wealth_and_health_frontend/requests.dart';
import 'package:wealth_and_health_frontend/styles.dart'; // Needed to call exit()

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late FocusNode _usernameNode;
  late TextEditingController _passwordController;
  late FocusNode _passwordNode;

  Future<void> _setCredentials(String token, String username) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("token", token);
    await prefs.setString("username", username);
  }

  Future<void> _login(String username, String password) async {
    final response =
        await FetchRequest(
          "auth/login",
        ).post().attach({"username": username, "password": password}).commit();

    final Map<String, dynamic> result = jsonDecode(response.body);

    // if error, return with a toast message
    if (result["error"]) {
      Fluttertoast.showToast(
        msg: result["message"],
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    // or else sign in user and store token
    await _setCredentials(result["token"], username);
    Navigator.popAndPushNamed(context, "/");
  }

  Future<void> _register(String username, String password) async {
    final response =
        await FetchRequest(
          "auth/register",
        ).post().attach({"username": username, "password": password}).commit();

    print(response.body);
    final Map<String, dynamic> result = jsonDecode(response.body);

    // if error, return with a toast message
    if (result["error"]) {
      Fluttertoast.showToast(
        msg: result["message"],
        toastLength: Toast.LENGTH_SHORT,
      );
      return;
    }

    // or else sign in
    await _setCredentials(result["token"], username);
    Navigator.popAndPushNamed(context, "/");
  }

  @override
  void initState() {
    _usernameController = TextEditingController();
    _usernameNode = FocusNode();
    _passwordController = TextEditingController();
    _passwordNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Text("Welcome", style: AppStyles.title),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(color: AppStyles.primaryBackground),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: IntrinsicWidth(
                        child: Text("Username", style: AppStyles.paragraph),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: EditableText(
                        controller: _usernameController,
                        focusNode: FocusNode(),
                        style: AppStyles.accentedParagraph,
                        cursorColor: AppStyles.accentForeground,
                        backgroundCursorColor: Color(
                          0x00000000,
                        ), // Transparent cursor background
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Container(
                decoration: BoxDecoration(color: AppStyles.primaryBackground),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: IntrinsicWidth(
                        child: Text("Password", style: AppStyles.paragraph),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: EditableText(
                        obscureText: true,
                        controller: _passwordController,
                        focusNode: FocusNode(),
                        style: AppStyles.accentedParagraph,
                        cursorColor: AppStyles.accentForeground,
                        backgroundCursorColor: Color(
                          0x00000000,
                        ), // Transparent cursor background
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Container(
                  color: AppStyles.primaryBackground,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        _login(
                          _usernameController.text,
                          _passwordController.text,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Login", style: AppStyles.paragraph),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  color: AppStyles.primaryBackground,
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        _register(
                          _usernameController.text,
                          _passwordController.text,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.all(20),
                        child: Text("Register", style: AppStyles.paragraph),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
