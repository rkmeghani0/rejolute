import 'package:bloc/bloc.dart';
import 'package:rejolute/util/app_utils.dart';

class EchoBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (DebugMode.isInDebugMode) print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (DebugMode.isInDebugMode) print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    if (DebugMode.isInDebugMode)
      print('onError -- ${bloc.runtimeType}, $error');
  }
}
