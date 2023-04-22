class Persona {
  String nombre;
  int publicaciones;
  int videos;
  int horas;
  int revisitas;
  int estudios;

  Persona({
    required this.nombre,
    required this.publicaciones,
    required this.videos,
    required this.horas,
    required this.revisitas,
    required this.estudios,
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
    return Persona(
      nombre: map['nombre'],
      publicaciones: map['publicaciones'],
      videos: map['videos'],
      horas: map['horas'],
      revisitas: map['revisitas'],
      estudios: map['estudios'],
    );
  }
}