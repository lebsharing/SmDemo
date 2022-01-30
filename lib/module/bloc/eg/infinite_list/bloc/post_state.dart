import 'package:equatable/equatable.dart';
import 'package:sm/module/bloc/eg/infinite_list/models/model.dart';

enum PostStatus { initial, success, failed }

class PostState extends Equatable {
  final PostStatus status;
  final List<PostModel> postList;
  final bool hasReachedMax;

  const PostState(
      {this.postList = const <PostModel>[],
      this.status = PostStatus.initial,
      this.hasReachedMax = false});

  PostState copyWith(
      {List<PostModel>? post, PostStatus? status, bool? hasReachedMax}) {
    return PostState(
      postList: post ?? postList,
      status: status ?? this.status,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [status, postList, hasReachedMax];
}
