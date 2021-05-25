import 'package:flutter/material.dart';
import 'package:isolates_demo/count_isolate.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String message = '';
  bool isRunning = false;
  late CountIsolate _countIsolate;
  int valueHolder = 20;

  @override
  void initState() {
    super.initState();
    _countIsolate =
        CountIsolate(messageReceived: (message) => _updateUI(message));
  }

  _updateUI(String message) {
    setState(() {
      this.message = message;
    });
  }

  @override
  Widget build(BuildContext context) {
    isRunning = _countIsolate.running;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(child: Text(message)),
          Container(
              margin: EdgeInsets.fromLTRB(0, 100, 0, 0),
              child: Slider(
                  value: valueHolder.toDouble(),
                  min: 1,
                  max: 100,
                  divisions: 100,
                  activeColor: Colors.green,
                  inactiveColor: Colors.grey,
                  label: '${valueHolder.round()}',
                  onChanged: (double newValue) {
                    setState(() {
                      valueHolder = newValue.round();
                    });
                  },
                  semanticFormatterCallback: (double newValue) {
                    return '${newValue.round()}';
                  })),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!isRunning) {
            _countIsolate.startIsolate();
          } else {
            _countIsolate.stop();
          }
        },
        child: isRunning ? Icon(Icons.stop) : Icon(Icons.play_arrow),
      ),
    );
  }
}
