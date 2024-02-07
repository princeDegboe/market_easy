import 'package:e_com_app/models/product.dart';
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart' as path;

class LocalDb {
  Future<Database> createDb() async {
    var dbPath = await sql.getDatabasesPath();
    final db = await sql.openDatabase(
      path.join(dbPath, "produit.db"),
      onCreate: (db, version) async {
        await db.execute(
          """CREATE TABLE favoris (
            idProduct TEXT PRIMARY KEY,
            name TEXT,
            price REAL,
            categoryId TEXT,
            sellerId TEXT,
            description TEXT,
            imageUrl TEXT,
            isFavoris INTEGER
          )""",
        );
        await db.execute(
          """CREATE TABLE panier (
            idProduct TEXT PRIMARY KEY,
            name TEXT,
            price REAL,
            quantity TEXT,
            categoryId TEXT,
            subCategoryId TEXT,
            sellerId TEXT,
            description TEXT,
            imageUrl TEXT,
            isInPanier INTEGER
          )""",
        );
      },
      version: 1,
    );
    return db;
  }

  Future<void> insertDataInFavoris(Product product) async {
    Database db = await createDb();
    await db.insert(
      'favoris',
      {
        "idProduct": product.idProduct,
        "name": product.name,
        "price": product.price,
        "categoryId": product.categoryId,
        "description": product.description,
        "imageUrl": product.imageUrl,
        "sellerId": product.sellerId,
        "isFavoris": 1,
      },
    );
    await db.close();
  }

  Future<List<Product>> getAllFavoris() async {
    final db = await LocalDb().createDb();
    final data = await db.query("favoris");
    final favoris = data
        .map(
          (row) => Product(
            idProduct: row["idProduct"] as String,
            name: row["name"] as String,
            price: row["price"] as double,
            categoryId: row["categoryId"] as String,
            description: row["description"] as String,
            sellerId: row["sellerId"] as String,
            imageUrl: row['imageUrl'] as String,
            isFavoris: row["isFavoris"] as int,
          ),
        )
        .toList();
    await db.close();
    return favoris;
  }

  Future<void> removeFromFavoris(String idProduct) async {
    final db = await createDb();
    await db.delete(
      'favoris',
      where: 'idProduct = ?',
      whereArgs: [idProduct],
    );
    await db.close();
  }

  Future<void> insertDataInPanier(Product product) async {
    final db = await createDb();
    await db.insert(
      'panier',
      {
        "idProduct": product.idProduct,
        "name": product.name,
        "price": product.price,
        "categoryId": product.categoryId,
        "description": product.description,
        "imageUrl": product.imageUrl,
        "sellerId": product.sellerId,
        "isInPanier": 1,
        "quantity": product.quantity,
      },
    );
    await db.close();
  }

  Future<List<Product>> getAllPanier() async {
    final db = await createDb();
    final data = await db.query("panier");
    final panier = data
        .map(
          (row) => Product(
            idProduct: row["idProduct"] as String,
            name: row["name"] as String,
            price: row["price"] as double,
            categoryId: row["categoryId"] as String,
            description: row["description"] as String,
            sellerId: row["sellerId"] as String,
            imageUrl: row['imageUrl'] as String,
            isInPanier: row["isInPanier"] as int,
            quantity: row["quantity"] as int,
          ),
        )
        .toList();
    await db.close();
    return panier;
  }

  Future<void> removeFromPanier(String idProduct) async {
    final db = await createDb();
    await db.delete(
      'panier',
      where: 'idProduct = ?',
      whereArgs: [idProduct],
    );
    await db.close();
  }

  Future<bool> isProductInFavoris(String idProduct) async {
  final db = await createDb();
  final count = Sqflite.firstIntValue(await db.rawQuery(
    'SELECT COUNT(*) FROM favoris WHERE idProduct = ?',
    [idProduct],
  ));
  await db.close();
  return count! > 0;
}

}
