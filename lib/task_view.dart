import 'package:flutter/material.dart';
import 'reward_view.dart';
import 'profile_view.dart';
import 'photo_view.dart';
import 'camara.dart';

// Definición de la clase Task
class Task {
  String title;
  bool isCompleted;
  String? photoPath;

  Task({required this.title, this.isCompleted = false, this.photoPath});
}

class TaskView extends StatefulWidget {
  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  List<Task> tasks = [];

  void _addTask(String title) {
    setState(() {
      tasks.add(Task(title: title));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mis Tareas')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tasks[index].title),
                  trailing: Icon(
                    tasks[index].isCompleted ? Icons.check : Icons.warning,
                    color: tasks[index].isCompleted ? Colors.green : Colors.red,
                  ),
                  onTap: () async {
                    if (!tasks[index].isCompleted) {
                      final photoPath = await _showTakePhotoDialog();
                      if (photoPath != null) {
                        setState(() {
                          tasks[index].photoPath = photoPath;
                        });
                      }
                    }
                  },
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () async {
              final taskTitle = await showDialog<String>(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Nueva Tarea'),
                    content: TextField(
                      onSubmitted: (value) {
                        Navigator.pop(context, value);
                      },
                      decoration: InputDecoration(hintText: 'Título de la tarea'),
                    ),
                  );
                },
              );
              if (taskTitle != null && taskTitle.isNotEmpty) {
                _addTask(taskTitle);
              }
            },
            child: Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Tareas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Logros',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Perfil',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TaskView()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RewardView(tasks: tasks),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileScreen(),
                ),
            );
          }
        },
      ),
    );
  }

  Future<String?> _showTakePhotoDialog() async {
    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sube una foto como prueba'),
          content: Text('¿Deseas tomar una foto o seleccionar una existente?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'photo_path'); // Simulamos el camino de la foto
              },
              child: Text('Tomar foto'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, 'photo_path'); // Simulamos el camino de la foto
              },
              child: Text('Seleccionar foto'),
            ),
          ],
        );
      },
    );
  }
}
