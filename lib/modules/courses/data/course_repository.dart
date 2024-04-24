import 'package:api_cuidapet/entities/courses/course.dart';

abstract interface class CourseRepository {
  Future<List<Course>?> getAll();
  Future<Course?> getById(int id);
  Future<int?> save(Course model);
  Future<bool> delete(int id);
  Future<bool> update(int id, Course model);
}
