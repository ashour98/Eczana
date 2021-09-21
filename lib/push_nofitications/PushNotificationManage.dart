import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eczane/%D9%8Dservices/DatabaseServer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationsManager {
  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance =
      PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  bool _initialized = false;

  Future<void> init() async {
    String token;
    if (!_initialized) {
      String token = await _firebaseMessaging.getToken();
      print('COPY THIS TO MESSAGES');
      print("FirebaseMessaging token: $token");

      _initialized = true;
    } else
      print("FirebaseMessaging token: $token");

    SaveDeviceToken();
  }

  void SaveDeviceToken() async {

    String uid = DatabaseServer.instance.uid; //return current uid
    String token = await _firebaseMessaging.getToken();

    if (token != null) {
      var tokenRef = Firestore.instance
          .collection("data")
          .document(uid)
          .collection("tokens")
          .document(token);

      await tokenRef.setData({
        'token': token,
        'createDate': FieldValue.serverTimestamp(),
      });

    }
  }
}
