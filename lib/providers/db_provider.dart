import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import 'dart:io';

class DBProvider 
{
  static final DBProvider _instance = DBProvider._();
  static Database? _database;

  DBProvider._();

  factory DBProvider() 
  {
    return _instance;
  }

  Future<Database> get database async 
  {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async 
  {
    // Obtener la ruta donde se guardará la base de datos en el dispositivo
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "magicstore");

    // Verificar si la base de datos ya existe
    if (FileSystemEntity.typeSync(path) == FileSystemEntityType.notFound) 
    {
      // Si no existe, copiar desde los assets
      ByteData data = await rootBundle.load('assets/magicstore');
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Escribir la base de datos en el sistema de archivos del dispositivo
      await File(path).writeAsBytes(bytes);
    }

    // Abrir la base de datos copiada
    return await openDatabase(path);
  }
}
