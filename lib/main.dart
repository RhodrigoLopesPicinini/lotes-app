import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:registro_lotes_app/states/users_state.dart';
import 'package:registro_lotes_app/states/acres_state.dart';
import 'package:registro_lotes_app/screens/home_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AcresState()),
      ChangeNotifierProvider(create: (_) => UsersState()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PlotMarket App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.promptTextTheme(),
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
    );
  }
}
