import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LastUpdatedFormatter {
  LastUpdatedFormatter({@required this.lastUpdated});
  final DateTime lastUpdated;

  String lastUpdatedStatusText() {
    if (lastUpdated != null) {
      final formatter = DateFormat.yMd().add_Hms();
      final formatted = formatter.format(lastUpdated);
      return 'Oxirgi yangilanish: $formatted';
    }
    return '';
  }
}

class LastUpdateStatusText extends StatelessWidget {
  const LastUpdateStatusText({Key key, @required this.text}) : super(key: key);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        textAlign: TextAlign.center,
      ),
    );
  }
}
