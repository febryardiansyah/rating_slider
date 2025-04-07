import 'package:flutter/material.dart';

typedef RatingChangeCallback = void Function(double rating);
typedef IconBuilder = Widget Function(
  BuildContext context,
  int index,
  RatingType type,
);

enum RatingType { full, half, empty }

class RatingSlider extends StatefulWidget {
  final int count;
  final double initialRating;
  final bool allowHalfRating;
  final double areaItemSize;
  final RatingChangeCallback? onRatingUpdate;
  final IconBuilder iconBuilder;

  const RatingSlider({
    super.key,
    required this.iconBuilder,
    this.count = 5,
    this.initialRating = 0.0,
    this.allowHalfRating = true,
    this.areaItemSize = 40.0,
    this.onRatingUpdate,
  });

  @override
  State<RatingSlider> createState() => _RatingSliderState();
}

class _RatingSliderState extends State<RatingSlider> {
  late double _rating;

  @override
  void initState() {
    super.initState();
    _rating = widget.initialRating;
  }

  void _updateRatingFromPosition(Offset localPosition) {
    final boxWidth = widget.areaItemSize * widget.count;
    double x = localPosition.dx.clamp(0.0, boxWidth);
    double rawRating = x / widget.areaItemSize;
    double finalRating = widget.allowHalfRating
        ? (rawRating * 2).round() / 2
        : rawRating.ceilToDouble();

    setState(() {
      _rating = finalRating.clamp(0.0, widget.count.toDouble());
    });

    widget.onRatingUpdate?.call(_rating);
  }

  @override
  void didUpdateWidget(covariant RatingSlider oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialRating != widget.initialRating) {
      setState(() {
        _rating = widget.initialRating;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanDown: (details) => _updateRatingFromPosition(details.localPosition),
      onPanUpdate: (details) =>
          _updateRatingFromPosition(details.localPosition),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.count, (index) {
          double starValue = index + 1;
          RatingType type = RatingType.empty;

          if (_rating >= starValue) {
            type = RatingType.full;
          } else if (widget.allowHalfRating &&
              (_rating > index && _rating < starValue)) {
            type = RatingType.half;
          }

          return SizedBox(
            width: widget.areaItemSize,
            height: widget.areaItemSize,
            child: widget.iconBuilder(context, index, type),
          );
        }),
      ),
    );
  }
}
