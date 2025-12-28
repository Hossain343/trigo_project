import 'package:flutter/material.dart';

import '../models/training_record.dart';
import '../services/gpx_exporter.dart';
import '../services/training_engine.dart';

class ActivityDetailPage extends StatelessWidget {
  final TrainingRecord record;
  final TrainingEngine engine = TrainingEngine();

  ActivityDetailPage({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('جزئیات تمرین')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _row('تاریخ', record.startTime.toString()),
            _row(
              'مدت',
              '${Duration(seconds: record.durationSeconds).inMinutes} دقیقه',
            ),
            _row(
              'مسافت',
              '${(record.distanceMeters / 1000).toStringAsFixed(2)} km',
            ),
            _row(
              'میانگین سرعت',
              '${(record.avgSpeed * 3.6).toStringAsFixed(1)} km/h',
            ),

            const Spacer(),

            ElevatedButton(
              onPressed: () async {
                final exporter = GpxExporter();
                await exporter.export(engine.trackPoints);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('فایل GPX ساخته شد')),
                );
              },
              child: const Text('Export GPX'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _row(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
