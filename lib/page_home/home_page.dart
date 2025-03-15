import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/widgets.dart';
import 'package:wealth_and_health_frontend/components/app_skeleton.dart';
import 'package:wealth_and_health_frontend/components/navbar.dart';
import 'package:wealth_and_health_frontend/page_home/dashboard_page.dart';
import 'package:wealth_and_health_frontend/page_home/map_page.dart';
import 'package:wealth_and_health_frontend/page_home/new_record.dart';
import 'package:wealth_and_health_frontend/page_home/settings_page.dart';
import 'package:wealth_and_health_frontend/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  double _currentPage = 0.0;

  Future<void> checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("token")) {
      return;
    }

    Navigator.pushNamed(context, "/login");
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page ?? 0.0;
      });
    });
    // checkLogin();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(
      child: Stack(
        children: [
          PageView(
            physics:
                (_currentPage == 2.00)
                    ? NeverScrollableScrollPhysics()
                    : BouncingScrollPhysics(),
            controller: _pageController,
            children: [NewRecord(), DashboardPage(), MapPage(), SettingsPage()],
          ),
          Positioned(
            bottom: 20,
            left: 65,
            child: NavBar(
              page: _currentPage,
              onPageChangeTrigger: (newPage) {
                setState(() {
                  _pageController.animateToPage(
                    newPage.toInt(),
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                });
              },
              items: [
                NavBarItem(icon: CarbonIcons.request_quote),
                NavBarItem(icon: CarbonIcons.dashboard),
                NavBarItem(icon: CarbonIcons.choropleth_map),
                NavBarItem(icon: CarbonIcons.settings),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
