import 'package:flutter/material.dart';
import 'package:nesscale_test/modal/customer.dart';
import 'package:nesscale_test/modal/invoice.dart';
import 'package:nesscale_test/modal/invoice_item.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../modal/item.dart';
import '../modal/user_credential.dart';

class SqlService {
  SqlService();
  static var database;
  static var userTB = "user";
  static var invoiceitemTB = "invoiceitem";
  static var invoiceTB = "invoice";
  static var customerTB = "customer";
  static var itemTB = "item";

  static Future<void> openDB() async {
    database = await openDatabase(
      join(await getDatabasesPath(), 'database.db'),
      onCreate: _onCreate,
      version: 1,
    );

    if (database != null) {
      print("database open!");
      print(database);
    }
  }

  // SQL code to create the database table
  static Future _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE $userTB(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT)',
    );
    await db.execute(
      'CREATE TABLE $itemTB(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, code TEXT,rate REAL,isDeleted INTEGER)',
    );
    await db.execute(
      'CREATE TABLE $customerTB(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, mobile TEXT,email TEXT,isDeleted INTEGER)',
    );
    await db.execute(
      'CREATE TABLE $invoiceTB(id INTEGER PRIMARY KEY AUTOINCREMENT, customer INTEGER, grandtotal REAL,date TEXT)',
    );
    await db.execute(
      'CREATE TABLE $invoiceitemTB(id INTEGER PRIMARY KEY AUTOINCREMENT,invoiceid INTEGER, item TEXT,qty INTEGER,rate REAL)',
    );
    debugPrint("table created successful!");
  }

  static Future<void> insertUser(UserCred usercred) async {
    final db = await database;

    await db.insert(
      userTB,
      usercred.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint('user insert successful!');
  }

  static Future<void> insertItem(Item item) async {
    final db = await database;

    await db.insert(
      itemTB,
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint('Item insert successful!');
  }

  static Future<void> insertCustomer(Customer customer) async {
    final db = await database;

    await db.insert(
      customerTB,
      customer.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint('customer insert successful!');
  }

  static Future<int> insertInvoice(Invoice invoice) async {
    final db = await database;

    int id = await db.insert(
      invoiceTB,
      invoice.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    debugPrint('invoice insert successful!');
    return id;
  }

  static Future<int> insertInvoiceItem(InvoiceItem invoiceItem) async {
    final db = await database;

    int id = await db.insert(
      invoiceitemTB,
      invoiceItem.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint('InvoiceItem insert successful!');
    return id;
  }

  static Future<List<UserCred>> getUser() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(userTB);

    return List.generate(maps.length, (i) {
      return UserCred.fromJson(maps[i]);
    });
  }

  static Future<List<Item>> getItems() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(itemTB);

    return List.generate(maps.length, (i) {
      return Item.fromJson(maps[i]);
    });
  }

  static Future<List<InvoiceItem>> getInvoiceItem() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(invoiceitemTB);

    return List.generate(maps.length, (i) {
      return InvoiceItem.fromJson(maps[i]);
    });
  }

  static Future<List<Invoice>> getInvoice() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(invoiceTB);

    return List.generate(maps.length, (i) {
      return Invoice.fromJson(maps[i]);
    });
  }

  static Future<List<Customer>> getCustomers() async {
    final db = await database;

    final List<Map<String, dynamic>> maps = await db.query(customerTB);

    return List.generate(maps.length, (i) {
      return Customer.fromJson(maps[i]);
    });
  }

  static Future<int> updateCustomer(Customer row) async {
    final db = await database;
    int id = row.id!.toInt();
    return await db.update(
      customerTB,
      row.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  static Future<int> updateItem(Item row) async {
    final db = await database;
    int id = row.id!.toInt();
    return await db.update(
      itemTB,
      row.toMap(),
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
