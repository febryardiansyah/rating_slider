import 'package:flutter/material.dart';
import 'package:rating_slider/rating_slider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("RatingSlider Example")),
        body: Center(
          child: RatingSlider(
            initialRating: 1,
            iconBuilder: (context, index, type) {
              switch (type) {
                case RatingType.full:
                  return Icon(Icons.star, color: Colors.amber);
                case RatingType.half:
                  return Icon(Icons.star_half, color: Colors.amber);
                case RatingType.empty:
                default:
                  return Icon(Icons.star_border, color: Colors.grey);
              }
            },
            onRatingUpdate: (rating) {
              debugPrint("Rating: $rating");
            },
          ),
        ),
      ),
    );
  }
}
