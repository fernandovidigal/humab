import 'package:flutter/material.dart';
import 'package:humab/constants.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:humab/helpers/screen_helper.dart';

class Calendario extends StatefulWidget {
  final ValueChanged<DateTime>? valueChange;
  final DateTime? initialDate;

  const Calendario({Key? key, this.valueChange, this.initialDate}) : super(key: key);

  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  final DateTime _today = DateTime.now();
  late DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDate ?? _today;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'pt_PT',
      firstDay: DateTime.now(),
      lastDay: DateTime.utc(2030),
      focusedDay: _selectedDay,
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.sp,
        ),
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextFormatter: (date, locale) => DateFormat.E(locale).format(date)[0].toUpperCase(),
      ),
      calendarStyle: CalendarStyle(
        outsideDaysVisible: false,
        selectedDecoration: const BoxDecoration(
          color: kPrimaryColor,
          shape: BoxShape.circle,
        ),
        todayDecoration: BoxDecoration(
          color: _selectedDay == _today ? kPrimaryColor : Colors.white,
          shape: BoxShape.circle,
        ),
        todayTextStyle: TextStyle(fontWeight: FontWeight.bold, color: _selectedDay != _today ? kPrimaryColor : Colors.white),
      ),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(_selectedDay, selectedDay)) {
          if (widget.valueChange != null) {
            widget.valueChange!(selectedDay);
          }
          setState(() {
            _selectedDay = selectedDay;
          });
        }
      },
    );
  }
}
