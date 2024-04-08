import 'package:api_cuidapet/application/database/database.dart';
import 'package:api_cuidapet/model/courses/courses_model.dart';

import './course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final Database _database;

  CourseRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<List<CoursesModel>?> getAll() async {
    final data = await _database.getData('SELECT * FROM COURSES');
    if (data != null) {
      return data.map<CoursesModel>((c) => CoursesModel.fromMap(c)).toList();
    }
    return null;
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CoursesModel?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<int?> save(CoursesModel model) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<bool> update(int id, CoursesModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
