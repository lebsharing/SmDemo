import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sm/module/bloc/eg/bloc_with_stream/bloc/ticker_bloc.dart';
import 'package:sm/module/bloc/eg/bloc_with_stream/bloc/ticker_event.dart';
import 'package:sm/module/bloc/eg/bloc_with_stream/bloc/ticker_state.dart';
import 'package:sm/module/bloc/eg/bloc_with_stream/model/ticker.dart';

///test
class TestMain extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider<TickerBloc>(
        create: (ctx) {
          return TickerBloc(Ticker());
        },
        child: const Timer2Page(),
      ),
    );
  }
}

class BlocWithStreamContentPage extends StatefulWidget {
  const BlocWithStreamContentPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BlocWithStreamContentPageState();
  }
}

class _BlocWithStreamContentPageState extends State<BlocWithStreamContentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bloc with Stream"),
      ),
      body: BlocProvider<TickerBloc>(
        create: (ctx) {
          return TickerBloc(Ticker());
        },
        child: _ContentWidget(),
      ),
    );
  }
}

class TimerPage extends StatefulWidget {
  const TimerPage({Key? key}) : super(key: key);

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _ContentWidget(),
    );
  }
}

class Timer2Page extends StatelessWidget {
  const Timer2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _ContentWidget(),
    );
  }
}

class _ContentWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContentWidgetState();
  }
}

class _ContentWidgetState extends State<_ContentWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ///实现方式一，以该种方式加入子Widget,
        ///TODO 研究一下Provider原理
        /////Error: Could not find the correct Provider<StateStreamable<Object?>> above this BlocBuilder<StateStreamable<Object?>, Object?> Widget
        //
        // This happens because you used a `BuildContext` that does not include the provider
        // of your choice. There are a few common scenarios:
        // Container(
        //   child: BlocBuilder(
        //     builder: (ctx, state) {
        //       if (state is TickerSuccessState) {
        //         return Text("${state.count}");
        //       } else if (state is TickerCompleteState) {
        //         return const Text(
        //             "Complete! Press the floating button to restart.");
        //       }
        //       return const Text("Press the floating button to start.");
        //     },
        //   ),
        // ),
        // ElevatedButton(
        //   onPressed: () {
        //     context.read<TickerBloc>().add(TickerStartEvent());
        //   },
        //   child: const Icon(Icons.timer),
        // ),
        ///实现方式二，可以通过context找到正确的值。
        _ContentWidget2(),
      ],
    );
  }
}

class _ContentWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 60,
          child: BlocBuilder<TickerBloc, TickerState>(
            builder: (ctx, state) {
              print("-----$state");
              if (state is TickerSuccessState) {
                return Text("${state.count}");
              } else if (state is TickerCompleteState) {
                return const Text(
                    "Complete! Press the floating button to restart.");
              }
              return const Text("Press the floating button to start.");
            },
          ),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<TickerBloc>().add(TickerStartEvent());
          },
          child: const Icon(Icons.timer),
        ),
      ],
    );
  }
}
