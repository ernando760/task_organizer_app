import 'package:flutter/material.dart';

import '../controller/base_controller.dart';

class ControllerStateBuilderWidget<S> extends StatefulWidget {
  const ControllerStateBuilderWidget({
    super.key,
    required this.controller,
    required this.builder,
    this.listener,
  });

  final BaseController<S> controller;

  final Widget Function(BuildContext context, S state) builder;

  final void Function(S state)? listener;

  @override
  State<ControllerStateBuilderWidget<S>> createState() =>
      _ControllerStateBuilderWidgetState<S>();
}

class _ControllerStateBuilderWidgetState<S>
    extends State<ControllerStateBuilderWidget<S>> {
  @override
  void initState() {
    super.initState();
    if (widget.listener != null) {
      widget.controller.subscribeFromState(widget.listener!);
    }
  }

  @override
  void dispose() {
    if (widget.listener != null) {
      widget.controller.unsubscribeFromState(widget.listener!);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        return widget.builder(context, widget.controller.state);
      },
    );
  }
}
