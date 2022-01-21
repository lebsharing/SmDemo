import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm/module/bloc/eg/complex_list/cubit/complex_list_cubit.dart';
import 'package:sm/module/bloc/eg/complex_list/cubit/complex_list_state.dart';
import 'package:sm/module/bloc/eg/complex_list/list_repository.dart';

import 'model/Item.dart';

class ComplexListPage extends StatefulWidget {
  const ComplexListPage({Key? key}) : super(key: key);

  @override
  _ComplexListPageState createState() => _ComplexListPageState();
}

class _ComplexListPageState extends State<ComplexListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Complex List"),
      ),
      body: RepositoryProvider<ListRepository>(
        create: (context) => ListRepository(),
        // child: _ComplexListWidget(),
        child: _ComplexListProvider(),
      ),
    );
  }
}

class _ComplexListProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<ComplexListCubit>(
      create: (context) => ComplexListCubit(
        repository: context.read<ListRepository>(),
      )..fetchData(),
      lazy: false,
      child: _ComplexListContentWidget(),
    );
  }
}

class _ComplexListContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ComplexListState state = context.watch<ComplexListCubit>().state;
    switch (state.status) {
      case ListStatus.failure:
        return const Center(child: Text("Oops, something went wrong!"));
      case ListStatus.success:

        ///方式一： 直接这样使用，当前的context找不到Provider，思考与方式而的不同
        // return _ComplexListWidget();
        ///方式二
        return _ContentViewWidget();
      default:
        return const Center(
            child: CircularProgressIndicator(
          color: Colors.blue,
        ));
    }
  }
}

class _ContentViewWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ComplexListCubit, ComplexListState>(
        builder: (bCtx, state) {
      List<Item> data = state.data;
      return ListView.builder(
        itemBuilder: (bContext, index) {
          return _ItemViewWidget(
            item: data[index],
          );
        },
        itemCount: data.length,
      );
    });
  }
}

class _ComplexListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<Item> data = context.watch<ComplexListState>().data;
    return ListView.builder(
      itemBuilder: (bContext, index) {
        return _ItemViewWidget(
          item: data[index],
        );
      },
      itemCount: data.length,
    );
  }
}

class _ItemViewWidget extends StatelessWidget {
  final Item item;

  const _ItemViewWidget({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
      ),
      child: Row(
        children: [
          Text("#${item.id}"),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text("Item ${item.name}"),
            ),
          ),
          GestureDetector(
            onTap: () async {
              //删除数据
              bool? result =
                  await context.read<ComplexListCubit>().deleteItem(item.id);
              print("-------$result");
              if (result == true) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "delete success.",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }
            },
            child: item.deleting
                ? const SizedBox(
                    width: 30,
                    height: 30,
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: CircularProgressIndicator(
                        color: Colors.orange,
                      ),
                    ),
                  )
                : const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
          ),
        ],
      ),
    );
  }
}
