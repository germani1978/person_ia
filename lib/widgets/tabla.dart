// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../datos/datos.dart';

class Tabla extends StatefulWidget {
  const Tabla({super.key});

  @override
  State<Tabla> createState() => _TablaState();
}

class _TablaState extends State<Tabla> {

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informe'),
      ),
      body: Center(child: SizedBox(
        width: 300,
        height: 240,
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Escribe algo aqui 1'
              ),
              onEditingComplete: (){
                setState(() {
                  _controller.text = 'EditComplete 1';
                  print('1');
                });
              },
              // focusNode: FocusScope.of(context).unfocus(),
                onTap: (){

                },
            

            ),
            TextFormField(
              decoration: InputDecoration(
                hintText: 'Escribe algo aqui 2',
              ),
              
              
            ),
          ],
        ),
      )),
    );
  }
}
/*
TextEditingController _controller = TextEditingController();

TextFormField(
  controller(
    hintText: 'Escribe algo aquí...',
  ),
  onEditingComplete: () {
    setState(() {
      _controller.text = 'Texto agregado';
    });
  },
  onFieldSubmitted: (value) {
    setState(() {
      _controller.text = 'Texto agregado';
    });
  },
)

 */


class Campo extends StatelessWidget {
  const Campo({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(

    );
  }
}

class DatosWidget extends StatefulWidget {
  const DatosWidget({
    super.key,
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
      rows: personas
          .map((persona) => DataRow(cells: [
                DataCell(TextFormField(
                  initialValue: persona.nombre,
                  onSaved: (value) => persona.nombre = value ?? '',
                )),
                DataCell(TextFormField(
                  initialValue: persona.publicaciones.toString(),
                  keyboardType: TextInputType.number,
                  onSaved: (value) {
                    if (value == null || value.isEmpty) {
                      persona.publicaciones = 0;
                    } else {
                      persona.publicaciones = int.parse(value);
                    }
                  },
                  onEditingComplete: (){
                    setState(() {
                      
                    });
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

