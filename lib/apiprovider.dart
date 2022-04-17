import 'package:ethermine/coinminerviewmodel.dart';
import 'package:flutter/material.dart';

class ApiProvider extends InheritedWidget {
  final CoinViewModel viewModel;

  const ApiProvider({
    Key? key,
    required this.viewModel,
    required Widget child,
}) : super(key : key, child: child);

  static ApiProvider? of(BuildContext context) {
    final ApiProvider? result = context.dependOnInheritedWidgetOfExactType<ApiProvider>();
    assert(result != null, 'No CoinApi found in context');
    return result;
  }

  @override
  bool updateShouldNotify(ApiProvider oldWidget) {
    return true;
  }
}