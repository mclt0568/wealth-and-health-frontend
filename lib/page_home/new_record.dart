import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wealth_and_health_frontend/models/entry_category.dart';
import 'package:wealth_and_health_frontend/styles.dart';
import 'package:intl/intl.dart';

class NewRecord extends StatefulWidget {
  const NewRecord({super.key});

  @override
  State<NewRecord> createState() => _NewRecordState();
}

class _NewRecordState extends State<NewRecord> {
  late TextEditingController _priceController;
  late FocusNode _priceNode;
  late TextEditingController _remarkController;
  late FocusNode _remarkNode;
  late DateTime _date;
  late int _category;

  final List<EntryCategory> _categories = [
    EntryCategory(name: "Food", icon: CarbonIcons.noodle_bowl),
    EntryCategory(name: "1", icon: CarbonIcons.noodle_bowl),
    EntryCategory(name: "2", icon: CarbonIcons.noodle_bowl),
    EntryCategory(name: "2", icon: CarbonIcons.noodle_bowl),
    EntryCategory(name: "2", icon: CarbonIcons.noodle_bowl),
  ];

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
    }
  }

  @override
  void initState() {
    super.initState();
    _category = 0;
    _priceNode = FocusNode();
    _priceController = TextEditingController();
    _priceController.text = "0.00";
    _remarkNode = FocusNode();
    _remarkController = TextEditingController();
    _date = DateTime.now();
  }

  @override
  void dispose() {
    super.dispose();
    _priceController.dispose();
    _priceNode.dispose();
    _remarkController.dispose();
    _remarkNode.dispose();
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
            child: Text("New Record", style: AppStyles.title),
          ),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(color: AppStyles.primaryBackground),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: IntrinsicWidth(
                        child: Text("AU\$", style: AppStyles.paragraph),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: EditableText(
                        keyboardType: TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        controller: _priceController,
                        focusNode: FocusNode(),
                        style: TextStyle(
                          fontSize: 40,
                          color: AppStyles.accentForeground,
                        ),
                        cursorColor: AppStyles.accentForeground,
                        backgroundCursorColor: Color(
                          0x00000000,
                        ), // Transparent cursor background
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 30),
                child: GestureDetector(
                  onTap: () {
                    chooseDate();
                  },
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppStyles.primaryBackground,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                          child: IntrinsicWidth(
                            child: Text("Date", style: AppStyles.paragraph),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            DateFormat(
                              'dd MMM yyyy',
                            ).format(_date).toUpperCase(),
                            style: AppStyles.accentedParagraph,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(color: AppStyles.primaryBackground),
                padding: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 20, 0),
                      child: IntrinsicWidth(
                        child: Text("Remark", style: AppStyles.paragraph),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: EditableText(
                        controller: _remarkController,
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
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30),
            child: Container(
              height: 240,
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    for (var categoryEntry in _categories.asMap().entries)
                      Container(
                        decoration: BoxDecoration(
                          color:
                              (categoryEntry.key == _category)
                                  ? AppStyles.accentBackground
                                  : AppStyles.primaryBackground,
                        ),
                        child: Material(
                          type: MaterialType.transparency,
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _category = categoryEntry.key;
                              });
                            },
                            child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(right: 10),
                                    child: Icon(
                                      categoryEntry.value.icon,
                                      color:
                                          (categoryEntry.key == _category)
                                              ? AppStyles.accentForeground
                                              : AppStyles.primaryForeground,
                                    ),
                                  ),
                                  IntrinsicWidth(
                                    child: Text(
                                      categoryEntry.value.name,
                                      style: TextStyle(
                                        fontSize: AppStyles.paragraph.fontSize,
                                        color:
                                            (categoryEntry.key == _category)
                                                ? AppStyles.accentForeground
                                                : AppStyles.primaryForeground,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(color: AppStyles.accentForeground),
            child: Material(
              type: MaterialType.transparency,
              child: InkWell(
                onTap: () {
                  setState(() {
                    _priceController.text = "0.00";
                    _remarkController.text = "";
                    _category = 0;
                    _date = DateTime.now();
                    Fluttertoast.showToast(
                      msg: "Submitted",
                      toastLength: Toast.LENGTH_SHORT,
                    );
                  });
                }, // SUBMIT
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        fontSize: AppStyles.paragraph.fontSize,
                        color: AppStyles.primaryBackground,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
