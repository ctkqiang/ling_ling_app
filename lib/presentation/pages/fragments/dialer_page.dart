import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ling_ling_app/controller/dialer_controller.dart';

class DialerPage extends StatefulWidget {
  const DialerPage({super.key});

  @override
  State<DialerPage> createState() => _DialerPageState();
}

class _DialerPageState extends State<DialerPage> {
  final dialerController = DialerController.to;

  Widget _buildKey(String digit, [String? letters]) {
    return InkResponse(
      onTapDown: (_) => dialerController.append(digit),
      onLongPress: () => (digit == '0') ? dialerController.append('+') : null,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              digit,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            if (letters != null)
              Text(
                letters,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              const SizedBox(height: 60),
              Obx(
                () => Center(
                  child: Text(
                    dialerController.phoneNumber.value,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    selectionColor: Theme.of(context).colorScheme.primary,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Expanded(
                child: GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 2,
                    childAspectRatio: 1.2,
                  ),
                  children: [
                    _buildKey('1'),
                    _buildKey('2', 'ABC'),
                    _buildKey('3', 'DEF'),
                    _buildKey('4', 'GHI'),
                    _buildKey('5', 'JKL'),
                    _buildKey('6', 'MNO'),
                    _buildKey('7', 'PQRS'),
                    _buildKey('8', 'TUV'),
                    _buildKey('9', 'WXYZ'),
                    _buildKey('*'),
                    _buildKey('0', '+'),
                    _buildKey('#'),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.backspace_outlined),
                    color: Theme.of(context).colorScheme.onSurface,
                    iconSize: 30,
                    onPressed: dialerController.delete,
                    tooltip: '删除',
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withAlpha(200),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      onPressed: dialerController.call,
                      color: Theme.of(context).colorScheme.primary,

                      icon: const Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.person_add_alt_1),
                    color: Theme.of(context).colorScheme.secondary,
                    iconSize: 30,
                    onPressed: () {},
                    tooltip: '添加联系人',
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
