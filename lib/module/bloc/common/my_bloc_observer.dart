import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {


  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print("--MyBlocObserver--onCreate--state:${bloc.state}");
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print("--MyBlocObserver--onClose--state:${bloc.state}");
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print("--MyBlocObserver--onError--state:${bloc.state}  error:$error");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print("--MyBlocObserver--onTransition--state:${bloc.state}  transition:$transition");
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print("--MyBlocObserver--onChange--state:${bloc.state}  change:$change");
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print("--MyBlocObserver--onEvent -- state:${bloc.state}   event:$event");
  }
}