import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'login.dart';
import 'package:intl/intl.dart';


class test extends StatefulWidget {
  const test({super.key});

  @override
  State<test> createState() => _testState();
}

class _testState extends State<test> {
  List<Map<String, String>> _chats = [
    {"name": "Alice", "message": "Hello!", "dp": "assets/dp1.png"},
    {"name": "Bob", "message": "Hi there!", "dp": "assets/dp2.png"},
    {"name": "Charlie", "message": "How are you?", "dp": "assets/dp3.png"},
    {"name": "David", "message": "I'm good, thanks!", "dp": "assets/dp4.png"},
    {"name": "Eve", "message": "What's up?", "dp": "assets/dp5.png"},
    {"name": "Frank", "message": "Not much, you?", "dp": "assets/dp6.png"},
  ];

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Add functionality for settings
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo),
              title: Text('Change DP'),
              onTap: () {
                // Add functionality to change display picture
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Add functionality for logout
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => login()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade100,
        title: Text('ChatApp'),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () => _showOptionsMenu(context),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _chats.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(_chats[index]['dp']!),
            ),
            title: Text(_chats[index]['name']!),
            subtitle: Text(_chats[index]['message']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailScreen(user: _chats[index]),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.update),
            label: 'Updates',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            label: 'Calls',
          ),
        ],
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final Map<String, String> user;

  ChatDetailScreen({required this.user});

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  TextEditingController _controller = TextEditingController();
  List<Map<String, String>> _messages = [];
  final ImagePicker _picker = ImagePicker();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        String timestamp = DateFormat('HH:mm').format(DateTime.now());
        _messages.add({
          'message': _controller.text,
          'time': timestamp,
        });
        _controller.clear();
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _messages.add({
          'message': 'Sent an image: ${pickedFile.path}',
          'time': DateFormat('HH:mm').format(DateTime.now()),
        });
      });
    }
  }

  void _showMessageOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Message'),
              onTap: () {

                Navigator.pop(context);
                _editMessage(index);
              },
            ),
            ListTile(
              leading: Icon(Icons.delete),
              title: Text('Delete Message'),
              onTap: () {

                setState(() {
                  _messages.removeAt(index);
                });
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  void _editMessage(int index) {
    TextEditingController editController = TextEditingController(text: _messages[index]['message']);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Message'),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(
              hintText: 'Edit your message',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _messages[index]['message'] = editController.text;
                });
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.user['dp']!),
            ),
            SizedBox(width: 10),
            Text(widget.user['name']!),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Add functionality for options menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () => _showMessageOptions(context, index),
                  child: ListTile(
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(_messages[index]['message']!),
                            Text(
                              _messages[index]['time']!,
                              style: TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Divider(height: 1),
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.camera_alt),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
              IconButton(
                icon: Icon(Icons.attach_file),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}