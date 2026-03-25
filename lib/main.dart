import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'widgets/modern_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    GoogleFonts.pendingFonts([
      GoogleFonts.inter(),
      GoogleFonts.poppins(),
    ]),
  ]);
  runApp(const PortfolioApp());
}

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Jesselyn - Full-Stack Engineer',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.lightTheme,
            darkTheme: themeProvider.darkTheme,
            themeMode: themeProvider.isDarkMode
                ? ThemeMode.dark
                : ThemeMode.light,
            home: const ModernPortfolioApp(),
          );
        },
      ),
    );
  }
}

class ModernPortfolioApp extends StatelessWidget {
  const ModernPortfolioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ModernNavigation();
  }
}
