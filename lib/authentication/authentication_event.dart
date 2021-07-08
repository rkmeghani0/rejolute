import 'package:rejolute/util/base_equatable.dart';

abstract class AuthenticationEvent extends BaseEquatable {}

class AppStartedEvent extends AuthenticationEvent {
  @override
  String toString() {
    return "AppStartedEvent";
  }
}

class LoggedInEvent extends AuthenticationEvent {
  // bool isRegister = false;
  // LoggedInEvent({this.isRegister});
  @override
  String toString() {
    return "LoggedInEvent";
  }
}

class LoggedOutEvent extends AuthenticationEvent {
  @override
  String toString() {
    return "LoggedOutEvent";
  }
}
