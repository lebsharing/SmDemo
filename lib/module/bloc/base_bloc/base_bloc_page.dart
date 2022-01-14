import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


abstract class CounterEvent {}

//通知让变量增加的事件
class CounterIncrementPressed extends CounterEvent {}

class CounterSubtractionPressed extends CounterEvent {}

class CounterBloc extends Bloc<CounterEvent, int> {
  CounterBloc(int initialState) : super(initialState) {
    // on((event, emit) => emit(state + 1));
    on((event, emit) {
      print("--CounterBloc--on-$event");
      if (event is CounterIncrementPressed) {
        emit(state + 1);
      } else if (event is CounterSubtractionPressed) {
        emit(state - 1);
      } else {
        emit(state + 10);
      }
    });
  }

  @override
  void onEvent(CounterEvent event) {
    super.onEvent(event);
    print("--CounterBloc--onEvent  $event");
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    print("--CounterBloc--onError");
  }

  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print("--CounterBloc--onChange  $change");
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    super.onTransition(transition);
    print("--CounterBloc--onTransition  $transition");
  }
}


///Bloc中bloc的使用
class BaseBlocPage extends StatefulWidget {
  const BaseBlocPage({Key? key}) : super(key: key);

  @override
  _BaseBlocPageState createState() => _BaseBlocPageState();
}

class _BaseBlocPageState extends State<BaseBlocPage> {
  late CounterBloc _counterBloc;

  @override
  void initState() {
    super.initState();
    _counterBloc = CounterBloc(0);
  }

  @override
  void dispose() {
    super.dispose();
    _counterBloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc"),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      _counterBloc.add(CounterIncrementPressed());
                      setState(() {});
                    },
                    child: const Text("Increment"),
                  ),
                  TextButton(
                    onPressed: () {
                      _counterBloc.add(CounterSubtractionPressed());
                      setState(() {});
                    },
                    child: const Text("Subtraction"),
                  ),
                ],
              ),
              Text(
                "${_counterBloc.state}",
                style: const TextStyle(
                  fontSize: 30,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class CounterBlocPage extends StatefulWidget {
  const CounterBlocPage({Key? key}) : super(key: key);

  @override
  _CounterBlocPageState createState() => _CounterBlocPageState();
}

class _CounterBlocPageState extends State<CounterBlocPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc"),
      ),
      body: Padding(padding: const EdgeInsets.all(16),
        child: BlocProvider(
          create: (BuildContext context) {
            return CounterBloc(0);
          },
          child: Column(
            children: [
              const Text(
                "该实例集合Flutter Bloc中的BlocProvider和BlocBuilder，BlocProvider将"
                    "CounterBloc中的值共享给子控件，子控件可以使用BlocBuilder使用共享的值",
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
    return BlocBuilder<CounterBloc, int>(builder: (ctx, count) {
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
              context.read<CounterBloc>().add(CounterIncrementPressed());
            },
            child: const Text("Increment"),
          ),
          TextButton(
            onPressed: () {
              context.read<CounterBloc>().add(CounterSubtractionPressed());
            },
            child: const Text("Decrement"),
          )
        ],
      ),
    );
  }
}


