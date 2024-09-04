import 'package:flutter/material.dart';
import 'package:zoom_clone/resources/auth_service.dart';
import 'package:zoom_clone/resources/colors.dart';
import 'package:zoom_clone/resources/jitsi_services.dart';
import 'package:zoom_clone/widgets/meeting_options.dart';

class JoinCallPage extends StatefulWidget {
  const JoinCallPage({super.key});

  static String routeName = "/joincallscreen";

  @override
  State<StatefulWidget> createState() => _joinCallPageState();
}

class _joinCallPageState extends State<JoinCallPage> {
  final AuthService _authService = AuthService();
  final JitsiServices _jitsiServices = JitsiServices();
  late TextEditingController meetingIdController;
  late TextEditingController nameController;

  bool isVideoMuted=true;

  bool isAudioMuted= true;

  void _joinMeeting() {
    _jitsiServices.createMeeting(roomName: meetingIdController.text, isAudioMuted: isAudioMuted, isVideoMuted: isVideoMuted,name: nameController.text);
  }
  onVideoMuted(bool val){
    setState(() {
      isVideoMuted=val;
    });
  }
  onAudioMuted(bool val){
    setState(() {
      isAudioMuted=val;
    });
  }
  @override
  void initState() {
    super.initState();
    meetingIdController = TextEditingController();
    nameController =
        TextEditingController(text: _authService.currentUser.displayName);
  }


  @override
  void dispose() {
    super.dispose();
    meetingIdController.dispose();
    nameController.dispose();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Join Meeting",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 80,
            child: TextField(
              controller: meetingIdController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: "Room Id",
                contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
              ),
            ),
          ),
          SizedBox(
            height: 80,
            child: TextField(
              controller: nameController,
              maxLines: 1,
              textAlign: TextAlign.center,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                fillColor: secondaryBackgroundColor,
                filled: true,
                border: InputBorder.none,
                hintText: "Room Id",
                contentPadding: EdgeInsets.fromLTRB(16, 0, 0, 0),
                counterText: null,
              ),
            ),
          ),
          InkWell(
            onTap: _joinMeeting,
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                "Join",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 20),
          MeetingOptions(
              text: "Start with Camera Disabled",
              isMuted: isVideoMuted,
              onChanged: (value) {}),
          MeetingOptions(
              text: "Start with Audio Muted",
              isMuted: isAudioMuted,
              onChanged: (value) {}),
        ],
      ),
    );
  }
}
