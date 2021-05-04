import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:ncov19_dashboard_app/app/repositories/data_repository.dart';
import 'package:ncov19_dashboard_app/app/services/api.dart';
import 'package:ncov19_dashboard_app/app/services/api_service.dart';
import 'package:ncov19_dashboard_app/app/services/data_cache_services.dart';
import 'package:ncov19_dashboard_app/app/ui/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'uz_UZ';
  await initializeDateFormatting();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  const MyApp({Key key, @required this.sharedPreferences}) : super(key: key);
  final SharedPreferences sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Provider<DataRepository>(
      create: (_) => DataRepository(
          apiService: APIService(API.sandbox()),
          dataCacheService:
              DataCacheService(sharedPreferences: sharedPreferences)),
      child: MaterialApp(
        theme: ThemeData.light().copyWith(
          accentColor: Colors.white30,
          scaffoldBackgroundColor: Color(0xFF989eb9),
          cardColor: Color(0xFF797979),
        ),
        debugShowCheckedModeBanner: false,
        home: Dashboard(),
      ),
    );
  }
}
