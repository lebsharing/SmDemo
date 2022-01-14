import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///管理int作为他的状态
class CounterCubit extends Cubit<int> {
  //初始化状态的初始值
  CounterCubit(int initialState) : super(initialState);

  //当方法调用的时候，状态改变并且将状态发射出去
  void increment() => emit(state + 1);

  void decrement() => emit(state - 1);

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(
        "--CounterCubit--onChange--cur:${change.currentState}  next:${change.nextState}");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print("--CounterCubit--onError");
  }
}

///Bloc---Cubit简介
class CubitPage extends StatefulWidget {
  const CubitPage({Key? key}) : super(key: key);

  @override
  _CubitPageState createState() => _CubitPageState();
}

class _CubitPageState extends State<CubitPage> {
  late CounterCubit _counterCubit;

  @override
  void initState() {
    super.initState();
    _counterCubit = CounterCubit(0);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cubit"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text("简单的使用Cubit.Cubit是通过方法来改变Cubit中的状态"),
              TextButton(
                onPressed: () {
                  _counterCubit.increment();
                  setState(() {});
                },
                child: const Text("Change"),
              ),
              Text("${_counterCubit.state}"),
            ],
          ),
        ),
      ),
    );
  }
}

///Cubit+BlockProvider+BlocBuilder
class CounterCubitPage extends StatefulWidget {
  const CounterCubitPage({Key? key}) : super(key: key);

  @override
  _CounterCubitPageState createState() => _CounterCubitPageState();
}

class _CounterCubitPageState extends State<CounterCubitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Counter"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocProvider(
          create: (ctx) => CounterCubit(0),
          child: Column(
            children: [
              const Text(
                "该实例集合Flutter Bloc中的BlocProvider和BlocBuilder，BlocProvider将"
                "CounterCubit中的值共享给子控件，子控件可以使用BlocBuilder使用共享的值",
                style: TextStyle(fontSize: 20),
              ),
              _CounterTextWidget(),
              _CounterChangeBtn(),
            ],
          ),
        ),
      ),
    );
  }
}

class _CounterTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CounterCubit, int>(builder: (ctx, count) {
      return Text(
        "$count",
        style: const TextStyle(
          color: Colors.red,
          fontSize: 30,
        ),
      );
    });
  }
}

class _CounterChangeBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        children: [
          TextButton(
            onPressed: () {
              context.read<CounterCubit>().increment();
            },
            child: const Text("Increment"),
          ),
          TextButton(
            onPressed: () {
              context.read<CounterCubit>().decrement();
            },
            child: const Text("Decrement"),
          )
        ],
      ),
    );
  }
}


