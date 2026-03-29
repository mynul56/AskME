import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/app_routes.dart';
import 'core/bindings/initial_binding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NOTE: Uncomment after adding google-services.json / GoogleService-Info.plist
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const CognitiveSanctuaryApp());
}

class CognitiveSanctuaryApp extends StatelessWidget {
  const CognitiveSanctuaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Cognitive Sanctuary',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialBinding: InitialBinding(),
      initialRoute: AppRoutes.welcome,
      getPages: AppRoutes.pages,
    );
  }
}
