import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm/module/bloc/eg/infinite_list/bloc/post_bloc.dart';
import 'package:sm/module/bloc/eg/infinite_list/bloc/post_event.dart';
import 'package:sm/module/bloc/eg/infinite_list/bloc/post_state.dart';
import 'package:sm/module/bloc/eg/infinite_list/widget/bottom_loader.dart';
import 'package:sm/module/bloc/eg/infinite_list/widget/post_list_item.dart';

class PostListWidget extends StatefulWidget {
  const PostListWidget({Key? key}) : super(key: key);

  @override
  _PostListWidgetState createState() => _PostListWidgetState();
}

class _PostListWidgetState extends State<PostListWidget> {
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (_isBottom) {
      print("----------------load more-----------");
      context.read<PostBloc>().add(PostFetchEvent());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    print("***max:$maxScroll   cur:$currentScroll   ");
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController.removeListener(scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(builder: (ctx, state) {
      if (state.status == PostStatus.failed) {
        return const Center(
          child: Text("failed to fetch data"),
        );
      } else if (state.status == PostStatus.success) {
        if (state.postList.isEmpty) {
          return const Center(
            child: Text("no datas"),
          );
        } else {
          return ListView.builder(
            itemBuilder: (bCtx, index) {
              return index >= state.postList.length
                  ? const BottomLoader()
                  : PostListItemWidget(post: state.postList[index]);
            },
            itemCount: state.hasReachedMax
                ? state.postList.length
                : state.postList.length + 1,
            controller: _scrollController,
          );
        }
      } else {
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.orange,
          ),
        );
      }
    });
  }
}
