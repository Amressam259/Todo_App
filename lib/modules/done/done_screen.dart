import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states.dart';

class doneTaskScreen extends StatelessWidget {
  const doneTaskScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context, state){
          var tasks = AppCubit.get(context).doneTasks;
          return tasksBuilder(
              tasks: tasks
          );
        }

    );
  }
}