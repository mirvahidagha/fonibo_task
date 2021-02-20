import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fonibo_task/data/task_api_service.dart';
import 'package:provider/provider.dart';

import 'model/task.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  static const List colors = [
    0xffFFDEDE,
    0xff5BB1FF,
    0xffB1F8C1,
    0xffFEDEFF,
  ];

  static const Color backColor = Color(0xFFFCFEFF);
  static const Color cardColor = Color(0xFFF8F8F8);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              CupertinoIcons.bars,
              color: Colors.blue,
              size: 32,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: Text(
          'task.',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: Colors.blue,
          ),
        ),
      ),
      body: _buildBody(context),
      drawer: Drawer(),
    );
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  FutureBuilder<Response> _buildBody(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<TaskApiService>(context).getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<dynamic> tasks = jsonDecode(snapshot.data.bodyString);
          List<Task> list = [];
          tasks.forEach((element) => list.add(Task.fromJson(element)));

          return _buildTasks(context, list);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _buildTasks(BuildContext context, List tasks) {
    return Column(
      children: [
        Container(
          color: HomePage.backColor,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Text(
                  'Tasks',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            color: HomePage.backColor,
            child: ListView(
              children: tasks.map<Widget>((task) {
                return Container(
                  margin: const EdgeInsets.only(
                      left: 16, right: 14, bottom: 8, top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 9.24,
                        height: 66,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(6)),
                          color: Color(HomePage.colors[tasks.indexOf(task)]),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 66,
                          margin: const EdgeInsets.only(left: 6),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 248, 248, 248),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12))),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.6),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          task.title,
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'avenir'),
                                        ),
                                        Text(
                                          DateTime.parse(task.createdAt)
                                              .year
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black,
                                              fontFamily: 'avenir'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Radio(
                                value: tasks.indexOf(task),
                                groupValue: selectedRadio,
                                activeColor: Colors.green,
                                hoverColor: Colors.blue,
                                onChanged: (val) {
                                  setSelectedRadio(val);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
