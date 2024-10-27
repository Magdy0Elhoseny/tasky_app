import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tasky_app/feature/home/model/task_model.dart';

class ImageItemWidget extends StatelessWidget {
  const ImageItemWidget({super.key, required this.task});
  final Task task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 64,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AspectRatio(
          aspectRatio: 1,
          child: CachedNetworkImage(
            placeholder: (context, url) => const LinearProgressIndicator(),
            fadeOutDuration: const Duration(seconds: 2),
            fadeInDuration: const Duration(seconds: 1),
            fit: BoxFit.fill,
            imageUrl: task.image.isNotEmpty
                ? task.image
                : 'https://example.com/default-image.jpg',
          ),
        ),
      ),
    );
  }
}
