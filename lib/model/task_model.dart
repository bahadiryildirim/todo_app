// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uuid/uuid.dart';

class TaskModel {
  final String id;
  final String taskDetail;
  final DateTime createdAt;
  final bool isComplated;

  TaskModel(
      {required this.id,
      required this.taskDetail,
      required this.createdAt,
      required this.isComplated});

  @override
  String toString() {
    return 'TaskModel(\nid: $id\ntaskDetail: $taskDetail\ncreatedAt: $createdAt\nisComplated: $isComplated\n)';
  }

  factory TaskModel.create({
    required String taskDetail,
    required DateTime createdAt,
  }) {
    return TaskModel(
        id: const Uuid().v1(),
        taskDetail: taskDetail,
        createdAt: createdAt,
        isComplated: false);
  }
}
