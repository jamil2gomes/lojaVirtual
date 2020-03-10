import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_app/model/cart_model.dart';

class DiscountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: Text(
          'Cupom de Desconto',
          textAlign: TextAlign.start,
          style: TextStyle(
              fontWeight: FontWeight.w500;
              color: Colors.grey[700]
          ),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Digite seu cupom"
              ),
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (value){
                Firestore.instance.collection('coupon')
                    .document(value)
                    .get().then(
                    (doc){
                      if(doc.data != null){
                        Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text("Desconto de ${doc.data['percent']} % aplicado!"),
                          backgroundColor: Theme.of(context).primaryColor,)
                        );
                      }else{
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("Cupom não existente!"),
                              backgroundColor: Colors.redAccent,)
                        );
                      }
                    });
              },
            ),
          )
        ],
      ),
    );
  }
}
