import 'package:flutter/material.dart';
import 'package:preprations/screen/user_list_scren.dart';

 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        
        appBar: AppBar(title: Text('User List')),
        body: UserListScreen(),
      ),
    );
  }
}
