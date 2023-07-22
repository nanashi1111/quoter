import 'package:flutter/material.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/screen/home/home_screen.dart';
import 'package:quoter/screen/route/go_route.dart';

void main() async {
  await configInstances();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return MaterialApp.router(
      routerConfig: router,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
        canvasColor: Colors.white,///here
      ),
      debugShowCheckedModeBanner: false,
    );

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: false,
        canvasColor: Colors.white,///here
      ),
      home: HomeScreen(),
    );
  }
}
