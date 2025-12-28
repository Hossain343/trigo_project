import 'dart:async';
import 'package:flutter/material.dart';
import '../services/training_engine.dart'; // فقط import

class TrainingPage extends StatefulWidget {
  final String title;

  const TrainingPage({super.key, required this.title});

  @override
  State<TrainingPage> createState() => _TrainingPageState();
}

class _TrainingPageState extends State<TrainingPage> {
  final TrainingEngine _engine = TrainingEngine(); // اینجا instance بساز

  int _countdown = 3;
  bool _started = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  void _startCountdown() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown == 1) {
        timer.cancel();
        setState(() {
          _countdown = 0;
          _started = true;
          _engine.start(); // شروع تمرین
        });
      } else {
        setState(() {
          _countdown--;
        });
      }
    });
  }

  void _stop() {
    _engine.stop();
    setState(() {}); // برای به‌روزرسانی UI
  }

  void _save() {
    _engine.save();
    Navigator.pop(context);
  }

  String _fmt(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  Widget _data(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(
        '$title : $value',
        style: const TextStyle(fontSize: 18),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!_started) {
      return Scaffold(
        body: Center(
          child: Text(
            '$_countdown',
            style: const TextStyle(fontSize: 80, fontWeight: FontWeight.bold),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), automaticallyImplyLeading: false),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_fmt(_engine.seconds), style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _data('سرعت', '24.6 km/h'),
          _data('مسافت', '${_engine.distance.toStringAsFixed(2)} km'),
          _data('ضربان قلب', '${_engine.heartRate} bpm'),
          _data('کالری', '${_engine.calories} kcal'),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(onPressed: _engine.running ? _stop : null, child: const Text('STOP')),
              ElevatedButton(onPressed: _save, child: const Text('SAVE')),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
