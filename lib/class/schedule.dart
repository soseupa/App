class Schedule_task{
  int id;
  String title;
  List<ScheduleUser> friends;
  Schedule_task(this.id, this.title, this.friends);
}
class ScheduleUser{
  int id;
  String name;
  ScheduleUser(this.id, this.name);
}