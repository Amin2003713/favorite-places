import 'package:favorite_places/features/places/screans/places.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 235, 181, 194),
);

final theme = ThemeData(colorScheme: colorScheme).copyWith(
  textTheme: GoogleFonts.ubuntuCondensedTextTheme()
      .apply(
        bodyColor: colorScheme.onSurface,
        displayColor: colorScheme.onSurface,
      )
      .copyWith(
        titleSmall: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
        titleMedium: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
        titleLarge: GoogleFonts.ubuntuCondensed(fontWeight: FontWeight.bold),
      ),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: theme, home: PlacesScreen());
  }
}
