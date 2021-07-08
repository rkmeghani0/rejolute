import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rejolute/authentication/authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  bool isIos = Platform.isIOS;

  AuthenticationBloc() : super(AuthenticationUninitializedState());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    // eventBus.on<UnAuthenticatedEvent>().listen((event) {
    //   add(LoggedOutEvent());
    // });
    if (event is AppStartedEvent) {
      yield AuthenticationSplashScreen();
      await Future.delayed(Duration(seconds: 1));
      yield AuthenticationMedicalScreenSate();
    }
  }
}
