import 'package:flutter/material.dart';
import 'package:loja_virtual_app/model/cart_model.dart';
import 'package:loja_virtual_app/model/user_model.dart';
import 'package:loja_virtual_app/pages/login_screen.dart';
import 'package:loja_virtual_app/widgets/cart_tile.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu carrinho'),
        actions: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: 8.0),
            child: ScopedModelDescendant<CartModel>(
              builder: (context, child, model){
                int quantidade = model.products.length;
                return Text(
                  '${quantidade ?? 0} ${quantidade <= 1 ? "ITEM" : "ITENS"}',
                  style: TextStyle(fontSize: 17.0),
                );
              },
            )
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model){
          if(model.isLoading && UserModel.of(context).isLoggedIn()){
            return _retornaCarrinhoEmCarregamento();

          }else if(!UserModel.of(context).isLoggedIn()){

            return _retornaCarrinhoSemEstarLogado(context);

          } else if (model.products == null || model.products.length == 0){
             return _retonarCarrinhoVazio();
          }else{
            return _retornaCarrinhoComProdutos(model);

          }

        },
      ),
    );
  }

  Widget _retornaCarrinhoComProdutos(CartModel model){
    return ListView(
      children: <Widget>[
        Column(
          children: model.products.map((product){
            return CartTile(product);
          }).toList(),
        )
      ],
    );
  }

  Widget _retonarCarrinhoVazio(){
    return Center(
      child: Text(
        "Nenhum produto no carrinho!",
        style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold),
        textAlign: TextAlign.center)
    );
  }


  Widget _retornaCarrinhoEmCarregamento(){
    return Center( child: CircularProgressIndicator(),);
  }


  Widget _retornaCarrinhoSemEstarLogado(BuildContext context){
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.remove_shopping_cart, size: 80.0, color: Theme.of(context).primaryColor),
          SizedBox(height: 16.0,),
          Text("Faça o login para adicionar produtos!",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,),
          SizedBox(height: 16.0),
          RaisedButton(
              child: Text("Entrar", style: TextStyle(fontSize: 30.0),),
              textColor: Colors.white,
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginScreen())
                );
              }
          ),
        ],
      ),
    );
  }

}
