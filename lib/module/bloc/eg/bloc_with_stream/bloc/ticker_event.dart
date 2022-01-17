import 'package:equatable/equatable.dart';

class TickerEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TickerInitEvent extends TickerEvent {}

class TickerStartEvent extends TickerEvent {}

class TickerTicked extends TickerEvent {
  final int count;

  TickerTicked({required this.count});

  @override
  List<Object?> get props => [count];
}

class TickerCompleteEvent extends TickerEvent {

}
