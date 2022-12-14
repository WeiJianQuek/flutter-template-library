import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'component/template/app_template_component.dart';
import 'controller/app_controller.dart';
import 'route/controller/entry/splash_entry_controller_route.dart';
import 'utility/app_utility.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appController = await AppController.initialise();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return appController;
          },
        ),
      ],
      child: AppTemplateComponent(
        name: await AppUtility.name,
        layout: SplashEntryControllerRoute.screen(),
      ),
    ),
  );
}
