import 'package:chat_app/CustomUI/StatusPage/HeadOwnStatus.dart';
import 'package:chat_app/CustomUI/StatusPage/OthersStatus.dart';
import 'package:flutter/material.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 48,
              child: FloatingActionButton(
                backgroundColor: Colors.blueGrey[100],
                onPressed: () {},
                child: Icon(Icons.edit, color: Colors.blueGrey[900]),
              ),
            ),
            SizedBox(
              height: 13,
            ),
            FloatingActionButton(
              onPressed: () {},
              backgroundColor: Colors.greenAccent[700],
              elevation: 5,
              child: Icon(Icons.camera_alt),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // SizedBox(
              //   height: 10,
              // ),
              HeadownStatus(),
              label(" Recent Updates"),
              OthersStatus(
                name: "Balram Rathore",
                imageName: 'assets/2.jpeg',
                time: '01.23',
                isSeen: false,
                statusNum: 10,
              ),
               OthersStatus(
                name: "Saket Simha",
                imageName: 'assets/3.jpg',
                time: '02.23',
                isSeen: false,
                statusNum: 2,
              ),
               OthersStatus(
                name: "BhanuDev Som",
                imageName: 'assets/1.jpg',
                time: '03.23',
                isSeen: false,
                statusNum: 3,
              ),
              //  OthersStatus(
              //   name: "Rakesh",
              //   imageName: 'assets/1.jpeg',
              //   time: '01.23',
              // ),
              SizedBox(
                height: 10,
              ),
              label("Viewed updates"),
               OthersStatus(
                name: "Balram Rathore",
                imageName: 'assets/2.jpeg',
                time: '01.23',
                isSeen: true,
                statusNum: 1,
              ),
               OthersStatus(
                name: "Saket Simha",
                imageName: 'assets/3.jpg',
                time: '02.23',
                isSeen: true,
                statusNum: 2,
              ),
               OthersStatus(
                name: "BhanuDev Som",
                imageName: 'assets/1.jpg',
                time: '03.23',
                isSeen: true,
                statusNum: 10,
              ),
            ],
          ),
        ));
  }
  Widget label(String labelName){
    return Container(
                height: 33,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
                  child: Text(labelName,
                      style:
                          TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                ),
              );
  }
}
