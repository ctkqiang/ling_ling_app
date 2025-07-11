import 'package:flutter/material.dart';
import 'package:ling_ling_app/controller/database_controller.dart';

class ToolBox extends StatefulWidget {
  const ToolBox({super.key});

  @override
  State<ToolBox> createState() => _ToolBoxState();
}

class _ToolBoxState extends State<ToolBox> {
  final databaseController = DatabaseController.to;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await databaseController.getUser();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(databaseController.username.value)),
    );
  }
}
