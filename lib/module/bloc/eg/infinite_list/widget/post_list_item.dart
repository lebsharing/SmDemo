import 'package:flutter/material.dart';
import 'package:sm/module/bloc/eg/infinite_list/models/model.dart';

class PostListItemWidget extends StatelessWidget {
  final PostModel post;

  const PostListItemWidget({
    Key? key,
    required this.post,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        leading: Text("id:${post.id}"),
        title: Text(post.title),
        subtitle: Text(post.body),
      ),
    );
  }
}
