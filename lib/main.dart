import 'package:flutter/material.dart';

import 'src/core/theme/app_theme.dart';
import 'src/core/util.dart';
import 'src/di/di_setup.dart';
import 'src/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  diSetup();
  runApp(const AppMainWidget());
}

class AppMainWidget extends StatelessWidget {
  const AppMainWidget({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto", "Inter");

    AppTheme theme = AppTheme(textTheme);
    return MaterialApp.router(
      title: 'Organizador de tarefas',
      theme: theme.light(),
      darkTheme: theme.dark(),
      routerConfig: AppRoutes.routes,
    );
  }
}
