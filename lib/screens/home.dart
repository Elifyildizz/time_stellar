import 'dart:core';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:time_stellar/constants/color.dart';
import 'package:time_stellar/constants/tasktype.dart';
import 'package:time_stellar/model/task.dart';
import 'package:time_stellar/screens/creating_new_task.dart';
import 'package:time_stellar/service/todo_service.dart';
import 'package:time_stellar/todoitem.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //List<String> todo = ["Yoga", "Drinking Water", "Cleaning", "Running"];
  //List<String> done = ["Taking Vitamin D", "Reading"];

  List<Task> todo = [
    Task(
      type: TaskType.notes,
      title: "Yoga",
      desc: "Do yoga",
      isCompleted: false,
    ),
    Task(
      type: TaskType.contest,
      title: "Drinking Water",
      desc: "Drink more water",
      isCompleted: false,
    ),
    Task(
      type: TaskType.calendar,
      title: "Cleaning",
      desc: "Clean your room",
      isCompleted: false,
    ),
  ];

  List<Task> done = [
    Task(
      type: TaskType.contest,
      title: "Drinking Water",
      desc: "Drink more water",
      isCompleted: false,
    ),
    Task(
      type: TaskType.calendar,
      title: "Cleaning",
      desc: "Clean your room",
      isCompleted: false,
    ),
  ];

  void addNewTask(Task newTask) {
    setState(() {
      todo.add(newTask);
    });
  }

  @override
  Widget build(BuildContext context) {
    TodoService todoService = TodoService();
    todoService.getUncompletedTodos();
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    //SafeArea widget'ı bildirim çubuğunu uygulamadan ayırır
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backgroundColor),
          body: Column(
            children: [
              //Header
              Container(
                width: deviceWidth,
                height: deviceHeight / 4,
                decoration: const BoxDecoration(
                    color: Colors.purple,
                    image: DecorationImage(
                        image: AssetImage("lib/assets/images/header.jpg"),
                        fit: BoxFit.cover)),
                child: const Column(
                  children: [
                    //Padding margin gibi
                    Padding(
                      padding: EdgeInsets.only(top: 20),
                      child: Text(
                        "March 7, 2024",
                        style: TextStyle(
                            color: Colors.pink,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Text(
                        "Calendar",
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              //Scrolling page for todos = Expanded
              //Top Column
              const Padding(
                padding: EdgeInsets.only(left: 20, top: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "To Do",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: FutureBuilder(
                    future: todoService.getUncompletedTodos(),
                    //snapshot verinin seçildiği zamanı kaydeder
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return TodoItem(
                              task: snapshot.data![index],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              //Done Text
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Done",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              //Bottom Column
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: FutureBuilder(
                    future: todoService.getCompletedTodos(),
                    //snapshot verinin seçildiği zamanı kaydeder
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return const CircularProgressIndicator();
                      } else {
                        return ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            return TodoItem(
                              task: snapshot.data![index],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AddNewTaskScreen(
                        addNewTask: (newTask) => addNewTask(newTask),
                      ),
                    ));
                  },
                  child: const Text("Add new task")),
            ],
          ),
        ),
      ),
    );
  }
}
