import 'package:flutter/material.dart';
import 'package:loja_virtual_app/model/cart_model.dart';
import 'package:loja_virtual_app/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child: ScopedModelDescendant<UserModel>(
          builder: (context, child, model) {  //se o usuario mudar o carrinho tbm irá
            return ScopedModel < CartModel > (
                model: CartModel(model),
                child: MaterialApp(
                  title: 'Loja de Roupas',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    primaryColor: Color.fromARGB(255,4,125,141)
                ),
                  debugShowCheckedModeBanner: false,
                  home:Home(),
                )
            );
          },
        )
    );
  }
}

