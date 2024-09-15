import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


const Color primary = Color(0xFF0E0F1D);
const Color secondary = Color(0xFF242A32);
const Color monokai = Color(0xFF262626);
const Color neutral = Color(0xFF636363);
const Color light = Color(0xFFE8E8E8);

class Pages {
  static String get login => "login";
  static String get register => "register";

}

final List<String> paymentModes = ["Wallet", "Paystack"];

extension StringPath on String {
  String get path => "/$this";
  String get capitalize => "${substring(0, 1).toUpperCase()}${substring(1)}";
}

extension MedContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  GoRouter get router => GoRouter.of(this);
  ScaffoldMessengerState get messenger => ScaffoldMessenger.of(this);
  bool get isDark => MediaQuery.of(this).platformBrightness == Brightness.dark;
}

const String loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque feugiat at risus sit amet scelerisque. Curabitur sollicitudin tincidunt erat, sed vehicula ligula ullamcorper at. In in tortor ipsum.";
