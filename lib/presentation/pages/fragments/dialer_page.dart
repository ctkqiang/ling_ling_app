import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ling_ling_app/controller/dialer_controller.dart';

class DialerPage extends StatefulWidget {
  const DialerPage({Key? key}) : super(key: key);

  @override
  State<DialerPage> createState() => _DialerPageState();
}

class _DialerPageState extends State<DialerPage> {
  final dialerController = DialerController.to;

  Widget _buildKey(String value) {
    return GestureDetector(
      onTap: () => dialerController.append(value),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.pink.shade100,
        ),
        child: Text(
          value,
          style: const TextStyle(fontSize: 28, color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? Colors.black : Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 30),
            Obx(
              () => Text(
                dialerController.phoneNumber.value,
                style: TextStyle(
                  fontSize: 35,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.symmetric(horizontal: 40),
                mainAxisSpacing: 18,
                crossAxisSpacing: 18,
                childAspectRatio: 1,
                children: [
                  ...[
                    '1',
                    '2',
                    '3',
                    '4',
                    '5',
                    '6',
                    '7',
                    '8',
                    '9',
                    '*',
                    '0',
                    '#',
                  ].map(_buildKey),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  icon: const Icon(Icons.backspace_outlined),
                  color: Colors.grey.shade700,
                  iconSize: 32,
                  onPressed: dialerController.delete,
                ),
                FloatingActionButton(
                  onPressed: dialerController.call,
                  backgroundColor: Colors.green,
                  elevation: 0.0,

                  child: const Icon(Icons.call, color: Colors.white),
                ),
                IconButton(
                  icon: const Icon(Icons.person_add_alt_1),
                  onPressed: () => dialerController.saveContact,
                ),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
