// ignore_for_file: unused_field

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:person_ia/datos/database.dart';
import 'package:person_ia/provider/personas_provider.dart';
import 'package:person_ia/screen/screen_tabla.dart';
import 'package:provider/provider.dart';
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
