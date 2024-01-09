import 'package:flutter/material.dart';

class HomePageModel {
  final String name;
  final String selectedIconUrl;
  final String unselectedIconUrl;
  final Widget child;

  const HomePageModel({
    required this.name,
    required this.selectedIconUrl,
    required this.unselectedIconUrl,
    required this.child,
  });
}