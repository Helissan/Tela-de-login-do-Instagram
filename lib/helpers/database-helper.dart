import 'dart:async';
import 'dart:io';
import 'package:meuapp/models/users.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String userTable = 'users';
  String colInd = 'ind';
  String colEmail = 'email';
  String colName = 'name';
  String colUsername = 'username';
  String colPassword = 'password';
  
  DatabaseHelper._createInstance();

  factory DatabaseHelper(){
    if (_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'users.database';

    var usersDatabase = await openDatabase(
      path, 
      version:1, 
      onCreate: _createdatabase
      );
    return usersDatabase;
  }

  void _createdatabase(Database database, int newVersion) async {
    await database.execute(
      'CREATE TABLE $userTable($colInd INTEGER PRIMARY KEY AUTOINCREMENT, $colEmail TEXT, '
      '$colName TEXT, $colUsername TEXT, $colPassword TEXT)');
  }

  Future<int> insertUsers(Users users) async {
    Database database = await this.database;
    
    var resultado = await database.insert(userTable, users.toMap());
    return resultado;
  }

  Future<Users> getUser(int ind) async {
    Database database = await this.database;

    List<Map> maps = await database.query(userTable,
    columns: [colInd, colEmail, colName, colUsername, colPassword],
    where: "$colInd = ?",
    whereArgs: [ind]);

    if(maps.length > 0){
      return Users.fromMap(maps.first);
    }else{
      return null;
    }
  }

  Future<List<Users>> getUsers() async {
    Database database = await this.database;

    var resultado = await database.query(userTable);

    List<Users> lista = resultado.isNotEmpty ? resultado.map((c) => Users.fromMap(c)).toList() : [];

    return lista;
  }

  Future<int> updateUsers(Users users) async {
    var database = await this.database;

    var resultado = 
      await database.update(userTable, users.toMap(),
      where: '$colInd = ?',
      whereArgs: [users.ind]);
  return resultado;
  }

  Future<int> deleteUsers(int ind) async {
    var database = await this.database;

    int resultado =
    await database.delete(userTable,
    where: "$colInd = ?",
    whereArgs: [ind]);
  return resultado;
  }

  Future<int> getCount() async {
    Database database = await this.database;

    List<Map<String, dynamic>> x = await database.rawQuery('SELECT COUNT (*) from $userTable');
    int resultado = Sqflite.firstIntValue(x);
    return resultado;
  }

  Future close() async {
    Database database = await this.database;
    database.close();
  }
}