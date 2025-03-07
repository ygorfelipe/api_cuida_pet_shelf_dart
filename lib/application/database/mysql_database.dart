import 'package:api_cuidapet/application/database/database.dart';
import 'package:api_cuidapet/application/logger/logger.dart';
import 'package:mysql_client/mysql_client.dart';

import '../config/database_connection_config.dart';

class MysqlDatabase implements Database {
  MySQLConnection? conn;
  Logger? _logger;
  DatabaseConnectionConfig? _databaseConnectionConfig;

  MysqlDatabase._();

  static MysqlDatabase? _instance;

  static MysqlDatabase get i {
    _instance ??= MysqlDatabase._();
    return _instance!;
  }

  @override
  Future<void> clear<T>(String s) {
    throw UnimplementedError();
  }

  @override
  Future<int> insertAll<T>(
      {required String tableName, required List<T> value, bool clear = false}) {
    throw UnimplementedError();
  }

  @override
  Future<T?> objectExists<T>({required T object, required String tableName}) {
    throw UnimplementedError();
  }

  @override
  Future<int?> objectIndex<T>({required T object, required String tableName}) {
    throw UnimplementedError();
  }

  @override
  Future<void> closeDatabase() async {
    await conn?.close();
  }

  @override
  Future<bool> delete<T>({required String tableName, required T value}) async {
    final key = (value as Map).keys.first;
    final val = (value.values.first);

    final result =
        await conn?.execute('Delete from $tableName where $key = $val');

    if (result != null) {
      if (result.affectedRows.toInt() > 0) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  @override
  Future<List<T>?> getData<T>(String query) async {
    final listResult = <T>[];
    final result = await conn?.execute(query);

    if (result != null) {
      for (final row in result.rows) {
        listResult.add(row.assoc() as T);
      }
      return listResult;
    }
    return null;
  }

  @override
  Future<T?> getUnique<T>(String query) async {
    final result = await conn?.execute(query);
    if (result == null) {
      return null;
    }
    if (result.rows.isEmpty) {
      return null;
    }
    return (result.rows.first.assoc()) as T;
  }

  @override
  Future<int> insert<T>({required String tableName, required T value}) async {
    try {
      final tableFields = ((value as Map).keys).join(',');
      final tableWillCards = (value).keys.map((e) => ':$e').join(',');

      final res = await conn?.execute(
        'INSERT INTO $tableName ($tableFields) VALUES ($tableWillCards)',
        value as Map<String, dynamic>?,
      );

      if (res == null) {
        return 0;
      }
      if (res.affectedRows.toInt() == 1) {
        return res.lastInsertID.toInt();
      }
      return 0;
    } catch (e, s) {
      _logger?.error('Erro ao savar', e, s);
      return 0;
    }
  }

  @override
  Future<MysqlDatabase?> openDatabase<MysqlDatabase>() async {
    conn = await MySQLConnection.createConnection(
      host: _databaseConnectionConfig!.host,
      port: int.parse(_databaseConnectionConfig!.port.toString()),
      userName: _databaseConnectionConfig!.user,
      password: _databaseConnectionConfig!.password,
      databaseName: _databaseConnectionConfig!.databaseName,
      secure: int.parse(_databaseConnectionConfig!.secure.toString()) == 0
          ? false
          : true,
    );
    conn?.connect();
    _logger?.infoServer(this);

    return this as MysqlDatabase;
  }



  @override
  Future<bool> update<T>({required String tableName, required T value}) async {
    try {
      final tableFields = ((value as Map).keys).toList();
      final tableWillCards = (value).keys.map((e) => ':$e').toList();
      final List<String> queryFields = [];

      for (var i = 0; i < tableFields.length; i++) {
        queryFields.add('${tableFields[i]} = ${tableWillCards[i]}');
      }

      final String fields = (queryFields.join(','));
      final res = await conn?.execute(
        'UPDATE $tableName SET $fields WHERE ID = ${value['id']}',
        value as Map<String, dynamic>?,
      );
      if (res == null) {
        return false;
      }
      if (res.affectedRows.toInt() == 1) {
        return true;
      }
      return false;
    } catch (e, s) {
      _logger?.error('Erro ao savar', e, s);
      return false;
    }
  }
}
