// ignore_for_file: prefer_const_constructors, unused_element, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:provider/provider.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:share_plus/share_plus.dart';
import 'package:file_picker/file_picker.dart';
import 'package:receive_sharing_intent/receive_sharing_intent.dart';


import 'package:person_ia/datos/persona.dart';
import 'package:person_ia/provider/personas_provider.dart';
import 'package:person_ia/datos/database.dart';

class ScreenTabla extends StatefulWidget {
  const ScreenTabla({super.key});

  @override
  State<ScreenTabla> createState() => _ScreenTablaState();
}

class _ScreenTablaState extends State<ScreenTabla> {

@override
void initState() {
  super.initState();
  // Registra un IntentReceiver para recibir contenido compartido
  ReceiveSharingIntent.getMediaStream().listen((List<SharedMediaFile> files) {
    // Maneja el archivo compartido aquí
    handleSharedFile(files);
  });
}

void handleSharedFile(List<SharedMediaFile> files) {
  // Verifica si hay algún archivo compartido
  if (files.isNotEmpty) {
    // Obtén el primer archivo compartido
    final file = files[0].path;
    // Maneja el archivo aquí
    print('aqui');
    // ...
  }
}




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(title: const Text('Informe')),
      body: const SingleChildScrollView(
          scrollDirection: Axis.horizontal, child: ContenedorTabla()),
      floatingActionButton: _botones(context),
    );
  }

  SpeedDial _botones(BuildContext context) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_close,
      children: [
        SpeedDialChild(
          child: const Icon(Icons.accessibility),
          label: 'Agregar Persona',
          onTap: () {
            _cardToAddPerson(context);
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.delete),
          label: 'Borrar todo',
          onTap: () {
            Provider.of<MyData>(context, listen: false).del();
          },
        ),
        SpeedDialChild(
          child: const Icon(Icons.save),
          label: 'Cargar',
          onTap: _cargarFicheroJson,
        ),
        SpeedDialChild(
          child: const Icon(Icons.share),
          label: 'Compartir',
          onTap: () async {
            _compartirLista();
          },
        ),
      ],
    );
  }

  void _cargarFicheroJson() async {
    //Cargar un fichero externo
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null) {
      File file = File(result.files.single.path!);
      print('ya');
    } else {
      // No eligio nada
    }
  }

  void _compartirLista() async {
    final personas = await DatabaseHelper.instance.queryAll();
    String jsonString = jsonEncode(personas.map((p) => p.toMap()).toList());
    //Share.share(jsonString);

    final bytes = utf8.encode(jsonString);
    // await Share.shareXFiles(
    // );


  }

  _cardToAddPerson(BuildContext context) {
    final Persona persona = Persona();

    return showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: _inputPerson(persona, context),
          ),
        );
      },
    );
  }

  List<Widget> _inputPerson(Persona persona, BuildContext context) {
    return <Widget>[
      _inputName(persona),
      _inputNumero(persona, 'Ingresa el número de publicaciones', "p"),
      _inputNumero(persona, 'Ingresa el número de videos', "v"),
      _inputNumero(persona, 'Ingresa el número de horas', "h"),
      _inputNumero(persona, 'Ingresa el número de revisitas', "r"),
      _inputNumero(persona, 'Ingresa el número de estudios', "e"),
      const SizedBox(height: 20.0),
      ElevatedButton(
        //Boton agregar
        onPressed: () {
          Provider.of<MyData>(context, listen: false).addPersona(persona);
          Navigator.of(context).pop();
        },
        child: const Text('Guardar'),
      ),
    ];
  }

  TextField _inputName(Persona persona) {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Ingresa el nombre',
      ),
      onChanged: (value) {
        if (value.isEmpty) persona.nombre = "";
        persona.nombre = value;
      },
    );
  }

  TextField _inputNumero(Persona persona, String hintText, String campo) {
    return TextField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onChanged: (value) {
        if (int.tryParse(value) != null) {
          switch (campo) {
            case "p":
              (persona.publicaciones = int.parse(value));
              break;
            case "v":
              (persona.videos = int.parse(value));
              break;
            case "h":
              (persona.horas = int.parse(value));
              break;
            case "r":
              (persona.revisitas = int.parse(value));
              break;
            case "e":
              (persona.estudios = int.parse(value));
              break;
            default:
          }
        }
      },
    );
  }
}

class ContenedorTabla extends StatefulWidget {
  const ContenedorTabla({super.key});

  @override
  State<ContenedorTabla> createState() => _ContenedorTablaState();
}

class _ContenedorTablaState extends State<ContenedorTabla> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Persona>>(
        future: Provider.of<MyData>(context).personas,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return SizedBox(
                width: MediaQuery.of(context).size.width,
                child: const Center(child: CircularProgressIndicator()));
          }
          return Tabla(personas: snapshot.data!);
        });
  }
}

class Tabla extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  Tabla({
    super.key,
    required this.personas,
  });

  final List<Persona> personas;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        key: _formKey,
        child: DataTable(
          columnSpacing: 18,
          dataRowHeight: 56,
          headingRowHeight: 64.0,
          dividerThickness: 1.0,
          columns: _columunTitle,
          rows: personas
              .map((persona) => _filaCeldasTabla(persona, context))
              .toList(),
        ),
      ),
    );
  }

  List<DataColumn> get _columunTitle {
    return const [
      DataColumn(label: Text('Nombre')),
      DataColumn(label: Text('Public')),
      DataColumn(label: Text('Videos')),
      DataColumn(label: Text('Horas')),
      DataColumn(label: Text('Revisi')),
      DataColumn(label: Text('Estud')),
    ];
  }

  DataRow _filaCeldasTabla(Persona persona, BuildContext context) {
    return DataRow(cells: [
      cellNameTabla(persona),
      cellTabla(persona, context, persona.publicaciones, "publicaciones"),
      cellTabla(persona, context, persona.videos, "videos"),
      cellTabla(persona, context, persona.horas, "horas"),
      cellTabla(persona, context, persona.revisitas, "revisitas"),
      cellTabla(persona, context, persona.estudios, "estudios"),
    ]);
  }

  DataCell cellNameTabla(Persona persona) {
    return DataCell(
      TextFormField(
        initialValue: persona.nombre,
        onChanged: (value) => persona.nombre = value,
        decoration: InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  DataCell cellTabla(
      Persona persona, BuildContext context, int valorInicial, String campo) {
    return DataCell(
      TextFormField(
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.0,
        ),
        decoration: _decoracionInputDataCell(),
        initialValue: valorInicial.toString(),
        keyboardType: TextInputType.number,
        onChanged: (value) {
          switch (campo) {
            case "publicaciones":
              persona.publicaciones = int.tryParse(value) ?? 0;
              break;
            case "videos":
              persona.publicaciones = int.tryParse(value) ?? 0;
              break;
            case "horas":
              persona.publicaciones = int.tryParse(value) ?? 0;
              break;
            case "revisitas":
              persona.publicaciones = int.tryParse(value) ?? 0;
              break;
            case "estudios":
              persona.publicaciones = int.tryParse(value) ?? 0;
              break;
          }

          if (_formKey.currentState!.validate()) {
            // Provider.of<MyData>(context).addPersona(persona);
            //si hay algun cambio en la celda y no hay error se puede guardar aqui en sqlite
          }
        },
        validator: validacion,
      ),
    );
  }

  InputDecoration _decoracionInputDataCell() {
    return InputDecoration(
      hintText: "0",
      hintStyle: TextStyle(
        color: Colors.grey[500],
        fontStyle: FontStyle.italic,
      ),
      border: UnderlineInputBorder(
        borderSide: BorderSide.none,
      ),
    );
  }

  String? validacion(value) {
    if (value == null || value.isEmpty) {
      return null;
    }
    final RegExp regExp = RegExp(r'^[0-9]+$');
    if (!regExp.hasMatch(value)) {
      return 'Error';
    }
    return null;
  }
}
