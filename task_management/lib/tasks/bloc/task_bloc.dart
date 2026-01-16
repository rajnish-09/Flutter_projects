import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:task_management/tasks/bloc/task_event.dart';
import 'package:task_management/tasks/bloc/task_state.dart';
import 'package:task_management/tasks/task_service.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskService taskService = TaskService();
  TaskBloc() : super((TaskInitial())) {
    on<SaveTask>((event, emit) async {
      try {
        final uid = FirebaseAuth.instance.currentUser!.uid;
        await taskService.saveTasks(event.tasksModel, uid);
        emit(TaskSaveSuccess());
      } catch (e) {
        throw Exception(e.toString());
      }
    });

    on<TaskStatusChanged>((event, emit) {
      emit(TaskStatusUpdated(status: event.status));
    });

    on<DeleteTask>((event, emit) async {
      try {
        await taskService.deleteTask(event.taskUid);
        emit(TaskDeleted());
      } catch (e) {
        emit(TaskDeletionFailed(failedMessage: e.toString()));
      }
    });
  }
}
