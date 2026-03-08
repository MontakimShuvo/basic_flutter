import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:untitled/constants/app_constants.dart';

class TaskCalendarSheet extends StatefulWidget {
  const TaskCalendarSheet({super.key});

  @override
  State<TaskCalendarSheet> createState() => _TaskCalendarSheetState();
}

class _TaskCalendarSheetState extends State<TaskCalendarSheet> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;

  @override
  void initState() {
    // TODO: implement initState
    selectedDay = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppConstants.valueDouble20,
          vertical: AppConstants.valueDouble24,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppConstants.valueDouble28),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12,right: 12,left:12,bottom: 12),
              child: TableCalendar(
                focusedDay: focusedDay,
                firstDay: DateTime.utc(2020),
                lastDay: DateTime.utc(2030),
                headerStyle: const HeaderStyle(
                  titleCentered: true,
                  formatButtonVisible: false,
                  leftChevronIcon: Icon(Icons.arrow_back_ios),
                  rightChevronIcon: Icon(Icons.arrow_forward_ios),
                ),
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: const BoxDecoration(
                    color: Color(0xff5c6bc0),
                    shape: BoxShape.circle,
                  ),
                  selectedTextStyle: const TextStyle(color: Colors.white),
                ),
                selectedDayPredicate: (day) {
                  return isSameDay(selectedDay, day);
                },
                onDaySelected: (selected, focused) {
                  setState(() {
                    selectedDay = selected;
                    focusedDay = focused;
                  });
                },
              ),
            ),
            const Divider(height: AppConstants.valueDouble1),
      
            ListTile(
              leading: const Icon(Icons.access_time),
              title: const Text("Set time"),
              onTap: () {},
            ),
      
            const Divider(height: AppConstants.valueDouble1),
      
            ListTile(
              leading: const Icon(Icons.repeat),
              title: const Text("Repeat"),
              onTap: () {},
            ),
            const Divider(),
      
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.valueDouble16,
                vertical: AppConstants.valueDouble12,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
      
                  const SizedBox(width: AppConstants.valueDouble15),
      
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, selectedDay);
                    },
                    child: const Text("Done"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
