import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:sm/module/bloc/eg/bloc_with_stream/bloc/ticker_event.dart';
import 'package:sm/module/bloc/eg/bloc_with_stream/bloc/ticker_state.dart';
import 'package:sm/module/bloc/eg/bloc_with_stream/model/ticker.dart';

class TickerBloc extends Bloc<TickerEvent, TickerState> {
  TickerBloc(Ticker ticker) : super(TickerInitState()) {
    on<TickerStartEvent>((event, emit) async {
      await emit.onEach<int>(ticker.tick(), onData: (tick) {
        print("-----tick:$tick");
        add(TickerTicked(count: tick));
      });
      emit(TickerCompleteState());
    },transformer: restartable());

    on<TickerTicked>((event, emit) => emit(TickerSuccessState(event.count)));
  }
}
