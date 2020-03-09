import 'package:cloud_firestore/cloud_firestore.dart';

class Product{
  String id;
  String title;
  String description;
  String category;
  double price;
  List imgs;
  List sizes;

  Product.fromDocument(DocumentSnapshot snapshot){
    id          = snapshot.documentID;
    title       = snapshot.data['title'];
    description = snapshot.data['description'];
    price       = snapshot.data['price'];
    imgs        = snapshot.data['img'];
    sizes       = snapshot.data['sizes'];
  }

  Map<String, dynamic> toResumedMap(){
    return{
      'title': title,
      'description':description,
      'price': price
    };
  }
}