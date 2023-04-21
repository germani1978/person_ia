import 'package:flutter/material.dart';
import 'package:person_ia/datos/persona.dart';


class MyData extends ChangeNotifier {
  List<Persona> _personas = [];

  get personas => _personas;

  //agregar una lista de personas
  void addPersons( List<Persona> personas) {
    _personas = personas;
    notifyListeners();
  }

  //agrega una persona
  void addPersona( Persona persona) {
    _personas.add(persona);
    notifyListeners();
  }

  //cambia una persona
  void chagePerson({required int index, required Persona persona}) {
    _personas[index] = persona;
    notifyListeners();
  }

  void del() {
    _personas = [];
  }

}