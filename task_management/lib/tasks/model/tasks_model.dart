enum TaskStatus { completed, pending }

TaskStatus? taskStatus;

class TasksModel {
  String taskId;
  final String taskTitle;
  final String taskDescription;
  final String taskStatus;
  // final String creatorId;

  TasksModel({
    required this.taskId,
    required this.taskTitle,
    required this.taskDescription,
    required this.taskStatus,
    // required this.creatorId
  });

  factory TasksModel.fromJson(String id, Map<String, dynamic> json) {
    return TasksModel(
      taskId: id,
      taskTitle: json['taskTitle'],
      taskDescription: json['taskDescription'],
      taskStatus: json['taskStatus'],
      // creatorId:  json['creatorId']
    );
  }

  Map<String, dynamic> toJson() => {
    // 'taskId': taskId,
    'taskTitle': taskTitle,
    'taskDescription': taskDescription,
    'taskStatus': taskStatus,
    // 'creatorId':creatorId
  };
}
