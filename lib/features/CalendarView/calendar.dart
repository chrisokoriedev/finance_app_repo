import 'package:expense_app/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarListView extends StatefulWidget {
  @override
  _CalendarListViewState createState() => _CalendarListViewState();
}

class _CalendarListViewState extends State<CalendarListView> {
  final Map<DateTime, List<String>> events = {
    DateTime(2023, 7, 1): ['Event 1'],
    DateTime(2023, 7, 15): ['Event 2', 'Event 3'],
    DateTime(2023, 7, 28): ['Event 4'],
  };

  DateTime _selectedDate = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendar with List')),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.now().subtract(Duration(days: 365)),
            lastDay: DateTime.now().add(Duration(days: 365)),
            focusedDay: _selectedDate,
            calendarFormat: _calendarFormat,
            eventLoader: (date) => events[date] ?? [],
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: events[_selectedDate]?.length ?? 0,
              itemBuilder: (context, index) {
                final event = events[_selectedDate]![index];
                return ListTile(title: Text(event,style: TextStyle(color: AppColor.kBlackColor),));
              },
            ),
          ),
        ],
      ),
    );
  }
}
