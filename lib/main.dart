import 'package:flutter/material.dart';
import 'package:registro_lotes_app/app_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/first_screen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MaterialApp(
        title: 'Lotes App',
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: FirstScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
