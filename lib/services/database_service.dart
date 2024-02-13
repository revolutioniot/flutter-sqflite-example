import 'package:flutter_sqflite_example/models/breed.dart';
import 'package:flutter_sqflite_example/models/dog.dart';
import 'package:flutter_sqflite_example/models/prorole.dart';
import 'package:flutter_sqflite_example/models/protask.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'flutter_sqflite_database2.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  // When the database is first created, create a table to store breeds
  // and a table to store dogs.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE protask TABLE statement on the database.
    await db.execute(
      'CREATE TABLE protask(id INTEGER PRIMARY KEY, processdefinitionid INTEGER, userid INTEGER,issuedate TEXT,completedate TEXT,isueuserid INTEGER, description TEXT, usergroupid INTEGER, repeat BOOLEAN)',
    );
    // Run the CREATE prorole TABLE statement on the database.
    await db.execute(
    'CREATE TABLE prorole(id INTEGER PRIMARY KEY, description TEXT,active BOOLEAN, rightid INTEGER)',
    );
    // Run the CREATE {breeds} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE breeds(id INTEGER PRIMARY KEY, name TEXT, description TEXT)',
    );
    // Run the CREATE {dogs} TABLE statement on the database.
    await db.execute(
      'CREATE TABLE dogs(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, color INTEGER, breedId INTEGER, FOREIGN KEY (breedId) REFERENCES breeds(id) ON DELETE SET NULL)',
    );
    
  }

  // Define a function that inserts protasks into the database
  Future<void> insertProtask(Protask protask) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Insert the Protask into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same protask is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'protask',
      protask.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  // A method that retrieves all the protasks from the protasks table.
  Future<List<Protask>> protasks() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Protask.
    final List<Map<String, dynamic>> maps = await db.query('protask');

    // Convert the List<Map<String, dynamic> into a List<Protask>.
    return List.generate(maps.length, (index) => Protask.fromMap(maps[index]));
  }

  Future<Protask> protask(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('protasks', where: 'id = ?', whereArgs: [id]);
    return Protask.fromMap(maps[0]);
  }


  // A method that updates a protask data from the protasks table.
  Future<void> updateProtask(Protask protask) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given protask
    await db.update(
      'protasks',
      protask.toMap(),
      // Ensure that the Protask has a matching id.
      where: 'id = ?',
      // Pass the Protask's id as a whereArg to prevent SQL injection.
      whereArgs: [protask.id],
    );
  }

  // A method that deletes a protask data from the protasks table.
  Future<void> deleteProtask(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the Protask from the database.
    await db.delete(
      'protasks',
      // Use a `where` clause to delete a specific protask.
      where: 'id = ?',
      // Pass the Protask's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  // Define a function that inserts breeds into the database
  Future<void> insertBreed(Breed breed) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Insert the Breed into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same breed is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'breeds',
      breed.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertDog(Dog dog) async {
    final db = await _databaseService.database;
    await db.insert(
      'dogs',
      dog.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the breeds from the breeds table.
  Future<List<Breed>> breeds() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Breeds.
    final List<Map<String, dynamic>> maps = await db.query('breeds');

    // Convert the List<Map<String, dynamic> into a List<Breed>.
    return List.generate(maps.length, (index) => Breed.fromMap(maps[index]));
  }

  Future<Breed> breed(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('breeds', where: 'id = ?', whereArgs: [id]);
    return Breed.fromMap(maps[0]);
  }

  Future<List<Dog>> dogs() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('dogs');
    return List.generate(maps.length, (index) => Dog.fromMap(maps[index]));
  }

  // A method that updates a breed data from the breeds table.
  Future<void> updateBreed(Breed breed) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given breed
    await db.update(
      'breeds',
      breed.toMap(),
      // Ensure that the Breed has a matching id.
      where: 'id = ?',
      // Pass the Breed's id as a whereArg to prevent SQL injection.
      whereArgs: [breed.id],
    );
  }

  Future<void> updateDog(Dog dog) async {
    final db = await _databaseService.database;
    await db.update('dogs', dog.toMap(), where: 'id = ?', whereArgs: [dog.id]);
  }

  // A method that deletes a breed data from the breeds table.
  Future<void> deleteBreed(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the Breed from the database.
    await db.delete(
      'breeds',
      // Use a `where` clause to delete a specific breed.
      where: 'id = ?',
      // Pass the Breed's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteDog(int id) async {
    final db = await _databaseService.database;
    await db.delete('dogs', where: 'id = ?', whereArgs: [id]);
  }

  // Define a function that inserts proroles into the database
  Future<void> insertProrole(Prorole prorole) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Insert the Prorole into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same prorole is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'prorole',
      prorole.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }


  // A method that retrieves all the proroles from the proroles table.
  Future<List<Prorole>> proroles() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Prorole.
    final List<Map<String, dynamic>> maps = await db.query('prorole');

    // Convert the List<Map<String, dynamic> into a List<Prorole>.
    return List.generate(maps.length, (index) => Prorole.fromMap(maps[index]));
  }

  Future<Prorole> prorole(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('proroles', where: 'id = ?', whereArgs: [id]);
    return Prorole.fromMap(maps[0]);
  }


  // A method that updates a prorole data from the proroles table.
  Future<void> updateProrole(Prorole prorole) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given prorole
    await db.update(
      'proroles',
      prorole.toMap(),
      // Ensure that the Prorole has a matching id.
      where: 'id = ?',
      // Pass the Prorole's id as a whereArg to prevent SQL injection.
      whereArgs: [prorole.id],
    );
  }

  // A method that deletes a prorole data from the proroles table.
  Future<void> deleteProrole(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the Prorole from the database.
    await db.delete(
      'proroles',
      // Use a `where` clause to delete a specific prorole.
      where: 'id = ?',
      // Pass the Prorole's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
