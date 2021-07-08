import 'package:event_bus/event_bus.dart';

EventBus eventBus = EventBus();

class CartDataUpdateEvent {
  @override
  String toString() {
    return "CartDataUpdateEvent";
  }
}
