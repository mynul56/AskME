import 'package:get/get.dart';
import '../../core/constants/app_routes.dart';

class Question {
  final String title;
  final String hint;
  final List<String> options;
  final List<String> subTexts;
  Question({required this.title, required this.hint, required this.options, required this.subTexts});
}

class QuestionnaireController extends GetxController {
  final RxInt       currentStep = 0.obs;
  final RxList<int> answers     = <int>[].obs;

  final List<Question> questions = [
    Question(
      title: 'How has your mental clarity felt throughout the first half of the day?',
      hint: 'Select the state that most closely resonates with your current feeling.',
      options: ['Effortless & Radiant', 'Calm & Grounded', 'Mildly Hazy', 'Noticeable Resistance'],
      subTexts: ['Thoughts are flowing without any friction.', 'Stable focus, though requiring light intention.', 'Slight difficulty sustaining deep concentration.', 'Significant mental fatigue or distraction.'],
    ),
    Question(
      title: 'How would you describe your energy levels right now?',
      hint: 'Consider your physical and mental energy combined.',
      options: ['Fully Charged', 'Moderate Energy', 'Running Low', 'Depleted'],
      subTexts: ['Ready for high-intensity demands.', 'Adequate for standard tasks.', 'Need strategic allocation.', 'Rest or reset required.'],
    ),
    Question(
      title: 'What is your primary goal for this session?',
      hint: 'What outcome do you most want from this AI interaction?',
      options: ['Gain Clarity', 'Create Action Plan', 'Process Emotions', 'Get a Message Draft'],
      subTexts: ['Understand the situation better.', 'Concrete steps to move forward.', 'Sort through feelings.', 'Words to communicate effectively.'],
    ),
  ];

  int get totalSteps => questions.length;
  double get progress => (currentStep.value + 1) / totalSteps;
  Question get currentQ => questions[currentStep.value];

  int selectedIndex = -1;

  void selectOption(int index) {
    selectedIndex = index;
    update();
  }

  void next() {
    if (selectedIndex == -1) {
      Get.snackbar('Select an option', 'Please choose one before continuing.',
          backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.9),
          colorText: Get.theme.colorScheme.onPrimary);
      return;
    }
    if (answers.length <= currentStep.value) {
      answers.add(selectedIndex);
    } else {
      answers[currentStep.value] = selectedIndex;
    }
    selectedIndex = -1;
    if (currentStep.value < totalSteps - 1) {
      currentStep.value++;
    } else {
      Get.toNamed(AppRoutes.aiResponse);
    }
  }

  void previous() {
    if (currentStep.value > 0) {
      currentStep.value--;
      selectedIndex = answers.length > currentStep.value ? answers[currentStep.value] : -1;
      update();
    } else {
      Get.back();
    }
  }
}
