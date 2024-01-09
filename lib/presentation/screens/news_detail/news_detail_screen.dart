import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/domain/models/arguments/news_detail_arguments.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/screens/news_detail/news_detail_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsDetailArguments arguments;

  const NewsDetailScreen({super.key, required this.arguments});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  late NewsDetailCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<NewsDetailCubit>(context);
    _cubit.getNewsDetail(widget.arguments.newsId);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppHeaderBar(title: tr("news")),
      body: SafeArea(
        child: BlocBuilder<NewsDetailCubit, NewsDetailState>(
          buildWhen: (prev, curr) => prev.getNewsDetailStatus != curr.getNewsDetailStatus,
          builder: (context, state) {
            if (state.getNewsDetailStatus == LoadStatus.loading) {
              return Center(child: AppLoadingIndicator(sizeLoading: 40.r));
            }

            if (state.getNewsDetailStatus == LoadStatus.failure) {
              return Center(
                child: AppText(
                  state.getNewsDetailMessage ?? "",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.black,
                  textAlign: TextAlign.center,
                ),
              );
            }

            if (state.getNewsDetailStatus == LoadStatus.success) {
              final createdDate = DateFormat('hh:mm, dd/MM/yyyy').format(state.newsDetail!.createdTime ?? DateTime.now());

              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(
                      state.newsDetail!.title,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.main,
                    ),
                    SizedBox(height: 10.h),
                    AppText(
                      state.newsDetail!.description,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                    SizedBox(height: 10.h),
                    AppText(
                      createdDate,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gray4D,
                    ),
                    SizedBox(height: 15.h),
                    Html(
                      data: state.newsDetail!.refactorContent,
                      onLinkTap: (url, _, __) async {
                        final canLaunch = await canLaunchUrl(Uri.parse(url ?? ""));
                        if (canLaunch) {
                          launchUrl(Uri.parse(url ?? ""));
                        }
                      },
                      style: {
                        "body": Style(margin: Margins.all(0)),
                        "span": Style(
                          color: Theme.of(context).primaryColor,
                          fontSize: FontSize(12.sp),
                          fontFamily: "Manrope",
                        ),
                      },
                    ),

                  ],
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
