import 'package:flutter/material.dart';
import 'package:person_ia/provider/personas_provider.dart';
import 'package:person_ia/widgets/screen_tabla.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => MyData(),
    child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Informe de Personas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScreenTabla(),
    );
  }
}



