import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoom_clone/resources/firestore_services.dart';

class MeetingHistoryPage extends StatelessWidget {
  const MeetingHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirestoreServices().meetingHistory,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (context, index) => ListTile(
            title:
                Text('Room Name : ${snapshot.data!.docs[index]["meetingName"]}'),
            subtitle:
            Text('Joined On : ${DateFormat.yMMMd().format(snapshot.data!.docs[index]['createdAt'].toDate())}'),
          ),
        );
      },
    );
  }
}
