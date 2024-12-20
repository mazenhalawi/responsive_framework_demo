import 'package:flutter/material.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget desktop;

  const ResponsiveWidget(
      {Key? key, required this.mobile, this.tablet, required this.desktop})
      : super(key: key);

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 840;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 840;

  @override
  Widget build(BuildContext context) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context) && tablet != null) {
      return tablet!;
    } else {
      return desktop;
    }
  }
}
