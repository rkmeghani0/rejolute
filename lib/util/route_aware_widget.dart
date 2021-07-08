import 'package:flutter/material.dart';
import 'package:rejolute/my_app.dart';

class RouteAwareWidget extends StatefulWidget {
  final String? name;
  final Widget? child;

  RouteAwareWidget(this.name, {@required this.child});

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

// Implement RouteAware in a widget's state and subscribe it to the RouteObserver.
class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  // Called when the current route has been pushed.
  void didPush() {
    //FirebaseAnalyticsHelper().setCurrentScreen(widget.name);
    print('didPush ${widget.name}');
  }

  @override
  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {
    // FirebaseAnalyticsHelper().customEvent(
    //     eventName: "popScreen", parameter: {"screen name": widget.name});
    print('didPopNext ${widget.name}');
  }

  @override
  Widget build(BuildContext context) => widget.child!;
}
