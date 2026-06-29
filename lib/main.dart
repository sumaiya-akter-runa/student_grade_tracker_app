import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'subject_provider.dart';
import 'theme_provider.dart';
import 'navigation_provider.dart';
import 'add_subject_screen.dart';
import 'subject_list_screen.dart';
import 'summary_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SubjectProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => NavigationProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      title: 'Grade Tracker',
      theme: _lightTheme,
      darkTheme: _darkTheme,
      themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),   // এখানে const রাখা যাবে
      debugShowCheckedModeBanner: false,
    );
  }
}

// Beautiful Themes
final ThemeData _lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: const Color(0xFF6E4BFF),
  scaffoldBackgroundColor: const Color(0xFFF8F6FF),
  cardColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF6E4BFF),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
);

final ThemeData _darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: const Color(0xFF8B6EFF),
  scaffoldBackgroundColor: const Color(0xFF0A0A0F),
  cardColor: const Color(0xFF1A1A2E),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xFF6E4BFF),
    foregroundColor: Colors.white,
    elevation: 0,
  ),
);

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navProvider = Provider.of<NavigationProvider>(context);

    final List<Widget> screens = [
      const AddSubjectScreen(),
      const SubjectListScreen(),
      const SummaryScreen(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Grade Tracker'),
        actions: [
          Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              return IconButton(
                icon: Icon(
                  themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
                ),
                onPressed: () => themeProvider.toggleTheme(),
              );
            },
          ),
        ],
      ),
      body: screens[navProvider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: navProvider.currentIndex,
        onTap: (index) => navProvider.setIndex(index),
        selectedItemColor: const Color(0xFF6E4BFF),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.add_circle), label: 'Add'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'List'),
          BottomNavigationBarItem(icon: Icon(Icons.analytics), label: 'Summary'),
        ],
      ),
    );
  }
}