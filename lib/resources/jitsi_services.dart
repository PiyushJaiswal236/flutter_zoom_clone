import 'package:jitsi_meet_flutter_sdk/jitsi_meet_flutter_sdk.dart';
import 'package:zoom_clone/resources/auth_service.dart';
import 'package:zoom_clone/resources/firestore_services.dart';

class JitsiServices {
  final AuthService _authService = AuthService();
  final FirestoreServices _firestoreServices= FirestoreServices();

  void createMeeting ({
    required String roomName,
    required bool isAudioMuted,
    required bool isVideoMuted,
    String name = ""
  }) async{
    JitsiMeet jitsiMeet = JitsiMeet();
    String userName;
    if(name.isEmpty){
      userName= _authService.currentUser.displayName!;
    }else{
      userName=name;
    }
    var options = JitsiMeetConferenceOptions(
      room: roomName,
      configOverrides: {
        "startWithAudioMuted": isAudioMuted,
        "startWithVideoMuted": isVideoMuted,
        FeatureFlags.welcomePageEnabled: true,
      },
      featureFlags: {"unsaferoomwarning.enabled": false},
      userInfo: JitsiMeetUserInfo(
          displayName: userName,
          email: _authService.currentUser.email,
          avatar: _authService.currentUser.photoURL),
    );


    _firestoreServices.addToMeetingHistory(roomName);
    await jitsiMeet.join(options);
  }
}
