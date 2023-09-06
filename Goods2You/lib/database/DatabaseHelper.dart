import 'package:ecommerce/Screens/product.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();
  factory DatabaseHelper() => instance;

  static Database? _database;

  final String tableName = 'favorites'; // Define the tableName property

  DatabaseHelper.internal();
  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'favorites_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
          CREATE TABLE favorites(
            id INTEGER PRIMARY KEY,
            title TEXT,
            description TEXT,
            price REAL,
            discountPercentage REAL,
            rating REAL,
            stock INTEGER,
            brand TEXT,
            category TEXT,
            thumbnail TEXT,
            images TEXT,
            isFavorite INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertFavorite(Product product) async {
    final db = await database;
    return await db.insert('favorites', product.toMap());
  }

  Future<List<Product>> getFavorites() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('favorites');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }

  Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> updateFavorite(Product product) async {
    final db = await database;
    await db.update(
      tableName,
      product.toMap(),
      where: 'id = ?',
      whereArgs: [product.id],
    );
  }
}
