import 'package:cinemax/application/constants/app_colors.dart';
import 'package:cinemax/domain/models/arguments/movie_detail_arguments.dart';
import 'package:cinemax/domain/models/response/movies/movie_response.dart';
import 'package:cinemax/presentation/common_widgets/app_text.dart';
import 'package:cinemax/presentation/common_widgets/movie_item/widget/vertical_movie_thumbnail.dart';
import 'package:cinemax/presentation/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class VerticalMovieItem extends StatelessWidget {
  final MovieResponse item;
  final double? width;

  const VerticalMovieItem({
    super.key,
    required this.item,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final movieWidth = width ?? 150.w;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteName.movieDetail,
          arguments: MovieDetailArguments(movieId: item.id),
        );
      },
      child: SizedBox(
        width: movieWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VerticalMovieThumbnail(width: movieWidth, url: item.thumbnailUrl),
            SizedBox(height: 8.h),
            AppText(
              "${item.name.toUpperCase()} \n",
              fontSize: 14.sp,
              color: AppColors.black,
              fontWeight: FontWeight.bold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 3.h),
            AppText(
              item.genre,
              fontSize: 12.sp,
              color: AppColors.gray9F,
              fontWeight: FontWeight.w500,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
