import 'package:flutter/material.dart';
import 'package:tiktaktoe/logic/logic.dart';

class TikTakHandlerWidget extends InheritedWidget {
  final TikTakToeHandler handler;
  final Widget child;

  TikTakHandlerWidget({Key key, this.handler, this.child})
      : super(key: key, child: child);

  static TikTakHandlerWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TikTakHandlerWidget>();
  }

  @override
  bool updateShouldNotify(TikTakHandlerWidget oldWidget) {
    return true;
  }
}
