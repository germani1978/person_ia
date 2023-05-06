import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class EjemploDeArchivo extends StatefulWidget {
  @override
  _EjemploDeArchivoState createState() => _EjemploDeArchivoState();
}

class _EjemploDeArchivoState extends State<EjemploDeArchivo> {
  String _nombreArchivo = "datos.json";
  String _contenidoArchivo = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ejemplo de archivo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Contenido del archivo:"),
            Text(_contenidoArchivo),
            ElevatedButton(
              child: Text("Escribir en archivo"),
              onPressed: () {
                _escribirEnArchivo();
              },
            ),
            ElevatedButton(
              child: Text("Leer archivo"),
              onPressed: () {
                _leerArchivo();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _obtenerRutaDirectorio() async {
    // Obtenemos el directorio temporal de la aplicación
    final directorio = await getTemporaryDirectory();
    // Obtenemos la ruta completa del directorio
    final rutaDirectorio = directorio.path;
    // Devolvemos la ruta del directorio
    return rutaDirectorio;
  }

  Future<File> _obtenerArchivo() async {
    // Obtenemos la ruta del directorio
    final rutaDirectorio = await _obtenerRutaDirectorio();
    // Creamos la ruta completa del archivo
    final rutaArchivo = '$rutaDirectorio/$_nombreArchivo';
    // Abrimos el archivo
    final archivo = File(rutaArchivo);
    // Devolvemos el archivo
    return archivo;
  }

  Future<void> _escribirEnArchivo() async {
    final archivo = await _obtenerArchivo();
    final jsonString = '{"nombre": "Juan", "edad": 30}';
    await archivo.writeAsString(jsonString);
  }

  Future<void> _leerArchivo() async {
    try {
      final archivo = await _obtenerArchivo();
      final contenido = await archivo.readAsString();
      setState(() {
        _contenidoArchivo = contenido;
      });
    } catch (e) {
      print("Error al leer el archivo: $e");
    }
  }
}
