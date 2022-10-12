// ignore_for_file: prefer_const_declarations, non_constant_identifier_names
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final table = 'flutter_profileData';
  static final Id = '_id';
  static final firstName = 'first_name';
  static final middleName = 'middle_name';
  static final lastName = 'last_name';
  static final mobileNo = 'mobile_no';
  static final email = 'email';

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  // make this a singleton class
  DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "flutter_profileData.db");
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $Id INTEGER PRIMARY KEY,   
            $firstName  TEXT NOT NULL, 
            $middleName TEXT NOT NULL,
            $lastName TEXT NOT NULL,
            $mobileNo TEXT NOT NULL,
            $email TEXT NOT NULL
          )
          ''');
  }

  Future<int> insertProfile(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryAllRowsLogin() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int?> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

  Future<int> updateProfile(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[Id];
    return await db.update(table, row, where: '$Id = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$Id = ?', whereArgs: [id]);
  }

  Future<List<dynamic>> getAllRecordProfile() async {
    var dbClient = await instance.database;
    var result = await dbClient.rawQuery("SELECT * FROM $table");

    return result.toList();
  }
}
