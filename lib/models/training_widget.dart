import 'package:flutter/material.dart';

enum WidgetType { speed, distance, heartRate, cadence, power, calories }

class TrainingWidget {
  WidgetType type;
  double widthFactor;
  double heightFactor;
  Offset position;

  TrainingWidget({
    required this.type,
    this.widthFactor = 1,
    this.heightFactor = 1,
    this.position = const Offset(0, 0),
  });

  Widget buildWidget(int value) {
    String label = '';
    switch (type) {
      case WidgetType.speed:
        label = '$value km/h';
        break;
      case WidgetType.distance:
        label = '$value km';
        break;
      case WidgetType.heartRate:
        label = '$value bpm';
        break;
      case WidgetType.cadence:
        label = '$value rpm';
        break;
      case WidgetType.power:
        label = '$value W';
        break;
      case WidgetType.calories:
        label = '$value kcal';
        break;
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.2),
        border: Border.all(color: Colors.white),
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(color: Colors.white, fontSize: 20),
      ),
    );
  }
}
