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
        body: const SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
          child: RatingInput(),
        ),
      ),
    );
  }
}

class RatingInput extends StatefulWidget {
  const RatingInput({super.key});

  @override
  State<RatingInput> createState() => _RatingInputState();
}

class _RatingInputState extends State<RatingInput> {
  final TextEditingController _controller = TextEditingController();
  double _rating = 0;

  void _updateRating() {
    final input = double.tryParse(_controller.text);
    if (input != null && input >= 0 && input <= 5) {
      setState(() {
        _rating = input;
      });
      debugPrint("Manual Rating: $_rating");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          controller: _controller,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "Enter Rating (0-5)",
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _updateRating,
          child: const Text("Submit Rating"),
        ),
        const SizedBox(height: 10),
        RatingSlider(
          initialRating: _rating,
          iconBuilder: (context, index, type) {
            switch (type) {
              case RatingType.full:
                return const Icon(Icons.star, color: Colors.amber);
              case RatingType.half:
                return const Icon(Icons.star_half, color: Colors.amber);
              case RatingType.empty:
              default:
                return const Icon(Icons.star_border, color: Colors.grey);
            }
          },
          onRatingUpdate: (rating) {
            debugPrint("Rating: $rating");
            setState(() {
              _controller.text = rating.toStringAsFixed(1);
              _rating = rating;
            });
          },
        ),
      ],
    );
  }
}
