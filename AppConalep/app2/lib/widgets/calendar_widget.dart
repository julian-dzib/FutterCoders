import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class CalendarWidget extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onTap;

  const CalendarWidget({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  String get formattedDate => DateFormat('yyyy-MM-dd').format(selectedDate);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Fecha"),
      subtitle: Text(formattedDate),
      trailing: const Icon(Icons.calendar_today),
      onTap: onTap,
    );
  }
}
