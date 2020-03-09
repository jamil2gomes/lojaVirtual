import 'package:flutter/material.dart';
import 'package:loja_virtual_app/tabs/categoria_tab.dart';
import 'package:loja_virtual_app/tabs/home_tab.dart';
import 'package:loja_virtual_app/widgets/cart_button.dart';
import 'package:loja_virtual_app/widgets/custom_drawer.dart';


class Home extends StatelessWidget {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(), //não permite q arraste a tela pelo lado
      children: <Widget>[
       Scaffold(
         body:  HomeTab(),
         drawer: CustomDrawer(_pageController),
         floatingActionButton: CartButton(),
       ),
        Scaffold(
          appBar: AppBar(title: Text('Categorias'), centerTitle: true,),
          drawer: CustomDrawer(_pageController),
          body: CategoriaTab(),
          floatingActionButton: CartButton(),
        )
      ],
    );
  }
}
