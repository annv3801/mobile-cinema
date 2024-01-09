import 'package:cinemax/application/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppLoadMore extends StatefulWidget {
  final Function? onRefresh;
  final Function? onLoadMore;
  final Widget child;

  const AppLoadMore({
    super.key,
    this.onRefresh,
    this.onLoadMore,
    required this.child,
  });

  @override
  State<AppLoadMore> createState() => _AppLoadMoreState();
}

class _AppLoadMoreState extends State<AppLoadMore> {
  final RefreshController _refreshController = RefreshController();
  late bool enablePullUp;
  late bool enablePullDown;

  @override
  void initState() {
    super.initState();
    enablePullUp = widget.onLoadMore != null;
    enablePullDown = widget.onRefresh != null;
  }

  Future<void> _onRefresh() async {
    if (enablePullDown) {
      widget.onRefresh!.call();
      _refreshController.refreshCompleted();
    }
  }

  Future<void> _onLoadMore() async {
    if (enablePullUp) {
      widget.onLoadMore!.call();
      _refreshController.loadComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullUp: enablePullUp,
      enablePullDown: enablePullDown,
      header: const MaterialClassicHeader(color: AppColors.main),
      onRefresh: _onRefresh,
      onLoading: _onLoadMore,
      footer: const ClassicFooter(loadStyle: LoadStyle.HideAlways),
      child: widget.child,
    );
  }
}
