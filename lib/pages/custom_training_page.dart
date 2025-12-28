import 'package:flutter/material.dart';
import '../models/training_widget.dart';

class CustomTrainingPage extends StatefulWidget {
  const CustomTrainingPage({super.key});

  @override
  State<CustomTrainingPage> createState() => _CustomTrainingPageState();
}

class _CustomTrainingPageState extends State<CustomTrainingPage> {
  List<TrainingWidget> widgets = [
    TrainingWidget(type: WidgetType.speed),
    TrainingWidget(type: WidgetType.distance),
    TrainingWidget(type: WidgetType.heartRate),
  ];

  Map<WidgetType, int> liveValues = {
    WidgetType.speed: 24,
    WidgetType.distance: 12,
    WidgetType.heartRate: 145,
    WidgetType.cadence: 85,
    WidgetType.power: 220,
    WidgetType.calories: 320,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(title: const Text('صفحه تمرین شخصی‌سازی')),
      body: Stack(
        children: widgets
            .map((w) => Positioned(
          left: w.position.dx,
          top: w.position.dy,
          width: MediaQuery.of(context).size.width / 3 * w.widthFactor,
          height: MediaQuery.of(context).size.height / 5 * w.heightFactor,
          child: GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                w.position += details.delta;
              });
            },
            onLongPress: () {
              _showResizeDialog(w);
            },
            child: w.buildWidget(liveValues[w.type]!),
          ),
        ))
            .toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addWidget,
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addWidget() {
    setState(() {
      widgets.add(TrainingWidget(type: WidgetType.cadence));
    });
  }

  void _showResizeDialog(TrainingWidget w) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('تغییر اندازه'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('عرض: ${w.widthFactor.toStringAsFixed(1)}'),
            Slider(
              min: 0.5,
              max: 2,
              value: w.widthFactor,
              onChanged: (v) => setState(() => w.widthFactor = v),
            ),
            Text('ارتفاع: ${w.heightFactor.toStringAsFixed(1)}'),
            Slider(
              min: 0.5,
              max: 2,
              value: w.heightFactor,
              onChanged: (v) => setState(() => w.heightFactor = v),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('تایید'),
          )
        ],
      ),
    );
  }
}
