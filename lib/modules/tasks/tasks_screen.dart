import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/components/components.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/layout/cubit/states.dart';

class newTaskScreen extends StatelessWidget {
  const newTaskScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
        listener: (context, state){},
        builder: (context, state){
          var tasks = AppCubit.get(context).newTasks;
          return tasksBuilder(
              tasks: tasks
          );
        }

    );
  }
}