import 'package:flutter/material.dart';



class NotificationPage extends StatelessWidget {
  // Sample notifications data
  final List<Map<String, dynamic>> notifications;

  const NotificationPage({super.key, required this.notifications});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return Card(
            margin: EdgeInsets.all(10),
            elevation: 5,
            child: ListTile(
              contentPadding: EdgeInsets.all(16),
              title: Text(
                notification['status'],
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
             
              // subtitle: Text(notification['created_at'].toString().substring(0,10)),
            ),
          );
        },
      ),
    );
  }
}

class NotificationModel {
  final String title;
  final String description;
  final String time;

  NotificationModel({required this.title, required this.description, required this.time});
}
