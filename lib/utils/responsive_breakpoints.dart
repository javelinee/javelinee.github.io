import 'package:flutter/widgets.dart';

class ResponsiveBreakpoints {
  const ResponsiveBreakpoints._();

  // Tune these to control when layouts switch on web/desktop.
  static const double tablet = 768;
  static const double desktop = 1024;
  static const double wide = 1280;

  static double width(BuildContext context) => MediaQuery.sizeOf(context).width;

  static bool isTabletUp(BuildContext context) => width(context) >= tablet;
  static bool isDesktopUp(BuildContext context) => width(context) >= desktop;
  static bool isWideUp(BuildContext context) => width(context) >= wide;
}

