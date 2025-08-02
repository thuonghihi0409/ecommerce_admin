import 'package:flutter/material.dart';

extension SizedBoxX on int {
  Widget get h => SizedBox(height: toDouble());
  Widget get w => SizedBox(width: toDouble());
}

extension ContextX on BuildContext {
  double get heightScreen {
    return MediaQuery.of(this).size.height;
  }

  double get widthScreen {
    return MediaQuery.of(this).size.width;
  }

  //Get the bottom inset of the screen when the keyboard is showing
  double get viewBottomInset {
    return MediaQuery.of(this).viewInsets.bottom;
  }

  double get safeViewBottom {
    double bottom = MediaQuery.of(this).viewPadding.bottom;
    return bottom + (bottom > 0 ? 0 : 10);
  }

  double get safeViewTop {
    double top = MediaQuery.of(this).viewPadding.top;
    return top;
  }
}

extension StringX on String {
  /// Get the filename of the URL.
  String get name {
    return split('/').last;
  }

  String get formatThousands {
    return replaceAll(',', '');
  }

  //Uppercase the first letter of the string
  String get toUppercaseFirstLetter {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

extension TimeExtractor on String {
  int? extractTimeInSeconds() {
    final regex = RegExp(r"(\d+)\s*(seconds?|minutes?)", caseSensitive: false);
    final match = regex.firstMatch(this);
    if (match != null) {
      int value = int.parse(match.group(1)!);
      String unit = match.group(2)!.toLowerCase();
      return unit.contains("second") ? value : value * 60;
    }
    return null;
  }
}
