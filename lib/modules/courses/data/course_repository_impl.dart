import 'package:api_cuidapet/application/database/database.dart';
import 'package:api_cuidapet/entities/courses/course.dart';

import './course_repository.dart';

class CourseRepositoryImpl implements CourseRepository {
  final Database _database;

  CourseRepositoryImpl({required Database database}) : _database = database;

  @override
  Future<List<Course>?> getAll() async {
    final data = await _database.getData('SELECT * FROM COURSES');
    if (data != null) {
      return data.map<Course>((c) => Course.fromMap(c)).toList();
    }
    return null;
  }

  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Course?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<int?> save(Course model) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<bool> update(int id, Course model) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
