import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

var now = DateTime.now();
var firstDay = DateTime(now.year, now.month - 3, now.day);
var lastDay = DateTime(now.year, now.month + 3, now.day);

class Calendrier extends StatefulWidget {
  const Calendrier({Key? key}) : super(key: key);

  @override
  State<Calendrier> createState() => _CalendrierState();
}

class _CalendrierState extends State<Calendrier> {
  CalendarFormat format = CalendarFormat.twoWeeks;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          focusedDay: now,
          firstDay: firstDay,
          lastDay: lastDay,
          calendarFormat: format,
          startingDayOfWeek: StartingDayOfWeek.monday,
          availableCalendarFormats: const {
            CalendarFormat.month: 'mois',
            CalendarFormat.week: 'semaine',
            CalendarFormat.twoWeeks: '2 semaines',
          },
          headerStyle: HeaderStyle(
              leftChevronIcon: const Icon(
                Icons.chevron_left,
                size: 24,
                color: Colors.black54,
              ),
              rightChevronIcon: const Icon(
                Icons.chevron_right,
                size: 24,
                color: Colors.black54,
              ),
              headerPadding: EdgeInsets.zero,
              formatButtonVisible: true,
              formatButtonShowsNext: false,
              formatButtonDecoration: BoxDecoration(
                color: Colors.blueGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(15),
              ),
              formatButtonTextStyle:
                  const TextStyle(color: Colors.white, fontSize: 12),
              titleTextStyle: const TextStyle(color: Colors.blueGrey),
              titleCentered: true),
          calendarStyle: CalendarStyle(
              selectedDecoration: const BoxDecoration(
                  color: Colors.blueGrey, shape: BoxShape.rectangle),
              selectedTextStyle: const TextStyle(
                color: Color.fromRGBO(238, 230, 226, 1),
              ),
              todayDecoration: BoxDecoration(
                  color: Colors.grey.shade300, shape: BoxShape.rectangle),
              todayTextStyle: const TextStyle(color: Colors.blueGrey),
              defaultDecoration: const BoxDecoration(
                  color: Colors.transparent, shape: BoxShape.rectangle),
              defaultTextStyle: const TextStyle(color: Colors.blueGrey)),
        ),
      ],
    );
  }
}
