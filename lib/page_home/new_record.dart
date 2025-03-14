import 'dart:ffi';

import 'package:flutter/widgets.dart';
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
        ],
      ),
    );
  }
}
