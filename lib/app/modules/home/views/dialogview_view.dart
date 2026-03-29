import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/dialogcontroller_controller.dart';

class DialogviewView extends GetView<DialogcontrollerController> {
  const DialogviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AlertDialog(
        title: Text(controller.title.value),
        content: Text(controller.message.value),
        actions: [TextButton(onPressed: Get.back, child: const Text('Close'))],
      ),
    );
  }
}
