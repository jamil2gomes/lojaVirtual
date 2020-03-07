import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_virtual_app/model/product.dart';

class CartProduct{
  String id;
  String category;
  String product_id;
  int quantity;
  String size;

  Product product;


  CartProduct.fromDocument(DocumentSnapshot doc){
    id = doc.documentID;
    category = doc.data['category'];
    product_id = doc.data['product_id'];
    quantity = doc.data['quantity'];
    size = doc.data['size'];
  }

  Map<String, dynamic>toMap(){
    return{
      'category' : category,
      'prproduct_id' : product_id,
      'quantity': quantity,
      'size' : size,
      'product': product.toResumedMap()
    };
  }
}