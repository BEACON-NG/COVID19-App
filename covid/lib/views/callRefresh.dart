import 'package:flutter/cupertino.dart';

class CallRefresh extends InheritedWidget{
  CallRefresh({
    Key key,
    @required Widget child,
  }): super(key: key, child: child);

  bool shouldRefresh = false;
  static CallRefresh of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
//    inheritFromWidgetOfExactType(CallRefresh);

  }
  void toggleRefresh() {
    shouldRefresh = shouldRefresh == false ? true : false;
    print("color set to $shouldRefresh");
  }

  @override
  bool updateShouldNotify(CallRefresh oldWidget) =>
      shouldRefresh != oldWidget.shouldRefresh;
}