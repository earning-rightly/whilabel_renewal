
import 'package:firebase_messaging/firebase_messaging.dart';

class WhilabelFcmService{
  Future<void> setupInteractedMessage() async {
    final token = await FirebaseMessaging.instance.getToken();

    final settings = await FirebaseMessaging.instance.requestPermission();
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      // if not granted, ask it again
      await FirebaseMessaging.instance.requestPermission();
    }
    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      // still didnot give access? just skip other parts. This user will not get notification anyway
      return;
    }

    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage, true);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) {
        _handleMessage(message, true);
      },
    );

    _listenWhenAppIsInForeground();
  }

  void _listenWhenAppIsInForeground() {
    FirebaseMessaging.onMessage.listen((
        RemoteMessage message,
        ) {});
  }

  void _handleMessage(RemoteMessage message, bool onTapNotif) {
    print("_handleMessage() 수행 => ${message.data}");
    /*TODO 앱 안으로 진입해서 보여줄 페이지로 이동하는 로직 추가  **/
  }
}