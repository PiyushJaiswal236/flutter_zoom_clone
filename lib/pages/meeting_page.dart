import 'package:flutter/material.dart';
import 'package:zoom_clone/pages/join_call_page.dart';
import 'package:zoom_clone/resources/jitsi_services.dart';

import '../widgets/home_meeting_buttom.dart';

class MeetingPage  extends StatelessWidget{
  MeetingPage({super.key});
  //todo find out that is it necessary to remove/dispose jitsi listener if the widget is destroyed
  final JitsiServices _jitsiServices =JitsiServices();

  createNewMeeting() async{
    _jitsiServices.createMeeting( roomName: "room", isAudioMuted: false, isVideoMuted: false);
  }
  void joinMeeting(BuildContext context){
    Navigator.pushNamed(context,JoinCallPage.routeName );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HomeMeetingButtom(
                onPressed: createNewMeeting,
                icon: Icons.video_call,
                text: "New Meeting"),
            HomeMeetingButtom(
                onPressed: ()=>joinMeeting(context),
                icon: Icons.add_box_rounded,
                text: "Join Meeting"),
            HomeMeetingButtom(
                onPressed: () {},
                icon: Icons.calendar_today,
                text: "Schedule"),
            HomeMeetingButtom(
                onPressed: () {},
                icon: Icons.arrow_upward_rounded,
                text: "Share Screen"),
          ],
        ),
        const Expanded(
            child: Center(
                child: Text(
                  'Create / Join Meeting with just a click!',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),

                )))
      ],
    );
  }

}