import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // 🔹 Singleton
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  // 🔹 Getter do banco
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('products.db');
    return _database!;
  }

  // 🔹 Inicializar banco
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  // 🔹 Criar tabela
  Future _createDB(Database db, int version) async {
  await db.execute('''
    CREATE TABLE products (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      codigo TEXT UNIQUE,
      nome TEXT,
      preco REAL,
      imagem TEXT
    )
  ''');
}

  // ==============================
  // 🔹 INSERT
  // ==============================
  Future<int> insertProduto(Map<String, dynamic> produto) async {
    final db = await instance.database;
    return await db.insert(
      'products',
      produto,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // ==============================
  // 🔹 BUSCAR POR CÓDIGO
  // ==============================
  Future<Map<String, dynamic>?> buscarProdutoPorCodigo(String codigo) async {
    final db = await instance.database;

    final result = await db.query(
      'products',
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (result.isNotEmpty) {
      return result.first;
    }
    return null;
  }

  // ==============================
  // 🔹 BUSCAR POR NOME
  // ==============================
  Future<List<Map<String, dynamic>>> buscarProdutoPorNome(String nome) async {
    final db = await instance.database;

    return await db.query(
      'products',
      where: 'nome LIKE ?',
      whereArgs: ['%$nome%'],
    );
  }

  // ==============================
  // 🔹 LISTAR TODOS
  // ==============================
  Future<List<Map<String, dynamic>>> getAllProdutos() async {
    final db = await instance.database;
    return await db.query('products');
  }

  // ==============================
  // 🔹 UPDATE
  // ==============================
  Future<int> updateProduto(Map<String, dynamic> produto) async {
    final db = await instance.database;

    return await db.update(
      'products',
      produto,
      where: 'id = ?',
      whereArgs: [produto['id']],
    );
  }

  // ==============================
  // 🔹 DELETE
  // ==============================
  Future<int> deleteProduto(int id) async {
    final db = await instance.database;

    return await db.delete(
      'products',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // ==============================
  // 🔹 FECHAR BANCO
  // ==============================
  Future close() async {
    final db = await instance.database;
    db.close();
  }
}