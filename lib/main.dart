import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:xlo_mobx/screens/base/base_screen.dart';
import '/keys/constaints.dart'; //keys

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeParse();
  runApp(const MyApp());

}

Future<void> initializeParse() async {
  await Parse().initialize(
    keyApi, //
    'https://parseapi.back4app.com/',
    clientKey: clientKey,
    autoSendSessionId: true,
    debug: true,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'XLO',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BaseScreen(),
    );
  }
}
