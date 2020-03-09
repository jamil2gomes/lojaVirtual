import 'package:flutter/material.dart';
import 'package:loja_virtual_app/data/product.dart';
import 'package:loja_virtual_app/pages/product_detail.dart';

class ProductTile extends StatelessWidget {
  String type;
  Product product;

  ProductTile(this.type, this.product);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProductDetail(product)));
      },
      child: Card(
        child: type == 'grid' ?
         _disporProdutosEmGrade(context):
         _disporProdutosEmLista(context),
      ),
    );
  }



Widget _disporProdutosEmGrade(context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 0.8,
          child: Image.network(product.imgs[0], fit: BoxFit.cover,),

        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(product.title, style: TextStyle( fontWeight: FontWeight.w500),),
                Text("R\$ ${product.price.toStringAsFixed(2)}", style: TextStyle( color: Theme.of(context).primaryColor, fontSize: 17.0, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
        )
      ],
    );
}

Widget _disporProdutosEmLista(context){
    return  Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Image.network(product.imgs[0], fit: BoxFit.cover, height: 250.0,),
        ),
        Flexible(
          flex: 1,
          child:Container(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Text(product.title, style: TextStyle( fontWeight: FontWeight.w500),),
                Text("R\$ ${product.price.toStringAsFixed(2)}", style: TextStyle( color: Theme.of(context).primaryColor, fontSize: 17.0, fontWeight: FontWeight.bold),)
              ],
            ),
          ) ,
        )
      ],
    );
}

}
