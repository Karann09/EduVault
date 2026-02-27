import 'package:flutter/material.dart';

class Session {
  String name;
  bool completed;

  Session({required this.name, this.completed = false});
}

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Session> sessions = [];
  final TextEditingController _controller = TextEditingController();

  void _showAddSessionDialog() {
    _controller.clear();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'Add Session',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              hintText: 'Subject',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_controller.text.trim().isNotEmpty) {
                  setState(() {
                    sessions.add(Session(name: _controller.text.trim()));
                  });
                }
                Navigator.pop(context);
              },
              child: const Text(
                'Save',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }

  void _toggleComplete(int index) {
    setState(() {
      sessions[index].completed = !sessions[index].completed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7FAFF),
      body: sessions.isEmpty
          ? const Center(
              child: Text(
                'No Sessions Added Yet !!!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];

                return Card(
                  elevation: 3,
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        session.completed
                            ? Icons.check_circle
                            : Icons.circle_outlined,
                        color: session.completed ? Colors.green : Colors.grey,
                      ),
                      onPressed: () => _toggleComplete(index),
                    ),
                    title: Text(
                      session.name.toUpperCase(),
                      style: TextStyle(
                        decoration: session.completed
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        child: const Icon(Icons.add_outlined),
        onPressed: _showAddSessionDialog,
      ),
    );
  }
}
