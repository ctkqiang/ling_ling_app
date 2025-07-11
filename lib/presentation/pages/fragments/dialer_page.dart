// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ling_ling_app/controller/dialer_controller.dart';
import 'package:ling_ling_app/presentation/pages/fragments/tool_box_page.dart';

class DialerPage extends StatefulWidget {
  const DialerPage({super.key});

  @override
  State<DialerPage> createState() => _DialerPageState();
}

class _DialerPageState extends State<DialerPage> {
  final dialerController = DialerController.to;

  Widget _buildKey(String digit, [String? letters]) {
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        splashColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
        highlightColor: Colors.transparent,
        onTap: () => dialerController.append(digit),
        onLongPress: () {
          if (digit == '0') dialerController.append('+');
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Theme.of(context).colorScheme.surfaceVariant,
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
                    fontSize: 11,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: const SizedBox(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkResponse(
              onTap: () => Get.to(() => const ToolBox()),
              child: Icon(
                Icons.build_circle,
                size: 30,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              Obx(
                () => Center(
                  child: SelectableText(
                    dialerController.phoneNumber.value,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    cursorColor: Theme.of(context).primaryColor,
                    selectionColor: Theme.of(context).colorScheme.primary,
                    style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      overflow: TextOverflow.ellipsis,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return GridView.count(
                      crossAxisCount: 3,
                      addAutomaticKeepAlives: true,
                      primary: true,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.0,
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
                    );
                  },
                ),
              ),

              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Center(
                      child: IconButton(
                        icon: const Icon(Icons.backspace_outlined),
                        color: Theme.of(context).colorScheme.onSurface,
                        iconSize: 25,
                        onPressed: dialerController.delete,
                        onLongPress: dialerController.deleteAll,
                        tooltip: '删除',
                      ),
                    ),
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
                        size: 45,
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
