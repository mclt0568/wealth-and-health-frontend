import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:wealth_and_health_frontend/styles.dart';

class DashboardPage extends StatefulWidget {
  DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late DateTime _date;
  final Map<String, IconData> _catIcon = {"food": CarbonIcons.noodle_bowl};
  late Map<String, double> _analytics;

  Future<void> _updateAnalytic() async {}

  Future<void> _nextDay() async {
    setState(() {
      _date = _date.add(Duration(days: 1));
    });
    await _updateAnalytic();
  }

  Future<void> _prevDay() async {
    setState(() {
      _date = _date.subtract(Duration(days: 1));
    });
    await _updateAnalytic();
  }

  Future<void> chooseDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _date = pickedDate;
      });
      await _updateAnalytic();
    }
  }

  @override
  void initState() {
    _date = DateTime.now();
    _analytics = {"food": 0.30};
    super.initState();
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
                for (var entry in _analytics.entries)
                  Row(
                    children: [
                      Icon(_catIcon[entry.key]),
                      SizedBox(width: 5),
                      IntrinsicWidth(
                        child: Text(entry.key, style: AppStyles.paragraph),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          entry.value.toString(),
                          style: AppStyles.accentedParagraph,
                        ),
                      ),
                    ],
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
