import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/item_model.dart';
import 'models/list_model.dart';

class DbHelper {
  int version = 10;
  Database? db;

  Future<Database?> openDb() async {
    if (db == null) {
      db = await openDatabase(
        join(await getDatabasesPath(), 'shopping_database2'),
        version: 10,
        onCreate: (Database db, int version) async {
          await db.execute(
              '''CREATE TABLE lists(id INTEGER PRIMARY KEY, name TEXT, priority INTEGER)''');
          await db.execute(
              '''CREATE TABLE items(id INTEGER PRIMARY KEY, listId INTEGER, name TEXT, quantity INTEGER, notes TEXT,FOREIGN KEY(listId) REFERENCES lists(id))''');
        },
      );
      return db;
    }
  }

  void test() async {
    db = await openDb();

    await db!.execute('INSERT OR IGNORE INTO lists VALUES (0, "Fruit", 2)');
    await db!.execute(
        'INSERT or IGNORE INTO items VALUES (0, 0, "Apples","2 Kg","Better if they are green")');

    List lists = await db!.rawQuery('SELECT * from lists');
    List items = await db!.rawQuery('SELECT * from items');
  }

  Future<int> insertList(ListModel listObj) async {
    int id = await db!.insert('lists', listObj.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return id;
  }

  Future<int> insertItem(ItemModel itemObj) async {
    int id = await db!.insert('items', itemObj.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return id;
  }

  Future<List> getLists() async {
    List<Map<String, dynamic>> map = await db!.query('lists');
    return List.generate(
        map.length,
        (index) => ListModel(
            map[index]['id'], map[index]['name'], map[index]['priority']));
  }

  Future<List> getItems(idList) async {
    List<Map<String, dynamic>> map =
        await db!.query('items', where: 'listId = ?', whereArgs: [idList]);

    return List.generate(
        map.length,
        (index) => ItemModel(map[index]['id'], map[index]['listId'],
            map[index]['name'], map[index]['quantity'], map[index]['notes']));
  }

  Future<int> deleteList(ListModel list) async {
    int result =
        await db!.delete("items", where: "listId = ?", whereArgs: [list.id]);
    result = await db!.delete("lists", where: "id = ?", whereArgs: [list.id]);

    return result;
  }

  Future<int> deleteItems(ItemModel list) async {
    int result =
        await db!.delete("items", where: "id = ?", whereArgs: [list.id]);

    return result;
  }
}
