import 'package:flutter/material.dart';
import 'package:food_app/core/helpers/get_customer.dart';
import 'package:food_app/core/localization/languages.dart';
import 'package:food_app/core/navigation/app_views.dart';
import 'package:get/get.dart';
import 'package:food_app/core/theme/theme_provider.dart';
import 'package:food_app/core/components/bottom_navigation.dart';
import 'package:provider/provider.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  Get.put(CustomerController());
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Provider.of<ThemeProvider>(context, listen: false).loadTheme();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
          translations: Languages(),
          locale: Get.deviceLocale,
          fallbackLocale: const Locale("tr", "TR"),
          home: const CustomBottomNavigation(),
          getPages: AppViews.views,
        );
      },
    );
  }
}
