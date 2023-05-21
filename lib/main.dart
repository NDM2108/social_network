import 'package:flutter/material.dart';
import 'package:social_network/core/config/routes.dart';
import 'package:social_network/core/shared_preferences/shared_preferences_repository.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesRepository().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo', 
      locale: const Locale('en'),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
          brightness: Brightness.light, primaryColor: Colors.lightBlue[800], fontFamily: 'Inter'),
      routerConfig: Routes.router,
    );
  }
}
