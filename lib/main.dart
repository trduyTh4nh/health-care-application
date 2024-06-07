import 'package:app_well_mate/screen/home.dart';
import 'package:app_well_mate/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  final ColorScheme colorScheme = const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF6B94FF),
      onPrimary: Color(0xFFFFFFFF),
      secondary: Color(0xFFA8C5FD),
      onSecondary: Color(0xFF000000),
      error: Color(0xFFFF7D7D),
      onError: Color(0xFF000000),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF000000),
      surfaceDim: Color(0xFFF2F2F2));
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: colorScheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(colorScheme.primary),
                foregroundColor: WidgetStateProperty.all(colorScheme.onPrimary),
                shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
                minimumSize: WidgetStateProperty.all(Size(40, 50)),
                elevation: WidgetStateProperty.resolveWith((state) {
                  if (state.contains(WidgetState.pressed)) {
                    return 5;
                  }
                  return 0;
                })),
          ),
          filledButtonTheme: FilledButtonThemeData(style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(colorScheme.surfaceDim),
            foregroundColor: WidgetStateProperty.all(colorScheme.onSurface),
            minimumSize: WidgetStateProperty.all(Size(40, 50)),
            shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
          )),
          textButtonTheme: TextButtonThemeData(style: ButtonStyle(
            shape: WidgetStateProperty.all(const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16)))),
            minimumSize: WidgetStateProperty.all(Size(40, 50)),
          )),
          textTheme: TextTheme(
            bodyLarge: GoogleFonts.inter(
              fontSize: 16
            ),
            bodyMedium: GoogleFonts.inter(
              fontSize: 14
            ),
            bodySmall: GoogleFonts.inter(
              fontSize: 12
            ),
            displayLarge: GoogleFonts.inter(
              fontSize: 54,
              fontWeight: FontWeight.bold
            ),
            displayMedium: GoogleFonts.inter(
              fontSize: 46,
              fontWeight: FontWeight.bold
            ),
            displaySmall: GoogleFonts.inter(
              fontSize: 32,
              fontWeight: FontWeight.bold
            ),
            headlineLarge: GoogleFonts.inter(
              fontSize: 28,
              fontWeight: FontWeight.bold
            ),
            headlineMedium: GoogleFonts.inter(
              fontSize: 24,
            ),
            headlineSmall: GoogleFonts.inter(
              fontSize: 20,
            ),
            labelLarge: GoogleFonts.inter(
              fontSize: 16
            ),
            labelMedium: GoogleFonts.inter(
              fontSize: 14
            ),
            labelSmall: GoogleFonts.inter(
              fontSize: 12
            ),
            titleLarge: GoogleFonts.inter(
              fontWeight: FontWeight.bold
            ),
            titleMedium: GoogleFonts.inter(
              fontWeight: FontWeight.bold
            ),
            titleSmall: GoogleFonts.inter(
              fontWeight: FontWeight.bold
            )
          ),
          floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: colorScheme.surface,
            foregroundColor: colorScheme.onSurface,
            elevation: 5,
            iconSize: 32,
            shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(60)))
          )
          ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {}, child: Icon(Icons.add),),
        appBar: AppBar(title: Text("Home"), scrolledUnderElevation: 0,),
        body: Center(
          child: Home(),
        ),
      ),
    );
  }
}
