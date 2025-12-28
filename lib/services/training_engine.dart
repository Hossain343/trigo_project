import 'dart:async';

class TrainingEngine {
  bool running = false;
  List<dynamic> get trackPoints => [];

  int seconds = 0;
  double distance = 0.0; // کیلومتر
  int heartRate = 0; // bpm
  int calories = 0;

  Timer? _timer;

  /// شروع تمرین
  void start() {
    if (running) return;

    running = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      seconds++;

      // شبیه‌سازی داده‌ها (فعلاً)
      _simulateData();
    });
  }

  /// توقف تمرین
  void stop() {
    running = false;
    _timer?.cancel();
  }

  /// ذخیره تمرین (فعلاً ساده)
  void save() {
    stop();
    // بعداً: ذخیره در دیتابیس / فایل / سرور
  }

  /// فرمت زمان
  String formattedTime() {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  /// شبیه‌سازی دیتا تا وقتی سنسور وصل کنیم
  void _simulateData() {
    // سرعت فرضی → افزایش مسافت
    distance += 0.0025; // حدود 9km/h

    // ضربان قلب فرضی
    heartRate = 120 + (seconds % 40);

    // کالری ساده
    calories = (seconds / 6).round();
  }

  /// پاک‌سازی
  void dispose() {
    _timer?.cancel();
  }
}
