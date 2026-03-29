import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import 'dialogview_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HomeView'), centerTitle: true),
      body: Center(child: Obx(() => Text('${controller.count.value}', style: Theme.of(context).textTheme.displaySmall))),
      floatingActionButton: FloatingActionButton(onPressed: controller.increment, child: const Icon(Icons.add)),
      persistentFooterButtons: [
        TextButton(onPressed: () => Get.dialog(const DialogviewView()), child: const Text('Open Dialog')),
      ],
    );
  }
}
