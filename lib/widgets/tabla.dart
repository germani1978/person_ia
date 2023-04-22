// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:person_ia/datos/persona.dart';


class Tabla extends StatefulWidget {

  final List<Persona> personas;
  const Tabla({super.key, required this.personas});

  @override
  State<Tabla> createState() => _TablaState();
}

class _TablaState extends State<Tabla> {
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Informe'),
        ),
        body: SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: DatosWidget(personas: widget.personas)));
  }
}

class DatosWidget extends StatefulWidget {
  final List<Persona> personas;
  
  const DatosWidget({
    super.key, required this.personas,
  });

  @override
  State<DatosWidget> createState() => _DatosWidgetState();
}

class _DatosWidgetState extends State<DatosWidget> {

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: [
        DataColumn(label: Text('Nombre')),
        DataColumn(label: Text('Publicaciones')),
        DataColumn(label: Text('Videos')),
        DataColumn(label: Text('Horas')),
        DataColumn(label: Text('Revisitas')),
        DataColumn(label: Text('Estudios')),
      ],
      rows: widget.personas
          .map((persona) => DataRow(cells: [
                DataCell(TextFormField(
                  initialValue: persona.nombre,
                  onSaved: (value) => persona.nombre = value ?? '',
                )),
                DataCell(TextFormField(
                  initialValue: persona.publicaciones.toString(),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    if (value.isEmpty) {
                      persona.publicaciones = 0;
                    } else {
                      persona.publicaciones = int.parse(value);
                    }
                  },
                  onEditingComplete: () {
                    setState(() {});
                  },
                )),
                DataCell(TextFormField(
                  initialValue: persona.videos.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => persona.videos = int.parse(value ?? '0'),
                )),
                DataCell(TextFormField(
                  initialValue: persona.horas.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) => persona.horas = int.parse(value ?? '0'),
                )),
                DataCell(TextFormField(
                  initialValue: persona.revisitas.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      persona.revisitas = int.parse(value ?? '0'),
                )),
                DataCell(TextFormField(
                  initialValue: persona.estudios.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) =>
                      persona.estudios = int.parse(value ?? '0'),
                )),
              ]))
          .toList(),
    );
  }
}

