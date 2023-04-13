import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseMessagingServices {
  Future<void> _messageHandler(RemoteMessage message) async {
    print('background message ${message.notification!.body}');
  }

  Future<void> initialiaze() async {
    FirebaseMessaging.onBackgroundMessage(_messageHandler);
    FirebaseMessaging.instance.getToken().then((value) {
      print(value.toString());
    });
    await FirebaseMessaging.instance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
  }

   listenFirebaseMessaging() {
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
  }
}
