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
            description TEXT,
            author TEXT,
            authorImage TEXT,
            date TEXT,
            takesTime TEXT
          )
        ''');

        await db.execute('''
          CREATE TABLE Community (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            imageId TEXT,
            name TEXT,
            description TEXT,
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

        await db.insert('Community', {
          'imageId': '2Jjq1O_2_pc',
          'name': 'The Problem With Indian Economy | Indian Economy | Econ',
          'description':
              'The Indian economy is grappling with various challenges that have impeded its growth trajectory. Issues such as unemployment, income inequality, and the impact of global economic fluctuations pose significant hurdles, requiring comprehensive policy measures for sustainable economic development in India.',
          'author': 'Econ',
          'authorImage': 'assets/communities/author1.jpg',
          'date': '2023-02-14',
          'takesTime': '11 mins'
        });
        await db.insert('Community', {
          'imageId': 'EJHPltmAULA',
          'name':
              'Explore the essential principles of Finance and Economics crucial for businesses in our comprehensive Crash Course, covering topics from budgeting strategies to market analysis, equipping you with the foundational knowledge needed to navigate the dynamic world of business finance.',
          'description': '2Jjq1O_2_pc',
          'author': 'freeCodeCamp.org',
          'authorImage': 'assets/communities/author2.jpg',
          'date': '2023-09-12',
          'takesTime': '1 h 38 mins'
        });
        await db.insert('Community', {
          'imageId': '5vZjrxE8Wlc',
          'name': '7 Passive Income Ideas - How I Make \$67k per Week',
          'description':
              'Exploring various passive income streams has been a game-changer for me, allowing me to generate a weekly income of \$67k effortlessly through innovative investment strategies and online ventures.',
          'author': 'Mark Tilbury',
          'authorImage': 'assets/communities/author3.jpg',
          'date': '2023-05-09',
          'takesTime': '26 mins'
        });

        // News
        await db.insert('News', {
          'imageId': 'assets/news/image/news1.jpg',
          'name':
              'Where Did All the Money Go? The Villain in Your Transaction History',
          'description':
              'If you want to rein in your spending in 2024, financial advisers say you first need to sort out where inflation ends and lifestyle creep begins.',
          'author': 'Julia Carpenter',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-25',
          'takesTime': '6 mins'
        });
        await db.insert('News', {
          'imageId': 'assets/news/image/news2.jpg',
          'name':
          'A Yearlong Way to Boost Stock-Market Returns',
          'description':
          'Investors generally wait too long to harvest tax losses from their portfolios, leaving billions on the table. In the world of investing, it\'s a common tendency for investors to procrastinate when it comes to harvesting tax losses from their portfolios. Unfortunately, this delay often results in substantial amounts of money being left on the table. The practice of tax-loss harvesting involves strategically selling investments at a loss to offset capital gains, thereby reducing the overall tax liability. However, the failure to act promptly on this strategy means that potential tax advantages go unrealized, costing investors billions in potential savings. Successful investors recognize the importance of timely tax management as an integral part of their overall investment strategy.',
          'author': 'Spencer Jakab',
          'authorImage': 'assets/news/author/author1.png',
          'date': '2023-12-25',
          'takesTime': '2 mins'
        });
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchIncomeData() async {
    final Database db = await database;
    return await db.query('Income');
  }
}
