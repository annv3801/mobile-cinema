import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/payment_method.dart';
import 'package:cinemax/application/extensions/payment_method_extensions.dart';
import 'package:cinemax/presentation/common_widgets/app_check_box.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/screens/booking_checkout/booking_checkout_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PaymentMethodWidget extends StatefulWidget {
  const PaymentMethodWidget({super.key});

  @override
  State<PaymentMethodWidget> createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(tr("paymentMethod"), fontSize: 15.sp, fontWeight: FontWeight.w700, color: AppColors.black),
          SizedBox(height: 10.h),
          BlocBuilder<BookingCheckoutCubit, BookingCheckoutState>(
            buildWhen: (previous, current) => previous.paymentMethod != current.paymentMethod,
            builder: (context, state) => Column(
              children: List.generate(
                PaymentMethod.values.length,
                (index) => _buildPaymentMethodItem(
                  PaymentMethod.values[index],
                  isSelected: state.paymentMethod == PaymentMethod.values[index],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPaymentMethodItem(PaymentMethod item, {bool isSelected = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          item.icon.image(width: 20.r, height: 20.r),
          SizedBox(width: 10.w),
          Expanded(
            child: AppText(
              tr("payWith", namedArgs: {"paymentMethod": item.name}),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
            ),
          ),
          SizedBox(width: 10.w),
          AppCheckBox(
            isChecked: isSelected,
            activeColor: AppColors.main,
            checkColor: AppColors.white,
            borderColor: AppColors.main,
            size: 20.r,
            borderRadius: 20.r,
            onChanged: () {
              context.read<BookingCheckoutCubit>().onChangePaymentMethod(item);
            },
          ),
        ],
      ),
    );
  }
}
