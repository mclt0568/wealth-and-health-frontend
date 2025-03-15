import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:io';

import 'package:wealth_and_health_frontend/components/app_skeleton.dart';
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
    return PopScope(
      onPopInvokedWithResult:
          (didPop, result) => {
            if (didPop) {exit(0)},
          },
      child: AppSkeleton(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Container(
                color: AppStyles.primaryBackground,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: () {},
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Register / Login",
                        style: AppStyles.paragraph,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
