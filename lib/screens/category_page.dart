import 'package:beauty_shopping_application/services/firebase_services.dart';
import 'package:beauty_shopping_application/widgets/custom_action_bar.dart';
import 'package:beauty_shopping_application/widgets/product_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoryPage extends StatefulWidget {
  final String categoryId;
  final String category;
  CategoryPage({this.categoryId, this.category});

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _selectedCategory;

  @override
  void initState(){
    super.initState();
    _selectedCategory = widget.category;
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _firebaseServices.productsRef
                .orderBy("category")
                .startAt([_selectedCategory]).endAt(
                ["$_selectedCategory\uf8ff"]).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }

              // Collection Data ready to display
              if (snapshot.connectionState == ConnectionState.done) {
                // Display the data inside a list view
                return ListView(
                  padding: EdgeInsets.only(
                    top: 128.0,
                    bottom: 12.0,
                  ),
                  children: snapshot.data.docs.map((document) {
                    return ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()['images'][0],
                      price: "\$${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList(),
                );
              }

              // Loading State
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 45.0,
            ),
            child: Center(
                //_selectedCategory = widget.category;
                //print(_selectedCategory);
            ),
          ),
          CustomActionBar(
            hasBackArrrow: true,
            title: "Category",
            hasBackground: true,
          )
        ],
      ),
    );
  }
}
