import 'package:flutter/material.dart';

abstract class BaseController<S> extends ChangeNotifier {
  BaseController(this._state);

  S _state;

  S get state => _state;

  void emit(S state) {
    _state = state;
    _notifierListenersState();
  }

  final List<void Function(S state)> _stateListeners = [];

  void subscribeFromState(void Function(S state) listener) {
    if (!_stateListeners.contains(listener)) {
      _stateListeners.add(listener);
    }
  }

  void _notifierListenersState() {
    for (var listener in _stateListeners) {
      listener.call(_state);
    }
    notifyListeners();
  }

  void unsubscribeFromState(void Function(S state) listener) {
    _stateListeners.remove(listener);
  }

  @override
  void dispose() {
    _stateListeners.clear();
    super.dispose();
  }
}
