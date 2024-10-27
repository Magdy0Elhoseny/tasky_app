import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasky_app/feature/home/Controller/home_controller.dart';
import 'package:tasky_app/feature/home/view/widgets/task_list_item.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key, required this.controller});
  final HomeController controller;

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 5) {
        widget.controller.fetchTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          controller: _scrollController,
          shrinkWrap: true,
          itemCount: widget.controller.filteredTasks.length,
          itemBuilder: (context, index) {
            final task = widget.controller.filteredTasks[index];
            return Padding(
              padding: const EdgeInsets.only(left: 22, right: 22, bottom: 12.0),
              child: TaskItem(task: task, controller: widget.controller),
            );
          },
        ));
  }
}
