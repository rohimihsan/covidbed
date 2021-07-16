import 'package:covidbed/screen/index.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ketersediaan Kasur Rumah Sakit',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/search',
      onGenerateRoute: (settings) {
        final arguments = settings.arguments;
        switch (settings.name) {
          case '/search':
            return MaterialPageRoute(builder: (_) => SearchPage());
          case '/info':
            return MaterialPageRoute(builder: (_) => InfoPage());
          case '/list':
            return MaterialPageRoute(
                builder: (_) => ListPage(arguments: arguments));
          default:
            return MaterialPageRoute(
                builder: (_) => Scaffold(
                      body: Center(child: Text("${settings.name} Not found")),
                    ));
        }
      },
    );
  }
}
