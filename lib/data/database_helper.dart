import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'banksy.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE News (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageId TEXT,
            name TEXT,
            author TEXT,
            date TEXT,
            takesTime TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE Community (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageId TEXT,
            name TEXT,
            author TEXT,
            authorImage TEXT,
            date TEXT,
            takesTime TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE Income (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            amount REAL,
            description TEXT
          )
        ''');

        await db.insert('Community', {'imageId': '2Jjq1O_2_pc', 'name': 'The Problem With Indian Economy | Indian Economy | Econ', 'author': 'Econ', 'date': '14/02/2023', 'takesTime': '11 mins'});
        await db.insert('Community', {'imageId': 'EJHPltmAULA', 'name': 'Fundamentals of Finance & Economics for Businesses – Crash Course', 'author': 'freeCodeCamp.org', 'date': '12/09/2023', 'takesTime': '1 h 38 mins'});
        await db.insert('Community', {'imageId': '5vZjrxE8Wlc', 'name': '7 Passive Income Ideas - How I Make \$67k per Week', 'author': 'Mark Tilbury', 'date': '09/05/2023', 'takesTime': '26 mins'});
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchIncomeData() async {
    final Database db = await database;
    return await db.query('Income');
  }
}
