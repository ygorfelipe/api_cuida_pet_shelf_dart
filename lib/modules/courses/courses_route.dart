import 'package:api_cuidapet/application/constants/consts.dart';
import 'package:api_cuidapet/application/database/database.dart';
import 'package:api_cuidapet/modules/courses/controller/course_controller.dart';
import 'package:api_cuidapet/modules/courses/data/course_repository.dart';
import 'package:api_cuidapet/modules/courses/data/course_repository_impl.dart';
import 'package:api_cuidapet/modules/courses/services/course_service.dart';
import 'package:api_cuidapet/modules/courses/services/course_service_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:shelf_router/shelf_router.dart';

class CoursesRoute {
  static Router routes(Router router) {
    GetIt.I.registerSingleton<CourseRepository>(
        CourseRepositoryImpl(
            database:
                GetIt.I.get<Database>(instanceName: Consts.mysqlInstance)),
        instanceName: Consts.courseRepository);
    GetIt.I.registerSingleton<CourseService>(
        CourseServiceImpl(
            repository: GetIt.I
                .get<CourseRepository>(instanceName: Consts.courseRepository)),
        instanceName: Consts.courseService);

    final courseController = CourseController(
        service:
            GetIt.I.get<CourseService>(instanceName: Consts.courseService));

    // final courseController = CourseController(
    //     service: getIt.get<CourseService>(instanceName: Consts.courseService));

    router.add('GET', '/courses', courseController.getAll);
    return router;
  }
}
