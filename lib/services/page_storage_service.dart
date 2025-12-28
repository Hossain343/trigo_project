import 'dart:convert';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/training_record.dart';
import '../models/training_widget.dart';

class PageStorageService {
  static const _widgetsKey = 'custom_training_pages';
  static const _trainingsKey = 'saved_trainings';

  // =========================
  // Widgets (UI Layout)
  // =========================

  Future<void> saveWidgets(List<TrainingWidget> widgets) async {
    final prefs = await SharedPreferences.getInstance();
    final data = widgets
        .map((w) => {
      'type': w.type.index,
      'width': w.widthFactor,
      'height': w.heightFactor,
      'dx': w.position.dx,
      'dy': w.position.dy,
    })
        .toList();

    await prefs.setString(_widgetsKey, jsonEncode(data));
  }

  Future<List<TrainingWidget>> loadWidgets() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_widgetsKey);
    if (jsonStr == null) return [];

    final data = jsonDecode(jsonStr) as List;
    return data
        .map(
          (e) => TrainingWidget(
        type: WidgetType.values[e['type']],
        widthFactor: (e['width'] as num).toDouble(),
        heightFactor: (e['height'] as num).toDouble(),
        position: Offset(
          (e['dx'] as num).toDouble(),
          (e['dy'] as num).toDouble(),
        ),
      ),
    )
        .toList();
  }

  // =========================
  // Trainings (Activities)
  // =========================

  Future<void> saveTrainings(List<TrainingRecord> records) async {
    final prefs = await SharedPreferences.getInstance();
    final data = records.map((r) => r.toJson()).toList();
    await prefs.setString(_trainingsKey, jsonEncode(data));
  }

  Future<List<TrainingRecord>> loadTrainings() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonStr = prefs.getString(_trainingsKey);
    if (jsonStr == null) return [];

    final data = jsonDecode(jsonStr) as List;
    return data.map((e) => TrainingRecord.fromJson(e)).toList();
  }
}
