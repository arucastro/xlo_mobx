import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import '/keys/constaints.dart'; //keys

void main() async{
  runApp(const MyApp());

  await Parse().initialize(
      keyApi,
      'https://parseapi.back4app.com/',
      clientKey: clientKey,
    autoSendSessionId: true,
    debug: true,
  );

  /*final category = ParseObject('Categories')..set('Title', 'Camisetas')..set('Position', 2);
  final response = await category.save();
  print (response.success);*/
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}


