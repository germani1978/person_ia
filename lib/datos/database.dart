import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:person_ia/datos/persona.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const _databaseName = 'personas_database.db';
  static const _databaseVersion = 1;

  static const table = 'personas';

  static const columnId = '_id';
  static const columnNombre = 'nombre';
  static const columnPublicaciones = 'publicaciones';
  static const columnVideos = 'videos';
  static const columnHoras = 'horas';
  static const columnRevisitas = 'revisitas';
  static const columnEstudios = 'estudios';

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnNombre TEXT NOT NULL,
        $columnPublicaciones INTEGER NOT NULL,
        $columnVideos INTEGER NOT NULL,
        $columnHoras INTEGER NOT NULL,
        $columnRevisitas INTEGER NOT NULL,
        $columnEstudios INTEGER NOT NULL
      )
    ''');
  }

  Future<int> insert(Persona persona) async {
    Database db = await instance.database;
    return await db.insert(table, persona.toMap());
  }

  Future<Persona> queryById(int id) async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps =
        await db.query(table, where: '$columnId = ?', whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Persona.fromMap(maps.first);
    } else {
      throw Exception('ID $id no encontrado en la base de datos');
    }
  }

  Future<List<Persona>> queryAll() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(table);
    print(maps);
    return List.generate(maps.length, (i) => Persona.fromMap(maps[i]));
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

  deleteAll() async {
    Database db = await instance.database;
    db.delete(table);
  }

  Future<void> update(Persona persona) async {
    Database db = await instance.database;
    db.update(table, {

    },
    where: 'id = ?',
    whereArgs: [persona.id]);
  }



}
