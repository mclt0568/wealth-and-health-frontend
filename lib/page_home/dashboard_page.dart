import 'dart:convert';
import 'dart:io';

import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:wealth_and_health_frontend/constants/entry_categories.dart';
import 'package:wealth_and_health_frontend/models/entry_category.dart';
import 'package:wealth_and_health_frontend/models/spending_entry.dart';
import 'package:wealth_and_health_frontend/requests.dart';
import 'package:wealth_and_health_frontend/styles.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DateTime _date;
  Map<int, double> _categorySpendings = {};
  late bool _disposed;

  List<SpendingEntry> _spendings = [];

  Future<void> _nextDay() async {
    if (!_disposed) {
      setState(() {
        _date = _date.add(Duration(days: 1));
      });
    }
    await _getCategorySpendings();
  }

  Future<void> _prevDay() async {
    if (!_disposed) {
      setState(() {
        _date = _date.subtract(Duration(days: 1));
      });
    }
    await _getCategorySpendings();
  }

  Future<void> chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      if (!_disposed) {
        setState(() {
          _date = pickedDate;
        });
      }
      await _getCategorySpendings();
    }
  }

  Future<void> _getHistory() async {
    final response = await FetchRequest("spendings").commit();
    final result = jsonDecode(response.body);

    if (result["error"]) {
      Fluttertoast.showToast(msg: result["message"] ?? "");
      return;
    }

    final rawSpendings = result["spendings"] as List<dynamic>;

    final spendings = rawSpendings.map(SpendingEntry.fromJson).toList();

    if (!_disposed) {
      setState(() {
        _spendings = spendings;
      });
    }

    await _getCategorySpendings();
  }

  Future<void> _getCategorySpendings() async {
    final spendingsToday = _spendings.where((spending) {
      return listEquals(
        [spending.date.day, spending.date.month, spending.date.year],
        [_date.day, _date.month, _date.year],
      );
    });

    final Map<int, double> categorySpendings = {};
    for (var spending in spendingsToday) {
      categorySpendings[spending.category.identifier] =
          spending.price +
          (categorySpendings[spending.category.identifier] ?? 0);
    }

    if (!_disposed) {
      setState(() {
        _categorySpendings = categorySpendings;
      });
    }
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  void initState() {
    _disposed = false;
    _date = DateTime.now();
    super.initState();
    _getHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 35, 0, 50),
            child: Text("Dashboard", style: AppStyles.title),
          ),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(color: AppStyles.primaryBackground),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        _prevDay();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Icon(
                          CarbonIcons.chevron_left,
                          color: AppStyles.primaryForeground,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    chooseDate();
                  },
                  child: Container(
                    padding: EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      color: AppStyles.primaryBackground,
                    ),
                    child: Center(
                      child: Text(
                        DateFormat('dd MMM yyyy').format(_date).toUpperCase(),
                        style: AppStyles.paragraph,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(color: AppStyles.primaryBackground),
                  child: Material(
                    type: MaterialType.transparency,
                    child: InkWell(
                      onTap: () {
                        _nextDay();
                      },
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Icon(
                          CarbonIcons.chevron_right,
                          color: AppStyles.primaryForeground,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (var spendings in _categorySpendings.entries)
                  Padding(
                    padding: EdgeInsets.only(top: spendings.key * 10),
                    child: Row(
                      children: [
                        Icon(categories[spendings.key].icon),
                        SizedBox(width: 5),
                        IntrinsicWidth(
                          child: Text(
                            categories[spendings.key].name,
                            style: AppStyles.paragraph,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            spendings.value.toString(),
                            style: AppStyles.accentedParagraph,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    color: AppStyles.primaryBackground,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Get Spending Advice",
                            style: AppStyles.paragraph,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    color: AppStyles.primaryBackground,
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            "Get Health Advice",
                            style: AppStyles.paragraph,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
