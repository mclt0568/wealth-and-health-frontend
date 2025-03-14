import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:wealth_and_health_frontend/styles.dart';

class NavBarItem {
  NavBarItem({required this.icon});

  final IconData icon;
}

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();

  final double page;
  final void Function(double)? onPageChangeTrigger;
  final List<NavBarItem> items;

  NavBar({
    Key? key,
    required this.items,
    this.page = 0,
    this.onPageChangeTrigger,
  }) : super(key: key);
}

class _NavBarState extends State<NavBar> {
  late double _page;

  // init state from prop
  @override
  void initState() {
    super.initState();
    _page = widget.page;
  }

  // update widget state when prop changes
  @override
  void didUpdateWidget(NavBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.page != oldWidget.page) {
      setState(() {
        _page = widget.page;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [AppStyles.shadow],
        color: AppStyles.primaryBackground,
      ),
      child: Stack(
        children: [
          Positioned(
            left: _page * 77.5,
            child: Container(
              width: 77.5,
              height: 77.5,
              decoration: BoxDecoration(color: AppStyles.accentBackground),
            ),
          ),
          Row(
            children: [
              for (var item in widget.items.asMap().entries)
                GestureDetector(
                  onTap: () {
                    if (widget.onPageChangeTrigger != null) {
                      widget.onPageChangeTrigger!(item.key.toDouble());
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.all(22.5),
                    child: Icon(
                      item.value.icon,
                      size: 32.5, // Adjust size
                      color:
                          (_page.round() == item.key.toInt())
                              ? AppStyles.accentForeground
                              : AppStyles.primaryForeground, // Change color
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
