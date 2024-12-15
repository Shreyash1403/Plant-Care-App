// import 'package:flutter/material.dart';
// import 'package:plant_care_app/view/screens/add_plant_screen.dart';
// import 'package:plant_care_app/view/screens/detail_screen.dart';
// import 'package:plant_care_app/view/screens/home_screen.dart';
// import 'package:plant_care_app/view/screens/plants_list_screen.dart';
// import 'package:plant_care_app/view/screens/splash_screen.dart';
// import 'package:plant_care_app/view_model/task_view_model.dart';
// import 'package:provider/provider.dart';

// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (_) => TaskViewModel(),
//       child: const PlantApp(),
//     ),
//   );
// }

// class PlantApp extends StatelessWidget {
//   const PlantApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//         fontFamily: 'Poppins',
//       ),
//       initialRoute: '/',
//       routes: {
//         '/': (context) => const SplashScreen(),
//         '/home': (context) => const HomeScreen(),
//         '/plant-list': (context) => const PlantListScreen(),
//         '/add-plant': (context) => const AddPlantScreen(),
//         '/plant-details': (context) => const PlantDetailsScreen(),
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:plant_care_app/view/screens/add_plant_screen.dart';
import 'package:plant_care_app/view/screens/detail_screen.dart';
import 'package:plant_care_app/view/screens/home_screen.dart';
import 'package:plant_care_app/view/screens/plants_list_screen.dart';
import 'package:plant_care_app/view/screens/splash_screen.dart';
import 'package:plant_care_app/view_model/task_view_model.dart';
import 'package:plant_care_app/view_model/weather_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const PlantApp());
}

class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskViewModel()),
        ChangeNotifierProvider(create: (_) => WeatherViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
          fontFamily: 'Poppins',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/home': (context) => const HomeScreen(),
          '/plant-list': (context) => const PlantListScreen(),
          '/add-plant': (context) => const AddPlantScreen(),
          '/plant-details': (context) => const PlantDetailsScreen(),
        },
      ),
    );
  }
}
