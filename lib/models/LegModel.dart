import 'package:flutter/material.dart';

class LegModel {
  IconData iconData;
  Color iconColor;
  Color topLineColor;
  Color bottomLineColor;
  String time;
  String address;
  bool isFirst;
  bool isLast;
  bool isMiddle;
  IconData modeIcon;
  Color modeIconBackgroundColor;
  String mode;
  String distance;

  LegModel(
      this.iconData,
      this.iconColor,
      this.time,
      this.address, {
        this.topLineColor,
        this.bottomLineColor,
        this.isFirst = false,
        this.isLast = false,
        this.isMiddle = false,
        this.modeIcon,
        this.modeIconBackgroundColor,
        this.mode,
        this.distance,
      }) {
    if (isFirst) {
      assert(bottomLineColor != null);
    } else if (isLast) {
      assert(topLineColor != null);
    } else if (isMiddle) {
      assert(topLineColor != null);
      assert(bottomLineColor != null);
    }

    if (!isLast) {
      assert(modeIcon != null && distance != null && mode != null);
    }
  }
}
