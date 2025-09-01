import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_ui_9/data/places.dart';
import 'pages/home_page.dart';

void main() => runApp(ConstrainedBox(
    constraints: const BoxConstraints(minWidth: 450), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        builder: (context, child) => ResponsiveBreakpoints(breakpoints: const [
          Breakpoint(start: 0, end: 450, name: MOBILE),
          Breakpoint(start: 451, end: 800, name: TABLET),
          Breakpoint(start: 801, end: 1920, name: DESKTOP),
        ], child: child!),
        debugShowCheckedModeBanner: false,
        title: 'Tour App - Responsive',
        theme: ThemeData(colorSchemeSeed: Colors.green),
        home: const HomePage(
          places: allPlaces,
        ),
      );
}
