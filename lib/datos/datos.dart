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
}

List<Persona> personas = [
    Persona(
      nombre: 'Juan',
      publicaciones: 10,
      videos: 5,
      horas: 20,
      revisitas: 3,
      estudios: 2,
    ),
    Persona(
      nombre: 'Maria',
      publicaciones: 15,
      videos: 8,
      horas: 30,
      revisitas: 5,
      estudios: 3,
    ),
    Persona(
      nombre: 'Pedro',
      publicaciones: 8,
      videos: 3,
      horas: 15,
      revisitas: 2,
      estudios: 1,
    ),
  ];