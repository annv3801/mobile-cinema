import 'package:cinemax/domain/models/dto/page_tab_model.dart';
import 'package:cinemax/presentation/common_widgets/app_header_bar.dart';
import 'package:cinemax/presentation/common_widgets/app_page.dart';
import 'package:cinemax/presentation/screens/cinemas/widget/tab/list_favorite_cinemas_tab.dart';
import 'package:cinemax/presentation/screens/cinemas/widget/tab/tab_item_widget.dart';
import 'package:cinemax/presentation/screens/list_favorites/cubit/favorite_cinemas_cubit.dart';
import 'package:cinemax/presentation/screens/list_favorites/cubit/favorite_movies_cubit.dart';
import 'package:cinemax/presentation/screens/list_favorites/widget/favorite_movies_tab.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListFavoritesScreen extends StatefulWidget {
  const ListFavoritesScreen({super.key});

  @override
  State<ListFavoritesScreen> createState() => _ListFavoritesScreenState();
}

class _ListFavoritesScreenState extends State<ListFavoritesScreen> with TickerProviderStateMixin {
  late TabController _controller;
  late ValueNotifier<int> currentIndex;
  late List<PageTabModel> listTab;

  @override
  void initState() {
    super.initState();
    listTab = [
      PageTabModel(
        label: tr("cinemas"),
        child: BlocProvider(
          create: (context) => FavoriteCinemasCubit(),
          child: const ListFavoriteCinemasTab(),
        ),
      ),
      PageTabModel(
        label: tr("movie"),
        child: BlocProvider(
          create: (context) => FavoriteMoviesCubit(),
          child: const FavoriteMoviesTab(),
        ),
      ),
    ];
    _controller = TabController(length: listTab.length, vsync: this, initialIndex: 0);
    currentIndex = ValueNotifier(0);
  }

  @override
  Widget build(BuildContext context) {
    return AppPage(
      appBar: AppHeaderBar(title: tr("listFavorite")),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Column(
            children: [
              Row(
                children: List.generate(
                  listTab.length,
                  (index) => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      currentIndex.value = index;
                      _controller.animateTo(index);
                    },
                    child: ValueListenableBuilder(
                      valueListenable: currentIndex,
                      builder: (_, value, __) => TabItemWidget(label: listTab[index].label, isSelected: value == index),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _controller,
                  children: List.generate(
                    listTab.length,
                    (index) => listTab[index].child,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
