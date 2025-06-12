import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class TimePickerWidget extends StatelessWidget {
  final TimeOfDay selectedTime;
  final VoidCallback onTap;

  const TimePickerWidget({
    super.key,
    required this.selectedTime,
    required this.onTap,
  });

  String get formattedTime {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, selectedTime.hour, selectedTime.minute);
    return DateFormat('HH:mm').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Hora"),
      subtitle: Text(formattedTime),
      trailing: const Icon(Icons.access_time),
      onTap: onTap,
    );
  }
}
