import 'package:flutter/material.dart';

import '../services/page_storage_service.dart';
import '../models/training_record.dart';
import 'activity_detail_page.dart';

class ActivitiesPage extends StatefulWidget {
  const ActivitiesPage({super.key});

  @override
  State<ActivitiesPage> createState() => _ActivitiesPageState();
}

class _ActivitiesPageState extends State<ActivitiesPage> {
  final PageStorageService storage = PageStorageService();
  List<TrainingRecord> activities = [];

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final data = await storage.loadTrainings();
    setState(() {
      activities = data.reversed.toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Last Activities')),
      body: activities.isEmpty
          ? const Center(child: Text('هیچ تمرینی ثبت نشده'))
          : ListView.builder(
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final a = activities[index];
          return ListTile(
            leading: const Icon(Icons.directions_bike),
            title: Text(
              '${(a.distanceMeters / 1000).toStringAsFixed(2)} km',
            ),
            subtitle: Text(
              'زمان: ${Duration(seconds: a.durationSeconds).inMinutes} دقیقه',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ActivityDetailPage(record: a),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
