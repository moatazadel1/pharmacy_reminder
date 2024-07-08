import 'package:flutter/material.dart';
import 'package:reminder_app/models/category_model.dart';
import 'package:stroke_text/stroke_text.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});
  final CategoryModel category;
  @override
  Widget build(BuildContext context) {
    var rating;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: 70,
        width: 190,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(category.categoryImage), fit: BoxFit.fill),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: const Color(0xFF295c82), width: 1.5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(4),
              child: Center(
                child: StrokeText(
                  text: category.categoryName,
                  textStyle: TextStyle(fontSize: 25, color: Colors.white),
                  strokeColor: Colors.black,
                  strokeWidth: 3,
                ),
              ),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 60, right: 0),
                  child: Icon(Icons.trending_up,
                      size: 30, color: Color(0xFF295c82)),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 6),
                  child: StrokeText(
                  text: category.categoryPrecent,
                  textStyle: TextStyle(fontSize: 20, color: Colors.black),
                  strokeColor: Colors.white,
                  strokeWidth: 2,
                ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
