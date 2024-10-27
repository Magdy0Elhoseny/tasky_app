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
          _scrollController.position.maxScrollExtent - 200) {
        widget.controller.fetchTasks();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isAllFilter = widget.controller.selectedFilter.value == 'All';
      return ListView.builder(
        controller: _scrollController,
        itemCount:
            widget.controller.filteredTasks.length + (isAllFilter ? 1 : 0),
        itemBuilder: (context, index) {
          if (index < widget.controller.filteredTasks.length) {
            final task = widget.controller.filteredTasks[index];
            return Padding(
              padding: const EdgeInsets.only(left: 22, right: 22, bottom: 12.0),
              child: TaskItem(task: task, controller: widget.controller),
            );
          } else if (isAllFilter && widget.controller.hasMore) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      );
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
