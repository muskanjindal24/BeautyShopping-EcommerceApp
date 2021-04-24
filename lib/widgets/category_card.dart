import 'package:beauty_shopping_application/screens/category_page.dart';
import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String categoryId;
  final Function onPressed;
  final String imageUrl;
  final String category;
  CategoryCard({this.onPressed, this.imageUrl, this.category, this.categoryId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CategoryPage(categoryId: categoryId, category: category,),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE9D5CA),
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 120.0,
        width: 100.0,
        margin: EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 10.0,
        ),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Container(
              height: 70.0,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  "$imageUrl",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            /*Positioned(
              top: 100,
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: Constants.regularHeading,
                    ),
                    Text(
                      price,
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                  ],
                ),
              ),
            )*/
          ],
        ),
      ),
    );
  }
}
