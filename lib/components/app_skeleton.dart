import 'package:flutter/widgets.dart';

class AppSkeleton extends StatelessWidget {
  const AppSkeleton({super.key, this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: child,
      padding: EdgeInsets.fromLTRB(0, padding.top, 0, padding.bottom),
    );
  }
}
