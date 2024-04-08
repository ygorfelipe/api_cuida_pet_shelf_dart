import 'package:api_cuidapet/model/courses/courses_model.dart';

abstract interface class CourseRepository {
  Future<List<CoursesModel>?> getAll();
  Future<CoursesModel?> getById(int id);
  Future<int?> save(CoursesModel model);
  Future<bool> delete(int id);
  Future<bool> update(int id, CoursesModel model);
}
