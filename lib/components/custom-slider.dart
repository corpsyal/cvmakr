import 'package:cvmakr/consts.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  Function onChanged;
  String value;

  CustomSlider({this.onChanged, this.value});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackShape: _CustomTrackShape(),
      ),
      child: Slider(
        min: 0,
        max: 100,
        value: double.parse(value),
        onChanged: onChanged,
        activeColor: primaryColor,
        inactiveColor: inactivePrimaryColor,
        label: value,
        divisions: 100,
      ),
    );
  }
}

class _CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
