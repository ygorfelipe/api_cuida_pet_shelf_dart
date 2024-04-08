import 'package:api_cuidapet/model/courses/courses_model.dart';

abstract interface class CourseService {
  Future<List<CoursesModel>?> getAll();
  Future<CoursesModel?> getById(int id);
  Future<CoursesModel?> save(CoursesModel model);
  Future<CoursesModel?> delete(int id);
  Future<CoursesModel?> update(int id, {required Map<String, dynamic> data});
}
