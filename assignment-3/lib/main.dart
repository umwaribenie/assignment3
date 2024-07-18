
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:assignment_2/networkdetector/dependency.dart';
import 'package:assignment_2/tabs.dart';
import 'package:assignment_2/battery/battery_codes.dart';
import 'package:assignment_2/preferences_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  BatteryReceiver.registerBatteryReceiver();
  runApp(const MyApp());
}

Future<void> initServices() async {
  DependencyInjection.init();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ThemeModePreference>(
      future: PreferencesService().getThemeMode(),
      builder: (context, snapshot) {
        final ThemeModePreference initialThemeMode = snapshot.data ?? ThemeModePreference.light;
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: initialThemeMode == ThemeModePreference.light ? ThemeMode.light : ThemeMode.dark,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          home: Fabtabs(selectedIndex: 0),
            builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
              child: child!,

            );

          },
        );
      },
    );
  }
}
