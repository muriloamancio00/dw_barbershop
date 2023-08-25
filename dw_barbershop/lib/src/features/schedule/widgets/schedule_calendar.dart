import 'package:dw_barbershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ScheduleCalendar extends StatefulWidget {

  const ScheduleCalendar({ super.key });

  @override
  State<ScheduleCalendar> createState() => _ScheduleCalendarState();
}

class _ScheduleCalendarState extends State<ScheduleCalendar> {

  DateTime? selectedDay;

   @override
   Widget build(BuildContext context) {
       return Container(
        child: Column(children: [
          TableCalendar(
            availableGestures: AvailableGestures.none,
            headerStyle: const HeaderStyle(titleCentered: true),
            focusedDay: DateTime.now(), 
            firstDay: DateTime.now(), 
            lastDay: DateTime.now().add(const Duration(days: 365 *10)),
            calendarFormat: CalendarFormat.month,
            locale: 'pt_BR',
            //tirando outras opções de formato
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                this.selectedDay = selectedDay;
              });
            },
            //oque faz a seleção no calendario funcionar
            selectedDayPredicate: (day) {
              return isSameDay(selectedDay, day);
            },
            calendarStyle:  CalendarStyle(
              selectedDecoration: const BoxDecoration(
                color: ColorsConstants.brow,
                shape: BoxShape.circle,
              ),
              todayDecoration: BoxDecoration(
                color: ColorsConstants.brow.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          )
        ]),
       );
  }
}