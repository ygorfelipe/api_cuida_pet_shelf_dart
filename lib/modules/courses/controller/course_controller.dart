import 'dart:convert';

import 'package:api_cuidapet/modules/courses/services/course_service.dart';
import 'package:shelf/shelf.dart';

class CourseController {
  final CourseService _service;

  CourseController({required CourseService service}) : _service = service;

  Future<Response> getAll(Request request) async {
    final courses = await _service.getAll();
    final list = [];

    if (courses != null) {
      for (var course in courses) {
        list.add(course.toMap());
      }
      return Response.ok(jsonEncode(list));
    }
    return Response.notFound(jsonEncode({'message': 'Cursos não encontrado'}));
  }
}
