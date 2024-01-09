import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/di.dart';
import 'package:cinemax/domain/models/arguments/movie_detail_arguments.dart';
import 'package:cinemax/presentation/common_widgets/app_network_image.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/home/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletons/skeletons.dart';

class HomeCarouselSliderWidget extends StatefulWidget {
  const HomeCarouselSliderWidget({super.key});

  @override
  State<HomeCarouselSliderWidget> createState() => _HomeCarouselSliderWidgetState();
}

class _HomeCarouselSliderWidgetState extends State<HomeCarouselSliderWidget> {
  final _cubit = getIt<HomeCubit>();
  final currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    final height = 180.h;

    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      buildWhen: (prev, curr) => prev.getCarouselSliderStatus != curr.getCarouselSliderStatus,
      builder: (context, state) {
        if (state.getCarouselSliderStatus == LoadStatus.loading) {
          return Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            height: height,
            child: SkeletonLine(
              style: SkeletonLineStyle(
                width: double.infinity,
                height: height,
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          );
        }

        if (state.getCarouselSliderStatus == LoadStatus.success && state.listCarouselSlider.isNotEmpty) {
          return SizedBox(
            width: double.infinity,
            height: height,
            child: Stack(
              children: [
                CarouselSlider(
                  options: CarouselOptions(
                    viewportFraction: 1.0,
                    height: height,
                    enlargeCenterPage: false,
                    autoPlay: true,
                    onPageChanged: (page, _) {
                      currentPage.value = page;
                    },
                  ),
                  items: List.generate(
                    state.listCarouselSlider.length,
                    (index) => GestureDetector(
                      onTap: () {
                        if (state.listCarouselSlider[index].objectId != 0) {
                          Navigator.of(context).pushNamed(
                            RouteName.movieDetail,
                            arguments: MovieDetailArguments(movieId: state.listCarouselSlider[index].objectId),
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.r),
                          child: AppNetworkImage(
                            state.listCarouselSlider[index].imageUrl,
                            width: double.infinity,
                            height: height,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  width: 1.sw,
                  bottom: 5.h,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      state.listCarouselSlider.length,
                      (index) => ValueListenableBuilder(
                        valueListenable: currentPage,
                        builder: (_, value, __) => _buildDotted(value == index),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildDotted(bool isSelected) {
    return Opacity(
      opacity: isSelected ? 1 : 0.5,
      child: Container(
        width: 7.r,
        height: 7.r,
        margin: EdgeInsets.symmetric(horizontal: 2.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15.r),
        ),
      ),
    );
  }
}
