import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/layout/cubit/cubit.dart';
import 'package:todo_app/styles/colors/colors_screen.dart';

Widget defaultButton({
  double width = double.infinity,
  bool isUpperCase = true,
  double radius = 5.0,
  @required String text,
  @required Function function,

}) => Container(
  width: width,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
  ),
  child: MaterialButton(
    onPressed: (){
      function();
    },
    child: Text(
      isUpperCase ? text.toUpperCase() : text,
      style: TextStyle(
        fontSize: 20.0,
        color: Colors.white,
      ),
    ),
    height: 50.0,
  ),
);

Widget defaultTextBottom({
  @required function,
  @required String text
}) => TextButton(
  onPressed: function,
  child: Text(
    text.toUpperCase(),
  ),
);

Widget defaultTextFormField({
  onTap,
  @required TextEditingController controller,
  @required TextInputType type,
  @required String label,
  @required IconData prefix,
  @required validate,
  suffixPressed,
  onSubmit,
  // Function? onChange,
  onChange,
  IconData suffix,
  bool isPassword = false,
}) =>  TextFormField(
  onChanged: onChange,
  validator: validate,
  onTap: onTap,
  controller: controller,
  keyboardType: type,
  obscureText: isPassword,
  onFieldSubmitted: onSubmit,
  // onChanged: (String value)
  // {
  //   onChange!();
  // },
  decoration: InputDecoration(
    labelText: label,
    prefixIcon: Icon(
      prefix,
      color: Colors.grey,
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
        suffix,
        color: Colors.grey,
      ),
    ) : null ,
    border: OutlineInputBorder(),
  ),
);

Widget BuildTasksItem(Map model, context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: Colors.teal,
          radius: 40.0,
          child: Text(
            '${model['time']}',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w600,
              color: blueColor,
            ),
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: blueColor,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 0.5,
              ),
              Text(
                '${model['date']}',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 20.0,
        ),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(
                status: 'done',
                id: model['id'],
              );
            },
            icon: Icon(
              Icons.done,
              color: Colors.teal,
            )
        ),
        IconButton(
            onPressed: (){
              AppCubit.get(context).updateData(
                status: 'archive',
                id: model['id'],
              );
            },
            icon: Icon(
              Icons.archive,
              color: Colors.teal,
            )
        ),
      ],
    ),
  ),
  onDismissed: (direction){
    AppCubit.get(context).deleteData(id: model['id']);
  },
);

Widget tasksBuilder({
  @required List<Map> tasks,
}) => ConditionalBuilderRec(
  condition: tasks.length > 0,
  builder: (context) => ListView.separated(
    itemBuilder: (context, index) => BuildTasksItem(tasks[index], context),
    separatorBuilder: (context, index) => myDivider() ,
    itemCount: tasks.length,
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.menu,
          color: Color(0xff5D6F93),
          size: 80.0,
        ),
        Text(
          'No Tasks Yet, Please Add Some Tasks',
          style: TextStyle(
            color: Color(0xff5D6F93),
            fontSize: 16.0,
          ),
        ),
      ],
    ),
  ),
);

Widget myDivider() => Padding(
  padding: const EdgeInsets.symmetric(
    horizontal: 20.0,
  ),
  child: Container(
    color: Colors.grey[400],
    height: 0.3,
    width: double.infinity,
  ),
);
