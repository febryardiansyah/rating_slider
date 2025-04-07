# RatingSlider

A highly customizable Flutter rating bar that supports drag and tap interactions, half ratings, and dynamic icons.

<div align="center">
    <img src="https://raw.githubusercontent.com/febryardiansyah/rating_slider/refs/heads/master/asset/demo.gif" alt="Frosted Toast Demo" width="250" />
</div>

## Usage

```dart
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
```

For more examples, check the `/example` folder in the repository.