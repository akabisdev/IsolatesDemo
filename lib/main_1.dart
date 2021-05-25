// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'dart:isolate';
//
// void main() => runApp(new MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new MaterialApp(
//       title: 'Flutter Isolate Demo',
//       theme: new ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: new MyHomePage(title: 'Demo',),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   // const MyHomePage({Key key, this.title}) : super(key: key);
//   final String title;
//
//   const MyHomePage({Key? key, this.title = ''}) : super(key: key);
//
//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late Isolate _isolate;
//   bool _running = false;
//   static int _counter = 0;
//   String notification = "";
//   late ReceivePort _receivePort;
//
//   void _start() async {
//     _running = true;
//     _receivePort = ReceivePort();
//     _isolate = await Isolate.spawn(_checkTimer, _receivePort.sendPort);
//     _receivePort.listen(_handleMessage, onDone:() {
//       print("done!");
//     });
//   }
//
//   static void _checkTimer(SendPort sendPort) async {
//     Timer.periodic(new Duration(seconds: 1), (Timer t) {
//       _counter++;
//       String msg = 'notification ' + _counter.toString();
//       print('SEND: ' + msg);
//       sendPort.send(msg);
//     });
//   }
//
//   void _handleMessage(dynamic data) {
//     print('RECEIVED: ' + data);
//     setState(() {
//       notification = data;
//     });
//   }
//
//   void _stop() {
//     if (_isolate != null) {
//       setState(() {
//         _running = false;
//         notification = '';
//       });
//       _receivePort.close();
//       _isolate.kill(priority: Isolate.immediate);
//       // _isolate = null;
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       appBar: new AppBar(
//         title: new Text(widget.title),
//       ),
//       body: new Center(
//         child: new Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             new Text(
//               notification,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: new FloatingActionButton(
//         onPressed: _running ? _stop : _start,
//         tooltip: _running ? 'Timer stop' : 'Timer start',
//         child: _running ? new Icon(Icons.stop) : new Icon(Icons.play_arrow),
//       ),
//     );
//   }
// }