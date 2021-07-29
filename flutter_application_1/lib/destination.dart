import 'package:json_annotation/json_annotation.dart';

part 'station.g.dart';

@JsonSerializable(nullable: false)
class Station {
  @JsonKey(name: 'line', nullable: false)
  final List<Line> line;

  Station(this.line);

  factory Station.fromJson(Map<String, dynamic> json) =>
      _$StationFromJson(json);
  Map<String, dynamic> toJson() => _$StationToJson(this);
}

@JsonSerializable(nullable: false)
class Line {
  @JsonKey(name: 'line_cd', nullable: false)
  final int lineCd;
  @JsonKey(name: 'line_name', nullable: false)
  final String lineName;

  Line(this.lineCd, this.lineName);

  factory Line.fromJson(Map<String, dynamic> json) => _$LineFromJson(json);
  Map<String, dynamic> toJson() => _$LineToJson(this);
}
