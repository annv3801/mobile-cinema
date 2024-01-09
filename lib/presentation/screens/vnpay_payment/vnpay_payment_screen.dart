import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VnPayPaymentScreen extends StatefulWidget {
  final Uri url;

  const VnPayPaymentScreen({super.key, required this.url});

  @override
  State<VnPayPaymentScreen> createState() => _VnPayPaymentScreenState();
}

class _VnPayPaymentScreenState extends State<VnPayPaymentScreen> {
  late WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..loadRequest(widget.url)
      ..setNavigationDelegate(NavigationDelegate(
        onNavigationRequest: (request) {
          final url = Uri.parse(request.url);
          final queryParams = url.queryParametersAll;
          final responseCode = queryParams["vnp_ResponseCode"]?[0];

          if (responseCode == "00") {
            Navigator.of(context).pop(true);
            return Future.value(NavigationDecision.prevent);
          }

          if (responseCode == "24") {
            Navigator.of(context).pop(false);
            return Future.value(NavigationDecision.prevent);
          }

          return Future.value(NavigationDecision.navigate);
        },
      ));
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.white,
        child: WebViewWidget(controller: _controller),
      ),
    );
  }
}
