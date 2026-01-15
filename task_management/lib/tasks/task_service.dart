import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task_management/tasks/model/tasks_model.dart';

class TaskService {
  final tasksCollection = FirebaseFirestore.instance.collection(
    'tasksCollection',
  );

  Future<void> saveTasks(TasksModel data, String uid) async {
    try {
      await tasksCollection.doc().set({
        ...data.toJson(),
        'created_at': FieldValue.serverTimestamp(),
        'creator_id': uid,
      });
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Stream<List<TasksModel>> getTasksByUser(String uid) {
    // final data
    return tasksCollection
        .where('creator_id', isEqualTo: uid)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((e) => TasksModel.fromJson(e.data())).toList(),
        );
  }
}
