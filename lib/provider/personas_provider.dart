import 'package:flutter/material.dart';
import 'package:person_ia/datos/database.dart';
import 'package:person_ia/datos/persona.dart';


class MyData extends ChangeNotifier {

  Future<List<Persona>> get personas async {
    return await DatabaseHelper.instance.queryAll(); 
  } 

  Future<void> addPersonas( List<Persona> personas)  async {
    for (var persona in personas)  { 
      await DatabaseHelper.instance.insert(persona);
    }
    notifyListeners();
  }

  void addPersona( Persona persona) async{
    await DatabaseHelper.instance.insert(persona);
    notifyListeners();
  }

  void del() {
    DatabaseHelper.instance.deleteAll();
    notifyListeners();
  }

}