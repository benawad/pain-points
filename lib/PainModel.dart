import 'dart:convert';
import 'dart:ui';

import 'package:pain_tracker/enums.dart';

Pain painFromJson(String str) {
  final jsonData = json.decode(str);
  return Pain.fromJson(jsonData);
}

String painToJson(Pain data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Pain {
  int id;
  PainLevel painLevel;
  PainLocation painLocation;
  PainSide painSide;
  Offset point;
  DateTime dt;

  Pain({
    this.id,
    this.painLevel,
    this.painLocation,
    this.painSide,
    this.point,
    this.dt,
  });

  factory Pain.fromJson(Map<String, dynamic> json) => new Pain(
      id: json["id"],
      painLevel: PainLevel.values[json["pain_level"]],
      painLocation: PainLocation.values[json["pain_location"]],
      painSide: PainSide.values[json["pain_side"]],
      point: Offset(json["x"], json["y"]),
      dt: DateTime.fromMillisecondsSinceEpoch(json["dt"]));

  Map<String, dynamic> toJson() => {
        "id": id,
        "pain_level": painLevel.index,
        "pain_location": painLocation.index,
        "pain_side": painSide.index,
        "x": point.dx,
        "y": point.dy,
        "dt": dt.millisecondsSinceEpoch
      };
}
