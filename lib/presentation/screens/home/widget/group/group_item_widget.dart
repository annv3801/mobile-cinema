import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/application/enums/load_status.dart';
import 'package:cinemax/domain/models/arguments/list_movies_arguments.dart';
import 'package:cinemax/domain/models/response/home/group_response.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/vertical_movie_item.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/vertical_movie_loading_item.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:cinemax/presentation/screens/home/home_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GroupItemWidget extends StatefulWidget {
  final GroupResponse group;

  const GroupItemWidget({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupItemWidget> createState() => _GroupItemWidgetState();
}

class _GroupItemWidgetState extends State<GroupItemWidget> {
  late HomeCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<HomeCubit>(context);
    _cubit.getListMoviesByGroup(widget.group.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      bloc: _cubit,
      buildWhen: (previous, current) => previous.getListMoviesByGroupStatus != current.getListMoviesByGroupStatus,
      builder: (context, state) {
        if (state.getListMoviesByGroupStatus == LoadStatus.loading) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: AppText(widget.group.title, fontSize: 16.sp, color: AppColors.black, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: 1.sw,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(3, (index) {
                      return Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        child: const VerticalMovieLoadingItemWidget(),
                      );
                    }),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
            ],
          );
        }

        if (state.getListMoviesByGroupStatus == LoadStatus.success && state.listMoviesByGroup.isNotEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 1.sw,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: AppText(
                        widget.group.title,
                        fontSize: 16.sp,
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (state.listMoviesByGroup.length > 3)
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            RouteName.listMovies,
                            arguments: ListMoviesArguments(groupId: widget.group.id, title: widget.group.title),
                          );
                        },
                        child: AppText(tr("viewAll"), fontSize: 14.sp, color: AppColors.main, fontWeight: FontWeight.w600),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),
              SizedBox(
                width: 1.sw,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      state.listMoviesByGroup.length,
                      (index) => Container(
                        margin: EdgeInsets.symmetric(horizontal: 6.w),
                        child: VerticalMovieItem(item: state.listMoviesByGroup[index]),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25.h),
            ],
          );
        }

        return const SizedBox();
      },
    );
  }
}
