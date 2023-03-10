
import 'package:flutter/material.dart';

extension ListWidgetExtensions on List<Widget>
{
  Row toRow(
      {MainAxisSize mainAxisSize = MainAxisSize.max,
        MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center}) =>
      Row(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: this,
      );

  Column toColumn(
      { MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
        CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
        MainAxisSize mainAxisSize = MainAxisSize.max}) =>
      Column(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: this,
      );
}