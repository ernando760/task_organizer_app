import 'package:go_router/go_router.dart';

import '../di/barrels/di_setup_barrel.dart';
import '../di/di_setup.dart';
import '../tasks/presentation/pages/tasks_page.dart';

class AppRoutes {
  static final GoRouter routes = GoRouter(
    initialLocation: "/tasks",
    routes: [
      GoRoute(
        path: "/tasks",
        builder: (context, _) {
          final tasksController = injector.get<TasksController>();
          return TasksPage(tasksController: tasksController);
        },
      ),
    ],
  );
}
