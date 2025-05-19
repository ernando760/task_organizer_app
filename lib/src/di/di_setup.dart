import 'barrels/di_setup_barrel.dart';

final injector = AutoInjector();
void diSetup() {
  // Database
  injector.addSingleton<TaskIsarDatabase>(TaskIsarDatabase.new);

  // Repositories
  injector.add<IGetAllTasksRepository>(GetAllTasksRepository.new);
  injector.add<IUpsertTaskRepository>(UpsertTaskRepository.new);
  injector.add<IDeleteTaskRepository>(DeleteTaskRepository.new);

  // Usecases
  injector.add<IGetAllTasks>(GetAllTasks.new);
  injector.add<IUpsertTask>(UpsertTask.new);
  injector.add<IDeleteTask>(DeleteTask.new);

  // controllers
  injector.addSingleton<TasksController>(TasksController.new);

  injector.commit();
}
