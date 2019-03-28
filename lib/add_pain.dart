import 'package:flutter/material.dart';
import 'package:pain_tracker/BlocProvider.dart';
import 'package:pain_tracker/PainBloc.dart';
import 'package:pain_tracker/PainModel.dart';
import 'package:pain_tracker/enums.dart';

typedef void OnTap(Offset point);

class TapPicture extends StatelessWidget {
  TapPicture(
      {Key key,
      @required this.img,
      @required this.point,
      @required this.color,
      @required this.onTap})
      : super(key: key);

  final Offset point;
  final Image img;
  final OnTap onTap;
  final Color color;

  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        RenderBox box = context.findRenderObject();
        onTap(box.globalToLocal(details.globalPosition));
      },
      child: Stack(
        children: <Widget>[
          img,
          point != null
              ? Positioned(
                  left: point.dx,
                  top: point.dy,
                  child: Icon(
                    Icons.child_care,
                    color: color,
                  ))
              : null,
        ].where((x) => x != null).toList(),
      ),
    );
  }
}

class AddPain extends StatefulWidget {
  @override
  _AddPainState createState() => _AddPainState();
}

class _AddPainState extends State<AddPain> {
  PainLevel painLevel = PainLevel.low;
  PainLocation painLocation = PainLocation.hand;
  PainSide painSide = PainSide.left;
  Offset point;

  @override
  Widget build(BuildContext context) {
    var img = Image.asset(
      'assets/${painSide.toString().split('.')[1]}-${painLocation.toString().split('.')[1]}.jpg',
    );

    PainBloc bloc = BlocProvider.of<PainBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Pain"),
        centerTitle: true,
        actions: <Widget>[
          Center(
              child: FlatButton(
            child: Text("Save"),
            onPressed: () {
              bloc.newPain(Pain(
                  painLevel: painLevel,
                  painLocation: painLocation,
                  painSide: painSide,
                  point: point,
                  dt: DateTime.now()));
              Navigator.of(context).pop();
            },
          ))
        ],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(margin: EdgeInsets.all(10)),
          Text("Pain Level"),
          Container(margin: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: PainLevel.values
                .map((x) => RaisedButton(
                      onPressed: () {
                        setState(() {
                          painLevel = x;
                        });
                      },
                      color: x == painLevel ? Colors.lime : null,
                      child: Text(x.toString().split('.')[1]),
                    ))
                .toList(),
          ),
          Container(margin: EdgeInsets.all(30)),
          Text("Pain Location"),
          Container(margin: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: PainSide.values
                .map((x) => RaisedButton(
                      onPressed: () {
                        setState(() {
                          painSide = x;
                        });
                      },
                      color: x == painSide ? Colors.lime : null,
                      child: Text(x.toString().split('.')[1]),
                    ))
                .toList(),
          ),
          Container(margin: EdgeInsets.all(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: PainLocation.values
                .map((x) => RaisedButton(
                      onPressed: () {
                        setState(() {
                          painLocation = x;
                        });
                      },
                      color: x == painLocation ? Colors.lime : null,
                      child: Text(x.toString().split('.')[1]),
                    ))
                .toList(),
          ),
          Container(margin: EdgeInsets.all(30)),
          Text(point != null ? "${point.dx} ${point.dy}" : 'null...'),
          TapPicture(
            color: colorMap[painLevel.toString().split('.')[1]],
            img: img,
            point: point,
            onTap: (newPoint) {
              setState(() {
                point = newPoint;
              });
            },
          )
        ],
      )),
    );
  }
}
