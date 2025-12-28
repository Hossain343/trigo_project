class TrainingRecord {
  final DateTime startTime;
  final int durationSeconds;
  final double distanceMeters;
  final double avgSpeed;

  TrainingRecord({
    required this.startTime,
    required this.durationSeconds,
    required this.distanceMeters,
    required this.avgSpeed,
  });

  Map<String, dynamic> toJson() => {
    'startTime': startTime.toIso8601String(),
    'durationSeconds': durationSeconds,
    'distanceMeters': distanceMeters,
    'avgSpeed': avgSpeed,
  };

  factory TrainingRecord.fromJson(Map<String, dynamic> json) {
    return TrainingRecord(
      startTime: DateTime.parse(json['startTime']),
      durationSeconds: json['durationSeconds'],
      distanceMeters: (json['distanceMeters'] as num).toDouble(),
      avgSpeed: (json['avgSpeed'] as num).toDouble(),
    );
  }
}
