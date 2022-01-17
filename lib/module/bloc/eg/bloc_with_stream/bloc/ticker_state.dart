import 'package:equatable/equatable.dart';

abstract class TickerState extends Equatable {
  @override
  List<Object?> get props => [];

}
class TickerInitState extends TickerState {

}

class TickerSuccessState extends TickerState {

  int count;
  TickerSuccessState(this.count);

  @override
  List<Object?> get props => [count];
}

class TickerCompleteState extends TickerState {

}