import 'package:flutter/foundation.dart';

class EndpointData {
  EndpointData({@required this.value, this.date}) : assert(value != null);
  final int value;
  final DateTime date;
}
