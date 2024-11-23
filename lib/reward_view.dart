import 'package:flutter/material.dart';
import 'task_view.dart';
import 'photo_view.dart';
import 'achievement_popup.dart';

class RewardView extends StatelessWidget {
  final List<Task> tasks;

  RewardView({required this.tasks});

  @override
  Widget build(BuildContext context) {
    List<Task> verifiedTasks = tasks.where((task) => task.isCompleted).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Logros')),
      body: verifiedTasks.isEmpty
          ? Center(
        child: Text('No hay tareas verificadas.', style: TextStyle(fontSize: 24)),
      )
          : ListView.builder(
        itemCount: verifiedTasks.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(verifiedTasks[index].title),
            subtitle: Text('Evidencia: ${verifiedTasks[index].photoPath ?? 'Sin foto'}'),
            trailing: Icon(Icons.check, color: Colors.green),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PhotoViewScreen(photoPath: verifiedTasks[index].photoPath!),
                ),
              );
            },
          );
        },
      ),
    );
  }
}