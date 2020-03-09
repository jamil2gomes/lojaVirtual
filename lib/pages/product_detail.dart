import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_app/data/cart_product.dart';
import 'package:loja_virtual_app/data/product.dart';
import 'package:loja_virtual_app/model/cart_model.dart';
import 'package:loja_virtual_app/model/user_model.dart';
import 'package:loja_virtual_app/pages/cart_screen.dart';
import 'package:loja_virtual_app/pages/login_screen.dart';

class ProductDetail extends StatefulWidget {
  final Product product;

  ProductDetail(this.product);

  @override
  _ProductDetailState createState() => _ProductDetailState(product);
}

class _ProductDetailState extends State<ProductDetail> {
  Product product;
  String tamanhoSelecionado;

  _ProductDetailState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.imgs.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotSpacing: 15.0,
              dotBgColor: Colors.transparent,
              dotColor: Theme.of(context).primaryColor,
              autoplay: false,
            ),
          ),
          Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    product.title,
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                    maxLines: 3,
                  ),
                  Text(
                    product.price.toStringAsFixed(2),
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                    maxLines: 3,
                  ),
                  SizedBox(
                    height: 6.0,
                  ),
                  Text(
                    'Tamanho',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 34.0,
                    child: GridView(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(vertical: 4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 0.5,
                      ),
                      children: product.sizes.map((tamanho) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              tamanhoSelecionado = tamanho;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: tamanho == tamanhoSelecionado
                                      ? Theme.of(context).primaryColor
                                      : Colors.grey[500],
                                  width: 3.0),
                            ),
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Text(tamanho),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  SizedBox(
                    height: 44.0,
                    child: RaisedButton(
                      onPressed: tamanhoSelecionado != null
                          ? () {
                              if (UserModel.of(context).isLoggedIn()) {
                                CartProduct cartProduct = CartProduct();
                                cartProduct.size = tamanhoSelecionado;
                                cartProduct.quantity = 1;
                                cartProduct.product_id = product.id;
                                cartProduct.category = product.category;

                                CartModel.of(context).addCartItem(cartProduct);

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => CartScreen()));
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                              }
                            }
                          : null,
                      child: Text(
                        UserModel.of(context).isLoggedIn()
                            ? 'Adicionar ao Carrinho'
                            : 'Entre para comprar',
                        style: TextStyle(fontSize: 18.0),
                      ),
                      color: Theme.of(context).primaryColor,
                      textColor: Colors.white,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
