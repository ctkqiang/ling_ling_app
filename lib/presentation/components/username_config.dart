import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void showUsernameDialog(
  BuildContext context,
  Function(String username) onUsernameSelected,
) {
  final TextEditingController controller = TextEditingController();

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: Colors.white,
        title: Text(
          'Choose Your Username 💖',
          style: TextStyle(
            color: Colors.pinkAccent,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: controller,
              decoration: InputDecoration(
                labelText: 'Enter Username',
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.pinkAccent),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: Icon(Icons.check, size: 18),
              label: Text("Set Username"),
              onPressed: () {
                final name = controller.text.trim();
                if (name.isNotEmpty) {
                  Navigator.of(context).pop();
                  onUsernameSelected(name);
                }
              },
            ),
            TextButton(
              child: Text(
                'Generate for me',
                style: TextStyle(color: Colors.pinkAccent),
              ),
              onPressed: () {
                final generated = "user_${const Uuid().v4().substring(0, 6)}";
                Navigator.of(context).pop();
                onUsernameSelected(generated);
              },
            ),
          ],
        ),
      );
    },
  );
}
