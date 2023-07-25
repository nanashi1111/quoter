import 'package:flutter/material.dart';
import 'package:quoter/common/dependency_injection.dart';
import 'package:quoter/screen/route/go_route.dart';

void main() async {
  await configInstances();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  }
}
