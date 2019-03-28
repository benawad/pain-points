import 'package:flutter/material.dart';
import 'package:pain_tracker/BlocProvider.dart';
import 'package:pain_tracker/PainBloc.dart';
import 'package:pain_tracker/PainModel.dart';
import 'package:pain_tracker/ViewPain.dart';
import 'package:pain_tracker/enums.dart';

void main() => runApp(BlocProvider<PainBloc>(bloc: PainBloc(), child: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: "yolo"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PainLevel painLevel = PainLevel.low;
  PainLocation painLocation = PainLocation.hand;
  PainSide painSide = PainSide.left;
  Offset point;

  @override
  Widget build(BuildContext context) {
    PainBloc bloc = BlocProvider.of<PainBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
          stream: bloc.pains,
          initialData: List<Pain>(),
          builder: (context, AsyncSnapshot<List<Pain>> snapshot) {
            var img = Image.asset(
              'assets/${painSide.toString().split('.')[1]}-${painLocation.toString().split('.')[1]}.jpg',
            );

            return SingleChildScrollView(
                child: Column(
              children: <Widget>[
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
                Container(margin: EdgeInsets.all(20)),
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
                Container(margin: EdgeInsets.all(20)),
                Text(point != null ? "${point.dx} ${point.dy}" : 'null...'),
                ViewPain(
                  point: point,
                  onTap: (newPoint) {
                    setState(() {
                      point = newPoint;
                    });
                  },
                  img: img,
                  pains: snapshot.data
                      .where((x) =>
                          x.painLocation == painLocation &&
                          x.painSide == painSide)
                      .toList(),
                ),
                RaisedButton(
                  color: Colors.pink,
                  child: Text("save point"),
                  onPressed: () {
                    bloc.newPain(Pain(
                        painLevel: painLevel,
                        painLocation: painLocation,
                        painSide: painSide,
                        point: point,
                        dt: DateTime.now()));
                    setState(() {
                      point = null;
                    });
                  },
                ),
                RaisedButton(
                  color: Colors.purple,
                  child: Text("remove last point"),
                  onPressed: () {
                    bloc.removeLastPain();
                    setState(() {
                      point = null;
                    });
                  },
                ),
                Container(margin: EdgeInsets.all(30)),
              ],
            ));
          }),
    );
  }
}
