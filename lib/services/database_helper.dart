import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/area.dart';

class DatabaseHelper {
  static const _databaseName = 'khu_vuc_database.db';
  static const _table = 'khu_vuc';
  static const _columnId = 'id';
  static const _columnTenArea = 'ten_khu_vuc';
  static const _columnLoaiCayTrong = 'loai_cay_trong';
  static const _columnAnh = 'anh';

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  late Database _db;

  DatabaseHelper._internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await _initDb();
    return _db;
  }

  Future<Database> _initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_table (
        $_columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $_columnTenArea TEXT,
        $_columnLoaiCayTrong TEXT,
        $_columnAnh TEXT
      )
    ''');
  }

  Future<void> insertArea(Area area) async {
    final db = await this.db;
    await db.insert(_table, area.toMap());
  }

  Future<List<Area>> getAreas() async {
    final db = await this.db;
    final List<Map<String, dynamic>> maps = await db.query(_table);

    return List.generate(maps.length, (i) {
      return Area.fromMap(maps[i]);
    });
  }
}