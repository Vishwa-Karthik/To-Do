import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import 'home_page.dart';

void main() async {
  // init HIVE
  await Hive.initFlutter();

  // open a container
  var box = await Hive.openBox("BOX");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: "home",
      routes: {
        "home": (context) => const HomePage(),
      },
    );
  }
}
