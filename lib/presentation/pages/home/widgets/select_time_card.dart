import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class SelectTimeCard extends StatefulWidget {
  const SelectTimeCard({
    super.key,
    required this.initialDate,
    required this.onDateSelected,
  });

  final DateTime initialDate;
  final ValueChanged<DateTime> onDateSelected;

  @override
  State<SelectTimeCard> createState() => _SelectTimeCardState();
}

class _SelectTimeCardState extends State<SelectTimeCard> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDialog<DateTime>(
      context: context,
      builder: (BuildContext context) {
        DateTime tempSelectedDate = selectedDate;
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: Container(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TableCalendar(
                      locale: "en_US",
                      rowHeight: 43,
                      headerStyle: const HeaderStyle(
                          formatButtonVisible: false, titleCentered: true),
                      availableGestures: AvailableGestures.all,
                      focusedDay: tempSelectedDate,
                      firstDay: DateTime.utc(2010, 10, 16),
                      lastDay: DateTime.utc(2030, 3, 14),
                      selectedDayPredicate: (day) =>
                          isSameDay(day, tempSelectedDate),
                      onDaySelected: (day, focusedDay) {
                        setState(() {
                          tempSelectedDate = day;
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context, tempSelectedDate);
                      },
                      child: const Text('Select'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Card(
        margin: const EdgeInsets.all(5.0),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              const Icon(Icons.calendar_today),
              const SizedBox(width: 10),
              Text(
                selectedDate.toString().split(' ')[0],
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
