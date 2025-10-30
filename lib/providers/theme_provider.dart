import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = true;

  bool get isDarkMode => _isDarkMode;

  ThemeData get lightTheme => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF6366F1), // Modern indigo
      brightness: Brightness.light,
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF6366F1),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(width: 1.5),
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );

  ThemeData get darkTheme => ThemeData(
    colorScheme:
        ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1), // Modern indigo
          brightness: Brightness.dark,
        ).copyWith(
          // Enhanced dark theme colors
          surface: const Color(0xFF0F0F0F), // Deeper dark background
          onSurface: const Color(0xFFE4E4E7), // Softer white text
          surfaceContainerHighest: const Color(0xFF1C1C1E), // Card backgrounds
          outline: const Color(0xFF3F3F46), // Subtle borders
        ),
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),
    useMaterial3: true,
    scaffoldBackgroundColor: const Color(0xFF0A0A0A), // Very dark scaffold
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF818CF8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        shadowColor: Colors.black.withOpacity(0.3),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        textStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        side: const BorderSide(width: 1.5),
      ),
    ),
    cardTheme: const CardThemeData(
      elevation: 4,
      shadowColor: Colors.black54,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
  );

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setTheme(bool isDark) {
    _isDarkMode = isDark;
    notifyListeners();
  }
}
