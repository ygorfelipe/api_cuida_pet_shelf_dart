import 'package:api_cuidapet/model/courses/courses_model.dart';
import 'package:api_cuidapet/modules/courses/data/course_repository.dart';

import './course_service.dart';

class CourseServiceImpl implements CourseService {
  final CourseRepository _repository;

  CourseServiceImpl({required CourseRepository repository})
      : _repository = repository;

  @override
  Future<List<CoursesModel>?> getAll() => _repository.getAll();

  @override
  Future<CoursesModel?> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<CoursesModel?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<CoursesModel?> save(CoursesModel model) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<CoursesModel?> update(int id, {required Map<String, dynamic> data}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
