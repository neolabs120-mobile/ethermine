import 'package:ethermine/coinminerviewmodel.dart';
import 'package:flutter/material.dart';

class ApiProvider extends InheritedWidget {
  final Coinapi api;

  const ApiProvider({
    Key? key,
    required this.api,
    required Widget child,
}) : super(key : key, child: child);

  static ApiProvider? of(BuildContext context) {
    final ApiProvider? result = context.dependOnInheritedWidgetOfExactType<ApiProvider>();
    assert(result != null, 'No CoinApi found in context');
    return result;
  }

  @override
  bool updateShouldNotify(ApiProvider oldWidget) {
    return oldWidget.api != api;
  }
}