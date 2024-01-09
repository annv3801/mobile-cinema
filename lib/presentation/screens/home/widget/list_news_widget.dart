import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/arguments/news_detail_arguments.dart';
import 'package:cinemax/domain/models/response/news/news_response.dart';
import 'package:cinemax/presentation/common_widgets/app_loading_indicator.dart';
import 'package:cinemax/presentation/common_widgets/app_network_image.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/home/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class ListNewsWidget extends StatefulWidget {
  const ListNewsWidget({super.key});

  @override
  State<ListNewsWidget> createState() => _ListNewsWidgetState();
}

class _ListNewsWidgetState extends State<ListNewsWidget> {
  final _homeCubit = getIt<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
      child: BlocBuilder<HomeCubit, HomeState>(
        bloc: _homeCubit,
        buildWhen: (prev, curr) => prev.getListNewsStatus != curr.getListNewsStatus,
        builder: (context, state) {
          if (state.getListNewsStatus == LoadStatus.loading) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(tr("news"), fontSize: 16.sp, color: AppColors.black, fontWeight: FontWeight.w700),
                SizedBox(height: 5.h),
                Column(children: List.generate(3, (index) => _buildNewsLoadingItem()))
              ],
            );
          }

          if (state.getListNewsStatus == LoadStatus.success && state.listNews.isNotEmpty) {
            return BlocBuilder<HomeCubit, HomeState>(
              bloc: _homeCubit,
              buildWhen: (prev, curr) => prev.getMoreNewsStatus != curr.getMoreNewsStatus || prev.listNews != curr.listNews,
              builder: (context, state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(tr("news"), fontSize: 16.sp, color: AppColors.black, fontWeight: FontWeight.w700),
                    SizedBox(height: 5.h),
                    Column(
                      children: List.generate(
                        state.listNews.length,
                        (index) => _buildNewsItem(state.listNews[index]),
                      ),
                    ),
                    if (state.getMoreNewsStatus == LoadStatus.loading)
                      Container(
                        margin: EdgeInsets.only(top: 5.h),
                        child: const AppLoadingIndicator(),
                      ),
                  ],
                );
              },
            );
          }

          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildNewsItem(NewsResponse news) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteName.newsDetail,
          arguments: NewsDetailArguments(newsId: news.id),
        );
      },
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppNetworkImage(
              news.thumbnailUrl,
              width: double.infinity,
              height: 150.h,
              fit: BoxFit.cover,
              radius: 16.r,
            ),
            SizedBox(height: 8.h),
            AppText(
              news.title,
              fontSize: 14.sp,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsLoadingItem() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              width: double.infinity,
              height: 150.h,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          SizedBox(height: 8.h),
          SkeletonLine(
            style: SkeletonLineStyle(
              width: double.infinity,
              height: 15.h,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          SizedBox(height: 2.h),
          SkeletonLine(
            style: SkeletonLineStyle(
              width: 200.w,
              height: 15.h,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
        ],
      ),
    );
  }
}
