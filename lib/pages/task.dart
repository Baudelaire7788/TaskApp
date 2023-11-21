import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:taskapp/pages/taskcard.dart';

class Task extends StatefulWidget {
  final TaskCard taskCard;

  const Task({Key? key, required this.taskCard}) : super(key: key);

  @override
  State<Task> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset("assets/images/vectors.png"),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Image.asset(
                            "assets/images/back.png",
                            height: 25,
                            width: 25,
                          ),
                        ),
                        Image.asset(
                          "assets/images/dots.png",
                          height: 25,
                          width: 25,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.taskCard.nom}",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.w700)),
                        Text(
                          "${widget.taskCard.description}",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(24, 0, 24, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              "${(double.parse(widget.taskCard.pregress!)*100).toString().split(".")[0]}% completed",
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(height: 5,),
                        LinearProgressIndicator(minHeight: 7,
                          color: Colors.white,
                          backgroundColor: Color(0xFF3035B5),
                          borderRadius: BorderRadius.circular(15),
                          value: double.parse(widget.taskCard.pregress!),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    ));
  }
}
