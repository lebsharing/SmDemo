import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:http/http.dart';
import 'package:sm/module/bloc/eg/infinite_list/bloc/post_event.dart';
import 'package:sm/module/bloc/eg/infinite_list/bloc/post_state.dart';
import 'package:sm/module/bloc/eg/infinite_list/models/model.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc({required this.client}) : super(const PostState()) {
    on<PostFetchEvent>(
      _onPostFetched,
      // transformer:
    );
  }

  final Client client;

  Future<void> _onPostFetched(
      PostFetchEvent event, Emitter<PostState> emit) async {
    print("--hasReachedMax:${state.hasReachedMax}");
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final posts = await _fetchPosts();
        return emit(state.copyWith(
          post: posts,
          status: PostStatus.success,
          hasReachedMax: false,
        ));
      }
      final posts = await _fetchPosts(state.postList.length);
      posts.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(state.copyWith(
              // post: posts,
              post: state.postList..addAll(posts),
              hasReachedMax: false,
              status: PostStatus.success,
            ));
    } catch (e) {
      emit(state.copyWith(status: PostStatus.failed));
    }
  }

  Future<List<PostModel>> _fetchPosts([int startIndex = 0]) async {
    final response = await client.get(Uri.https(
      "jsonplaceholder.typicode.com",
      "/posts",
      <String, String>{"_start": "$startIndex", "_limit": "20"},
    ));
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((e) {
        return PostModel(
          id: e["id"] as int,
          title: e["title"] as String,
          body: e["body"] as String,
        );
      }).toList();
    }
    throw Exception("error fetching posts");
  }
}
