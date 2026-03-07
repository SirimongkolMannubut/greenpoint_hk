import 'package:mongo_dart/mongo_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MongoService {
  static Db? _db;

  static Future<void> connect() async {
    _db = await Db.create(dotenv.env['MONGO_URL']!);
    await _db!.open();
  }

  static Db get db => _db!;
}
