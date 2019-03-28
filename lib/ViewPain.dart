import 'package:flutter/material.dart';
import 'package:pain_tracker/PainModel.dart';
import 'package:pain_tracker/enums.dart';

typedef void OnTap(Offset point);

class ViewPain extends StatelessWidget {
  ViewPain(
      {Key key,
      @required this.img,
      @required this.point,
      @required this.pains,
      @required this.onTap})
      : super(key: key);

  final Offset point;
  final Image img;
  final List<Pain> pains;
  final OnTap onTap;

  Widget build(BuildContext context) {
    List<Widget> widgets = <Widget>[img];

    pains.forEach((p) {
      widgets.add(Positioned(
          left: p.point.dx,
          top: p.point.dy,
          child: Icon(
            Icons.child_care,
            color: colorMap[p.painLevel.toString().split('.')[1]],
          )));
    });

    if (point != null) {
      widgets.add(Positioned(
          left: point.dx,
          top: point.dy,
          child: Icon(
            Icons.child_care,
            color: Colors.white,
          )));
    }

    return GestureDetector(
        onTapDown: (TapDownDetails details) {
          RenderBox box = context.findRenderObject();
          onTap(box.globalToLocal(details.globalPosition));
        },
        child: Stack(children: widgets));
  }
}
