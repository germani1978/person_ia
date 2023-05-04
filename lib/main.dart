import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:person_ia/provider/personas_provider.dart';
import 'package:person_ia/screen/screen_tabla.dart';
import 'package:provider/provider.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';
import 'package:share_plus/share_plus.dart';
import 'datos/persona.dart';


void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => MyData(), child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription _intentDataStreamSubscription;
  late List<SharedMediaFile> _sharedFiles;
  late String _sharedText;

  @override
  void initState() {
    super.initState();

    Future<List<Persona>> readPersonasFromXFile(XFile xFile) async {
      List<Persona> personas = [];
      Uint8List data = await xFile.readAsBytes();
      ByteData? bytes = (await xFile.readAsBytes()) as ByteData?;

      if (bytes != null) {
        List<int> intList = bytes.buffer.asUint8List();
        String jsonString = utf8.decode(intList);
        List<dynamic> jsonList = json.decode(jsonString);

        personas = jsonList.map((jsonObject) => Persona.fromMap(jsonObject)).toList();
      }

      return personas;
    }

    // For sharing images coming from outside the app while the app is closed
    ReceiveSharingIntent.getInitialMedia().then((List<SharedMediaFile> value) {
      setState(() async {
        _sharedFiles = value;
        if (value.isNotEmpty) {
          // XFile file = _sharedFiles;
          final xFile = XFile(_sharedFiles[0].path);
          await readPersonasFromXFile(xFile);
        }
      });
    });

  }

  @override
  void dispose() {
    _intentDataStreamSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Informe de Personas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ScreenTabla(),
    );
  }
}
