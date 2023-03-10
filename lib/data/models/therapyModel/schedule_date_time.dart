class ScheduleDateTime
{
  String date;
  List<ScheduleTime>timeList;
  ScheduleDateTime({required this.date, required this.timeList});
}

class ScheduleTime
{
  bool isChecked;
  String time;

  ScheduleTime({required this.isChecked, required this.time});
}