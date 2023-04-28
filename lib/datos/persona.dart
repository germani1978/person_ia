class Persona {
  String nombre;
  int publicaciones;
  int videos;
  int horas;
  int revisitas;
  int estudios;

  Persona({
    int? id,
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
