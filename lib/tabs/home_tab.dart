import 'package:beauty_shopping_application/widgets/custom_action_bar.dart';
import 'package:beauty_shopping_application/widgets/product_card.dart';
import 'package:beauty_shopping_application/widgets/category_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeTab extends StatelessWidget {
  final CollectionReference _productsRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
          child: Stack(
            children: [
              Container(
                height: size.height*0.5,
                width: size.width,
                margin: EdgeInsets.only(top: 60,),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.centerLeft,
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/home2.jpg'),
                  ),
                  color: Color(0xFFE9D5CA),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(32), bottomRight: Radius.circular(32)),
                ),
                child: Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(top: 42, right: 15),
                  child: Column(
                    children: [
                      Text(
                          'Cosmetics',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.grey[850],
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                      Text(
                        'Beauty Power',
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.grey[850],
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(top:465, left: 20),
                  child: Text(
                    'Categories',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.grey[80],
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              FutureBuilder<QuerySnapshot>(
                future: _productsRef.get(),
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
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.only(
                        top: 500.0,
                        bottom: 70.0,
                      ),
                      children: snapshot.data.docs.map((document) {
                        return CategoryCard(
                          imageUrl: document.data()['category_icon'],
                          category: document.data()['category'],
                          categoryId: document.id,
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
              Container(
                  margin: EdgeInsets.only(top:640, left: 20),
                  child: Text(
                    'Popular Products',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.title.copyWith(
                      color: Colors.grey[80],
                      fontWeight: FontWeight.bold,
                    ),
                  )
              ),
              FutureBuilder<QuerySnapshot>(
                future: _productsRef.get(),
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
                        top: 670.0,
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
                  );},
              ),
              CustomActionBar(
                title: "",
                hasBackArrrow: false,
              ),
            ],
         ),
    );
  }
}
