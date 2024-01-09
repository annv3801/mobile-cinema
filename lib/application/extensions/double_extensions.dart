import 'package:cinemax/application/utils/navigation_utils.dart';
import 'package:easy_localization/easy_localization.dart';

extension DoubleExtensions on double {
  String toFormatMoney({bool hasUnit = true}) {
    final context = NavigationUtils.navigatorKey.currentContext!;

    final result = NumberFormat.currency(
      symbol: "",
      locale: EasyLocalization.of(context)!.locale.toString(),
    ).format(this);

    return "${result.trim()}${hasUnit ? tr("priceCurrency") : ""}";
  }
}
