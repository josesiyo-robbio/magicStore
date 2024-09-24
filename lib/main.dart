import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:celes_store_magic/theme/theme.dart'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget 
{
  @override
  Widget build(BuildContext context) 
  {
    final materialTheme = MaterialTheme(ThemeData().textTheme);
    return MaterialApp
    (
      title: 'App Tiendita',
      theme       :   materialTheme.light(),  
      darkTheme   :   materialTheme.dark(), 
      home: HomeScreen(),
    );
  }
}
