import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_virtual_app/data/product.dart';
import 'package:loja_virtual_app/widgets/product_tile.dart';

class ProductScreen extends StatelessWidget {

  final DocumentSnapshot snapshot;

  ProductScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.data['title']),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(icon: Icon(Icons.grid_on)),
              Tab(icon: Icon(Icons.list))
            ],
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: Firestore.instance.collection('products').document(snapshot.documentID).collection('itens').getDocuments(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator(),);
            else
              return TabBarView(
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  _modoGrade(snapshot)
                  ,
                  _modoLista(snapshot)
                ],
              );
          },
        ),
      ),
    );
  }



  Widget _modoGrade(snapshot){
    return GridView.builder(
        padding: EdgeInsets.all(4.0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
          childAspectRatio: 0.65,
        ),
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index){
          Product data = Product.fromDocument(snapshot.data.documents[index]);
          data.category = this.snapshot.documentID;
          return ProductTile('grid', data);
        });
  }

  Widget _modoLista(snapshot){
    return ListView.builder(
        padding: EdgeInsets.all(4.0),
        itemCount: snapshot.data.documents.length,
        itemBuilder: (context, index) {
          Product data = Product.fromDocument(snapshot.data.documents[index]);
          data.category = this.snapshot.documentID;
          return ProductTile('list', data);
        }
        );
  }


}
