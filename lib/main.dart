import 'package:flutter/material.dart';
import 'package:project_akhir_tpm/screen/home_screen.dart';
import 'package:project_akhir_tpm/screen/login_screen.dart';
import 'package:project_akhir_tpm/screen/register_screen.dart';
import 'package:project_akhir_tpm/screen/valorant_character_view.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(
        colorScheme: ThemeData().colorScheme.copyWith(
              background:
                  Color.fromARGB(255, 11, 31, 46), // Warna latar belakang
            ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
          backgroundColor: Color.fromARGB(255, 11, 31, 46), // Warna AppBar
        ),
        primarySwatch: Colors.blue,
        textTheme: ThemeData().textTheme.apply(
              bodyColor: Colors.white, // Ubah warna teks menjadi putih
            ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => MainScreen(),
        '/register': (context) => RegisterScreen(),
        '/valorantCharacter': (context) => ValorantCharacterView(),
        '/valorantMaps': (context) => ValorantCharacterView(),
        '/valorantWeapon': (context) => ValorantCharacterView(),
      },
    );
  }
}
