import 'package:cinemax/application/enums/payment_method.dart';
import 'package:cinemax/gen/assets.gen.dart';
import 'package:easy_localization/easy_localization.dart';

extension PaymentMethodExtensions on PaymentMethod {
  String get name {
    switch (this) {
      case PaymentMethod.cash:
        return tr("cash");
      case PaymentMethod.vnPay:
        return tr("vnPay");
    }
  }

  AssetGenImage get icon {
    switch (this) {
      case PaymentMethod.cash:
        return Assets.icons.icCash;
      case PaymentMethod.vnPay:
        return Assets.icons.icVnpay;
    }
  }
}
