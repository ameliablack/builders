import 'dart:async';
import 'counter_block_action.dart';

class CounterBloc {
  int _count = 0;

  StreamController<CounterAction> _inputStreamController = StreamController();
  StreamController<int> _outputStreamController = StreamController.broadcast();

  Sink<CounterAction> get input => _inputStreamController.sink;

  Stream<int> get output => _outputStreamController.stream;

  CounterBloc() {
    _inputStreamController.stream.listen(handleMessage);
  }

  void handleMessage(CounterAction event) {
    if (event == CounterAction.Increment) {
      _count++;
    } else {
      _count--;
    }
    _outputStreamController.sink.add(_count);
  }
}
