import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // تمرین امروز
          Card(
            color: Colors.blueAccent,
            child: InkWell(
              onTap: () {
                // بعداً می‌ریم داخل تمرین
              },
              child: Container(
                width: double.infinity,
                height: 150,
                alignment: Alignment.center,
                child: const Text(
                  'تمرین امروز',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // آخرین فعالیت‌ها
          const Text(
            'آخرین فعالیت‌ها',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 3, // تعداد تمرینات فرضی
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: const Icon(Icons.directions_bike),
                  title: Text('تمرین شماره ${index + 1}'),
                  subtitle: const Text('مسافت: 12 km • کالری: 450 kcal'),
                  onTap: () {},
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
