import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

///Set Up the Database

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'materials.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE materials (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      material_name TEXT,
      material_category TEXT,
      note TEXT,
      cas_number TEXT,
      relative_impact TEXT,
      odor_strength TEXT,
      molecular_weight TEXT,
      odor_description TEXT,
      remarks TEXT,
      restrictions TEXT,
      final_restriction TEXT,
      sub_materials TEXT,
      blends_well_with TEXT,
      material_info TEXT,
      category_type TEXT,
      scentree_category TEXT
    )
  ''');

    await db.execute('''
CREATE TABLE accounts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    materialname TEXT,
    formulaname TEXT,
    perfum_with_alcohol TEXT,
    need_worke TEXT,
    materialcategory TEXT,
    dilution TEXT,
    noteA TEXT,
    Quantity_of_materials TEXT,
    Quantity_from_100 TEXT,
    The_quantity_to_be_worked_on TEXT,
    amountsub TEXT,
    Relative_influence TEXT,
    smell TEXT,
    Notes TEXT,
    Restrictions TEXT,
    Registrationsub TEXT
);
''');
  }
}
