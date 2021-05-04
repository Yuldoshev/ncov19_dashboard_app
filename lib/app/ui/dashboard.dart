import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ncov19_dashboard_app/app/repositories/data_repository.dart';
import 'package:ncov19_dashboard_app/app/repositories/endpoints_data.dart';
import 'package:ncov19_dashboard_app/app/services/api.dart';
import 'package:ncov19_dashboard_app/app/ui/endpoint_card.dart';
import 'package:ncov19_dashboard_app/app/ui/last_update_status_text.dart';
import 'package:ncov19_dashboard_app/app/ui/show_alert_dialog.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  EndpointsData _endpointsData;

  @override
  void initState() {
    super.initState();
    final dataRepository = Provider.of<DataRepository>(context, listen: false);
    _endpointsData = dataRepository.getAllEndpointsCacheData();
    _updateData();
  }

  Future<void> _updateData() async {
    try {
      final dataRepository =
          Provider.of<DataRepository>(context, listen: false);
      final endpointsData = await dataRepository.getAllEndpointsData();
      setState(() => _endpointsData = endpointsData);
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: 'Ulanishda xatolik',
          content:
              'Ma\'lumotlar olinmadi. Iltimos keyinroq qayta urinib ko\'ring',
          defaultActionText: 'OK');
    } catch (_) {
      showAlertDialog(
          context: context,
          title: 'Noma\'lum xato',
          content:
              'Iltimos, qo\'llab-quvvatlash xizmatiga murojaat qiling yoki keyinroq qayta urinib ko\'ring',
          defaultActionText: 'OK');
    }
  }

  @override
  Widget build(BuildContext context) {
    final formatter = LastUpdatedFormatter(
      lastUpdated: _endpointsData != null
          ? _endpointsData.values[Endpoint.cases]?.date
          : null,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Coronavirus statiskiasi"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _updateData,
        child: ListView(
          children: [
            LastUpdateStatusText(
              text: formatter.lastUpdatedStatusText(),
            ),
            for (var endpoint in Endpoint.values)
              EndpointCard(
                endpoint: endpoint,
                value: _endpointsData != null
                    ? _endpointsData.values[endpoint]?.value
                    : null,
              ),
          ],
        ),
      ),
    );
  }
}
