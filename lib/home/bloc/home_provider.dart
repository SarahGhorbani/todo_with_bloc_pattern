import 'package:flutter/cupertino.dart';

import 'home_bloc.dart';

class HomeProvider extends InheritedWidget {
  final HomeBloc bloc;

  const HomeProvider(this.bloc, {Key? key, required Widget child}): super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static HomeBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<HomeProvider>()!.bloc;
  }
}
