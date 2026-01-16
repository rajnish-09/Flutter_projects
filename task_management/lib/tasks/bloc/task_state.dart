import 'package:task_management/tasks/model/tasks_model.dart';

abstract class TaskState {}

class TaskInitial extends TaskState {}

class TaskSaveSuccess extends TaskState {
  // final TasksModel tasksModel;
  // TaskSaveSuccess({required this.tasksModel});
}

class TaskSaveFailed extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {}

class TaskStatusUpdated extends TaskState {
  final TaskStatus status;
  TaskStatusUpdated({required this.status});
}

class TaskDeleteSuccess extends TaskState {
  final String successMessage;
  TaskDeleteSuccess(this.successMessage);
}

class TaskDeletionFailed extends TaskState {
  final String failedMessage;
  TaskDeletionFailed({required this.failedMessage});
}

class TaskUpdateSuccess extends TaskState {
  final String successMessage;
  TaskUpdateSuccess(this.successMessage);
}

class TaskUpdateFailed extends TaskState {
  final String failedMessage;
  TaskUpdateFailed(this.failedMessage);
}
