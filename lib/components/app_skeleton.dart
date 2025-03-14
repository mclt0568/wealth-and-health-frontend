import 'package:flutter/widgets.dart';
import 'package:wealth_and_health_frontend/styles.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key, this.child, Color? color})
    : color = color ?? AppStyles.secondaryBackground;

  final Widget? child;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(color: color),
      padding: EdgeInsets.fromLTRB(0, padding.top, 0, padding.bottom),
      child: child,
    );
  }
}
