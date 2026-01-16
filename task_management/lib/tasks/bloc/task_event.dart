import 'package:task_management/tasks/model/tasks_model.dart';

abstract class TaskEvent {}

class SaveTask extends TaskEvent {
  final TasksModel tasksModel;
  SaveTask({required this.tasksModel});
}

class LoadedTasks extends TaskEvent {
  final List<TasksModel> data;
  LoadedTasks({required this.data});
}

class TaskStatusChanged extends TaskEvent {
  TaskStatus status;
  TaskStatusChanged({required this.status});
}

class DeleteTask extends TaskEvent {
  final String taskUid;
  DeleteTask(this.taskUid);
}

class UpdateTask extends TaskEvent {
  final TasksModel updatedTask;
  UpdateTask(this.updatedTask);
}
