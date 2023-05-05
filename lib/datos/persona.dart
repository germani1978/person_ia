import 'dart:convert';

class Persona {
  String nombre;
  int publicaciones;
  int videos;
  int horas;
  int revisitas;
  int estudios;
  int id;

  Persona({
    this.id = -1,
    this.nombre = "",
    this.publicaciones = 0,
    this.videos = 0,
    this.horas = 0,
    this.revisitas = 0,
    this.estudios = 0,
  });

  Map<String, dynamic> toMap() {
    return {
      'nombre': nombre,
      'publicaciones': publicaciones,
      'videos': videos,
      'horas': horas,
      'revisitas': revisitas,
      'estudios': estudios,
    };
  }

  factory Persona.fromMap(Map<String, dynamic> map) {
    Persona persona = Persona(
      id:map['_id'],
      nombre: map['nombre'],
      publicaciones: map['publicaciones'],
      videos: map['videos'],
      horas: map['horas'],
      revisitas: map['revisitas'],
      estudios: map['estudios'],
    );
    return persona;
  }

  List<int> toBytes() {
  List<int> bytes = utf8.encode(json.encode(toMap()));
  return bytes;
}

  void setField(String fieldName, int value) {
    switch (fieldName) {
      case 'publicaciones':
        publicaciones = value;
        break;
      case 'videos':
        videos = value;
        break;
      case 'horas':
        horas = value;
        break;
      case 'revisitas':
        revisitas = value;
        break;
      case 'estudios':
        estudios = value;
        break;
    }
  }

   int getField(String fieldName) {
    switch(fieldName) {
      case 'publicaciones':
        return publicaciones;
      case 'videos':
        return videos;
      case 'horas':
        return horas;
      case 'revisitas':
        return revisitas;
      case 'estudios':
        return estudios;
      default:
        return 0;
    }
  }
}
