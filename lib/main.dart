import 'package:flutter/material.dart';
import 'package:loja_virtual_app/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: MaterialApp(
        title: 'Loja de Roupas',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            primaryColor: Color.fromARGB(255,4,125,141)
        ),
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}

