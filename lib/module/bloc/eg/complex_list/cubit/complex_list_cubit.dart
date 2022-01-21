import 'package:bloc/bloc.dart';
import 'package:sm/module/bloc/eg/complex_list/cubit/complex_list_state.dart';
import 'package:sm/module/bloc/eg/complex_list/list_repository.dart';
import 'package:sm/module/bloc/eg/complex_list/model/Item.dart';

class ComplexListCubit extends Cubit<ComplexListState> {
  ListRepository repository;

  ComplexListCubit({required this.repository})
      : super(const ComplexListState.loading());

  Future<void> fetchData() async {
    try {
      List<Item> data = await repository.fetchList();
      emit(ComplexListState.success(data));
    } on Exception {
      emit(const ComplexListState.failure());
    }
  }

  Future<bool?> deleteItem(int id) async {
    List<Item> inDelete = state.data.map((e) {
      return id == e.id ? e.copyWith(deleting: true) : e;
    }).toList();
    emit(ComplexListState.success(inDelete));

    return repository.deleteItem(id).then((_) {
      List<Item> result = List.of(state.data)
        ..removeWhere((item) => item.id == id);
      emit(ComplexListState.success(result));
      return Future.value(true);
    });
  }
}
