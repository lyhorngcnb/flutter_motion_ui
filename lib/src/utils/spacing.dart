import 'package:flutter/material.dart';

class MotionSpacing {
  // Spacing constants (4px grid system)
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;
  static const double xxxl = 64.0;

  // Custom spacing
  static const double space2 = 2.0;
  static const double space6 = 6.0;
  static const double space12 = 12.0;
  static const double space20 = 20.0;
  static const double space40 = 40.0;
  static const double space56 = 56.0;
  static const double space72 = 72.0;

  // Layout margins
  static const EdgeInsets pagePadding = EdgeInsets.all(md);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  // Layout spacing for rows and columns
  static SizedBox get verticalXs => const SizedBox(height: xs);
  static SizedBox get verticalSm => const SizedBox(height: sm);
  static SizedBox get verticalMd => const SizedBox(height: md);
  static SizedBox get verticalLg => const SizedBox(height: lg);
  static SizedBox get verticalXl => const SizedBox(height: xl);
  static SizedBox get verticalXxl => const SizedBox(height: xxl);

  static SizedBox get horizontalXs => const SizedBox(width: xs);
  static SizedBox get horizontalSm => const SizedBox(width: sm);
  static SizedBox get horizontalMd => const SizedBox(width: md);
  static SizedBox get horizontalLg => const SizedBox(width: lg);
  static SizedBox get horizontalXl => const SizedBox(width: xl);
  static SizedBox get horizontalXxl => const SizedBox(width: xxl);

  // Edge insets shortcuts
  static EdgeInsets all(double value) => EdgeInsets.all(value);
  static EdgeInsets symmetric({double horizontal = 0, double vertical = 0}) =>
      EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical);
  static EdgeInsets only({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      EdgeInsets.only(
        left: left,
        top: top,
        right: right,
        bottom: bottom,
      );

  // Common layout patterns
  static EdgeInsets get listItemPadding => const EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  static EdgeInsets get sectionPadding => const EdgeInsets.symmetric(
    horizontal: lg,
    vertical: xl,
  );

  static EdgeInsets get modalPadding => const EdgeInsets.all(lg);

  // Border radius
  static BorderRadius get borderRadiusXs => BorderRadius.circular(xs);
  static BorderRadius get borderRadiusSm => BorderRadius.circular(sm);
  static BorderRadius get borderRadiusMd => BorderRadius.circular(md);
  static BorderRadius get borderRadiusLg => BorderRadius.circular(lg);
  static BorderRadius get borderRadiusXl => BorderRadius.circular(xl);
  static BorderRadius get borderRadiusCircle => BorderRadius.circular(1000);

  // Custom border radius
  static BorderRadius get borderRadiusCard => BorderRadius.circular(12);
  static BorderRadius get borderRadiusButton => BorderRadius.circular(8);
  static BorderRadius get borderRadiusInput => BorderRadius.circular(8);
}
