import 'package:api_cuidapet/entities/courses/course.dart';

abstract interface class CourseService {
  Future<List<Course>?> getAll();
  Future<Course?> getById(int id);
  Future<Course?> save(Course model);
  Future<Course?> delete(int id);
  Future<Course?> update(int id, {required Map<String, dynamic> data});
}
