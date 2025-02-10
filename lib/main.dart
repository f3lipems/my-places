import 'package:flutter/material.dart';
import 'package:my_places/screens/place_form_screen.dart';
import 'package:my_places/screens/places_list_screen.dart';
import 'package:my_places/utils/app_theme.dart';

import 'utils/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Places',
      theme: AppTheme.theme,
      home: const PlacesListScreen(),
      routes: {
        AppRoutes.PLACE_FORM: (ctx) => const PlaceFormScreen(),
      },
    );
  }
}
