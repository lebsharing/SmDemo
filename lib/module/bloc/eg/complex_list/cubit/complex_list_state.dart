import 'package:equatable/equatable.dart';
import 'package:sm/module/bloc/eg/complex_list/model/Item.dart';

enum ListStatus { loading, success, failure }

class ComplexListState extends Equatable {
  final List<Item> data;
  final ListStatus status;

  const ComplexListState({this.data = const [], required this.status});

  const ComplexListState.loading() : this(status: ListStatus.loading);

  const ComplexListState.success(List<Item> data)
      : this(data: data, status: ListStatus.success);

  const ComplexListState.failure() : this(status: ListStatus.failure);

  @override
  List<Object?> get props => [data, status];
}
