import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

void showUsernameDialog(
  BuildContext context,
  Function(String username) onUsernameSelected,
) {
  final TextEditingController controller = TextEditingController();

  showDialog(
    useSafeArea: true,
    barrierDismissible: false,
    useRootNavigator: true,
    context: context,
    builder: (context) {
      return PopScope(
        canPop: false,
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: Colors.white,
          title: Text(
            '选择妳的用户名 💖',
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
                  labelText: '请输入用户名',
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
                label: Text(
                  "确认用户名",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
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
                  '帮我生成一个',
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
        ),
      );
    },
  );
}
