import 'dart:developer';
import 'dart:io';

import 'package:geocam_news/features/news/data/models/news_model_local.dart';
import 'package:geocam_news/features/news/data/models/news_model_response.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class NewsLocalDatasources {
  static const newsDatabase = "news_database.db";
  static const newsTable = "news";
  static const version = 1;

  NewsLocalDatasources.internal();
  static final NewsLocalDatasources _instance = NewsLocalDatasources.internal();
  factory NewsLocalDatasources() => _instance;

  static Database? _db;
  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDb();
    return _db!;
  }

  Future<Database> initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, newsDatabase);

    return await openDatabase(path, version: version,
        onCreate: (db, version) async {
      await _onCreate(db, version);
    });
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $newsTable (
        title TEXT PRIMARY KEY,
        description TEXT,
        url TEXT,
        urlToImage TEXT,
        content TEXT,
        author TEXT,
        publishedAt TEXT,
        isBookmark INTEGER
      )
      ''');
  }

  Future<void> insertNews(List<NewsModelResponse> newsList) async {
    final db = await database;
    final batch = db.batch();
    for (var news in newsList) {
      batch.insert(newsTable, {
        'title': news.title,
        'description': news.description,
        'url': news.url,
        'urlToImage': news.imageUrl,
        'content': news.content,
        'author': news.author,
        'publishedAt': news.publishedAt,
        'isBookmark': 0,
        },
        conflictAlgorithm: ConflictAlgorithm.ignore
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<NewsModelLocal>> getNews() async {
    final db = await database;
    final maps = await db.query(newsTable);
    return maps.map((map) => NewsModelLocal.fromMap(map)).toList();
  }

  Future<List<NewsModelLocal>> getNewsBookmarked() async {
    final db = await database;
    final maps = await db.rawQuery("Select * from $newsTable where isBookmark = 1", );
    return maps.map((map) => NewsModelLocal.fromMap(map)).toList();
  }

  Future<NewsModelLocal?> getNewsByTitle(String title) async {
    final db = await database;
    final maps = await db.query(newsTable, where: 'title = ?', whereArgs: [title]);
    return maps.isNotEmpty? maps.map((map) => NewsModelLocal.fromMap(map)).toList()[0] : null;
  }

  Future<void> updateBookmark(String title, bool isBookmarked) async {
    final db = await database;
    await db.update(newsTable, {'isBookmark' : isBookmarked ? 1 : 0}, where: 'title = ?', whereArgs: [title]);
  }

  Future<int> isBookmarked(String title) async {
    final db = await database;
    final maps = await db.rawQuery("Select isBookmark from $newsTable where title = ?", [title]);
    if(maps.isEmpty) return 0;
    return maps.first['isBookmark'] as int;
  }

  Future<void> clearAll() async {
    final db = await database;
    await db.delete(newsTable);
  }
}
