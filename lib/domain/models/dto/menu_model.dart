import 'package:cinemax/gen/assets.gen.dart';

class MenuModel {
  final String title;
  final SvgGenImage icon;
  final String? routeName;

  const MenuModel({
    required this.title,
    required this.icon,
    this.routeName,
  });
}
