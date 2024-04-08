import 'package:api_cuidapet/application/constants/consts.dart';
import 'package:api_cuidapet/application/database/database.dart';
import 'package:api_cuidapet/application/routers/i_router.dart';
import 'package:api_cuidapet/modules/courses/controller/course_controller.dart';
import 'package:api_cuidapet/modules/courses/data/course_repository.dart';
import 'package:api_cuidapet/modules/courses/data/course_repository_impl.dart';
import 'package:api_cuidapet/modules/courses/services/course_service.dart';
import 'package:api_cuidapet/modules/courses/services/course_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

class CoursesRoute implements IRouter {
  final getIt = GetIt.I;

  @override
  void configure(Router router) {
    getIt.registerSingleton<CourseRepository>(
        CourseRepositoryImpl(
            database: getIt.get<Database>(instanceName: Consts.mysqlInstance)),
        instanceName: Consts.courseRepository);
    getIt.registerSingleton<CourseService>(
        CourseServiceImpl(
            repository: getIt.get<CourseRepository>(
                instanceName: Consts.courseRepository)),
        instanceName: Consts.courseService);

    final courseController = CourseController(
        service: getIt.get<CourseService>(instanceName: Consts.courseService));
    router.add('get', '/courses', courseController.getAll);
  }
}
