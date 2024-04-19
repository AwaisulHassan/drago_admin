import 'package:drago_admin/dashboard/dashboard_screen.dart';
import 'package:drago_admin/provider/count_value_provider.dart';
import 'package:drago_admin/provider/text_color_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'constants.dart';
import 'controller/MenuAppController.dart';
import 'demo.dart';
import 'deposit/provider/deposit_provider.dart';
import 'firebase_options.dart';
import 'main/main_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => MenuAppController(),
          ),
          ChangeNotifierProvider(
            create: (context) => TextColorProvider(),
          ),

          ChangeNotifierProvider(
            create: (context) => CountValueProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DepositProvider(),
          ),
        ],
        child: MainScreen(),
      ),
    );
  }
}

