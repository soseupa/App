import 'package:flutter/material.dart';
import 'package:gaori/class/schedule.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<String> members = ['박다은', '조수현', '김세진'];
  final List<Schedule_task> schedules = <Schedule_task>[];

  @override
  void initState() {
    // TODO: implement initState
    for (int i = 0; i < 3; i++) {
      schedules.add(Schedule_task("줠대 안보여줌", members));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
        shrinkWrap: true,
      children: schedules.map((item) => ListTile(
                key: Key("${item.title}"),
                title: Text("${item.title}"),
                trailing: Icon(Icons.menu),
              ))
          .toList(),
      onReorder: (int start, int current) {
        // dragging from top to bottom
        if (start < current) {
          int end = current - 1;
          String startItem = schedules[start].title;
          int i = 0;
          int local = start;
          do {
            schedules[local].title = schedules[++local].title;
            i++;
          } while (i < end - start);
          schedules[end].title = startItem;
        }
        // dragging from bottom to top
        else if (start > current) {
          String startItem = schedules[start].title;
          for (int i = start; i > current; i--) {
            schedules[i].title = schedules[i - 1].title;
          }
          schedules[current].title = startItem;
        }
        setState(() {});
      },
    );
  }
}
