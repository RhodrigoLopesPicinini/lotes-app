import 'package:flutter/material.dart';
import 'package:registro_lotes_app/states/acres_state.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:registro_lotes_app/home_screen.dart';
import 'package:registro_lotes_app/states/users_state.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AcresState()),
      ChangeNotifierProvider(create: (_) => UsersState()),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AcresState()),
        ChangeNotifierProvider(create: (_) => UsersState()),
      ],
      child: MaterialApp(
        title: 'Lotes App',
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.promptTextTheme(),
        ),
        home: HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
