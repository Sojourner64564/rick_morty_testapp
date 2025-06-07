import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:rick_morty_testapp/core/database/database.dart';

@lazySingleton
class FavoriteDatabase extends AppDatabase{
  FavoriteDatabase(): super(LazyDatabase(() async{
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'favorite_card_rick_and_morty.sqlite'));
      return NativeDatabase(file);
    });
  }));

}