import 'package:flutter/material.dart';
import 'package:todo_app/bloc_cubit/main_bloc_cubit.dart';

class BuildListItem extends StatelessWidget {
  BuildListItem({@required this.taskItem});
  final Map taskItem;
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(taskItem['id'].toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: EdgeInsets.all(10.0),
        color: Colors.redAccent,
        child: Row(
          children: [
            Icon(Icons.delete, size: 45.0,color: Colors.black54,),
          ],
        ),
      ),
      onDismissed: (direction){
        AppCubit.getObj(context).deleteData(taskItem['id']);
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: [
            CircleAvatar(
              child: Text(taskItem['time']),
              radius: 36.0,
            ),
            SizedBox(
              width: 15.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    taskItem['title'],
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    taskItem['date'],
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.check_box_outlined,
                color: Colors.green,
                size: 35.0,
              ),
              onPressed: () {
                AppCubit.getObj(context).updateData(status: 'done', id: taskItem['id']);
              },
            ),
            SizedBox(
              width: 10.0,
            ),
            IconButton(
              icon: Icon(
                Icons.archive_outlined,
                color: Colors.black45,
                size: 35.0,
              ),
              onPressed: () {
                AppCubit.getObj(context).updateData(status: 'archive', id: taskItem['id']);
              },
            ),
          ],
        ),
      ),
    );
  }
}
