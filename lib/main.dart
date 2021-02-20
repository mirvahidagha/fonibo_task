import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonibo_task/home_page.dart';
import 'package:provider/provider.dart';
import 'data/task_api_service.dart';

void main() => runApp(TaskApp());

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      builder: (_) => TaskApiService.create(),
      dispose: (_, TaskApiService service) => service.client.dispose(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage(),
      ),
    );
  }
}
