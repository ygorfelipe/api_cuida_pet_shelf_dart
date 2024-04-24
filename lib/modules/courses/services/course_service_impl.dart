import 'package:api_cuidapet/entities/courses/course.dart';
import 'package:api_cuidapet/modules/courses/data/course_repository.dart';

import './course_service.dart';

class CourseServiceImpl implements CourseService {
  final CourseRepository _repository;

  CourseServiceImpl({required CourseRepository repository})
      : _repository = repository;

  @override
  Future<List<Course>?> getAll() => _repository.getAll();

  @override
  Future<Course?> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<Course?> getById(int id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<Course?> save(Course model) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  Future<Course?> update(int id, {required Map<String, dynamic> data}) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
