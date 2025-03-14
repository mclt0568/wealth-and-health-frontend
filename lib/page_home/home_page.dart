import 'package:flutter/widgets.dart';
import 'package:wealth_and_health_frontend/components/app_skeleton.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSkeleton(child: Center(child: Text("hello world")));
  }
}
