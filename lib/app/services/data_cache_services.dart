import 'package:flutter/cupertino.dart';
import 'package:ncov19_dashboard_app/app/repositories/endpoints_data.dart';
import 'package:ncov19_dashboard_app/app/services/api.dart';
import 'package:ncov19_dashboard_app/app/services/endpoint_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheService {
  DataCacheService({@required this.sharedPreferences});
  final SharedPreferences sharedPreferences;

  static String endpointValueKey(Endpoint endpoint) => '$endpoint/value';
  static String endpointDateKey(Endpoint endpoint) => '$endpoint/date';

  EndpointsData getData() {
    Map<Endpoint, EndpointData> values = {};
    Endpoint.values.forEach((endpoint) {
      final value = sharedPreferences.getInt(endpointValueKey(endpoint));
      final dateString = sharedPreferences.getString(endpointDateKey(endpoint));
      if (value != null && dateString != null) {
        // ignore: unused_local_variable
        final date = DateTime.tryParse(dateString);
      }
    });
    return EndpointsData(values: values);
  }

  Future<void> setdata(EndpointsData endpointsData) async {
    endpointsData.values.forEach((endpoint, endpointData) async {
      await sharedPreferences.setInt(
          endpointValueKey(endpoint), endpointData.value);
      await sharedPreferences.setString(
          endpointDateKey(endpoint), endpointData.date.toIso8601String());
    });
  }
}
