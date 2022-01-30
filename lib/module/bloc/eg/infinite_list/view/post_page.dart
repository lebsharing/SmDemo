import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:sm/module/bloc/eg/infinite_list/bloc/post_bloc.dart';
import 'package:sm/module/bloc/eg/infinite_list/bloc/post_event.dart';
import 'package:sm/module/bloc/eg/infinite_list/view/post_list.dart';

class PostPage extends StatefulWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post Infinite list"),
      ),
      body: BlocProvider<PostBloc>(
        create: (ctx){
          return PostBloc(client: http.Client())..add(PostFetchEvent());
        },
        child: const PostListWidget(),
      ),
    );
  }
}
