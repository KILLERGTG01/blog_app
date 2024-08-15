import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/blog_model.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  Database? _database;

  factory DatabaseService() {
    return _instance;
  }

  DatabaseService._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'blogs.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE blogs(
        id INTEGER PRIMARY KEY,
        title TEXT,
        content TEXT,
        image_url TEXT,
        is_favorite INTEGER
      )
    ''');
  }

  Future<void> insertBlog(Blog blog) async {
    final db = await database;
    await db.insert('blogs', blog.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Blog>> getBlogs() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('blogs');

    return List.generate(maps.length, (i) {
      return Blog.fromMap(maps[i]);
    });
  }

  Future<void> clearBlogs() async {
    final db = await database;
    await db.delete('blogs');
  }
}
