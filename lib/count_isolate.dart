import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';

typedef StringTypeDef = Function(String data);

class CountIsolate {
  static final CountIsolate _countIsolate = CountIsolate._internal();
  late StringTypeDef messageReceived;

  factory CountIsolate({required StringTypeDef messageReceived}) {
    _countIsolate.messageReceived = messageReceived;
    return _countIsolate;
  }

  CountIsolate._internal();

  static int _count = 0;
  late Isolate _isolate;
  bool _isRunning = false;
  late ReceivePort _receivePort;

  bool get running => _isRunning;

  void startIsolate() async {
    _isRunning = true;
    _receivePort = ReceivePort();
    _isolate = await Isolate.spawn(_startCount, _receivePort.sendPort);
    _receivePort.listen(
      _handleMessage,
      onDone: () {
        print('Done');
        _countIsolate.messageReceived('Done');
      },
    );
  }

  static void _startCount(SendPort sendPort) async {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _count++;
      String message = 'Count : $_count';
      sendPort.send(message);
    });
  }

  void _handleMessage(dynamic data) {
    _countIsolate.messageReceived(data.toString());
  }

  void stop() {
    _isRunning = false;
    _receivePort.close();
    _isolate.kill(priority: Isolate.immediate);
  }
}
