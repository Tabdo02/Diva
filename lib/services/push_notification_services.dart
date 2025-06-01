import 'dart:convert';
import 'package:diva/class/notification.dart';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis/servicecontrol/v1.dart' as servicecontrol;

class PushNotificationServices {

  static Future<String> getAcessToken() async{
    final servicesAccountJson ={
      "type": "service_account",
      "project_id": "diva-68985",
      "private_key_id": "7b3669f23ae06be6769ca29069ea74bfb72e2145",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDbTFoEzDuFShob\neSnXKFeGC17u7XgAWhR8FshqrIH28dWEk8cqU8ZMxjfAkhzCmsBzTFAbo5L8RUOt\nP7DyCxpAIWLYAMN+Co2oI8gX2NiLmd81uxw/MC2dFTIChDiJb92UUwhbEbMPciHz\n/ZM/wZlB/RZFWbfpNdcxvllnMcQ3CFJmUzH92CjRHBgMPu2Sgf1mdlfCxX5DpypP\n91UVx3dWwzWXMIGBY32Axdn5DfNis0ozcL8nkFlw0oBGbl/tLMOFXKSqPAe/z379\nx+x/vjDb4MmaALHF0MlBkirEOHBX8eSsVrX+U37WJomPndL7Awuyskpx2wJvVlec\nDQURdJFpAgMBAAECggEAItvYpVGXloDodHyGj5psizSsgvtBa4DmJ7Fxay9/uzLG\n13usGYjWiSaq/xPauX5i4BD93N7cAvi5oMTyig8EvbPw49f/Oz5PNS525H+GMG6l\nogNbopm0bndLi0XcPNCI3sZyGhPOrEJerkudB/HsvCYQT7bKuqnhypjw2iv5fiur\npFlLl9b2igM8hL5A3XFXvFdMb2dOfaT5sWGKHU3juvTO6aruitaGBvleLsF0Lo1E\nlPB23F4JiRlqbEePIx2OOBfWjapwINgU24467+zTVaH05BXejAPIxKA6nttFBITi\njgB4RTGX9NjuJMgNGCw/b+HzzU9nZweFJrsfpO0BhwKBgQDvx5N0GrPpQzmytdhQ\nmC8C0P7Q4iSP3dslAGWJllZUu1pReXnGsfT/v9NjvwVBu8pN6CSfBK1tXS4FSgzI\nouJgD+hXdRGt+qLJTJJfflYVDIgiHZVufGl39HL+EDqYll7q+CVUhnPJvpnzkOho\nxXdsep8UDZ0TaJMYCatXM1xmSwKBgQDqIhYiGMwwsALLwzhjA+DaRtqNrfN3OiE1\n6/o/OIVrkjfVDYLS/y1l3ifrNVZDb/OV/+cxTi0TozetpxjzwgwiXu5Ik0vmN1co\nC0uheMsMsqxtMgPEG06NYxEDkGYWxOgDFOdFY259umdxRrGJBP2xIVvsKMSIYd9x\nTbC8pcqmmwKBgQDCFSIGbYLIwbBXNhfEjJooxnArNZDwnlw+pAaMCpMQfKHLpu7p\n5Ktxw5xgdYLUxSMoUkoqKMgT6MNSZrDYSffAV7/x4oGP+HqBQ6iLASC+Yulh695D\nkxJvlP7rJMm5LqXfvUHCHB5m4w+L9fQYshVLSimvOqG0zwWZBGKa76jP5wKBgCqa\nOzbHFliBnnCfPCJgMUjmfZwsG9IFBMgAAVABo91YBMrCo5xrDEKt8suMr/6jX0pa\n/yFsnS0mlNoHPrYUCAs1BNy12KiyRyylKYTfKutLk65m3GKRqXB2p0DjxH++Io10\n/0QT/KXqBiqJd4J8IwFZFZXaMTCzxmmifldFP6OjAoGAKhKjmK5B0+D8VszK6w9C\nj5XaDQKhbtBS+yyR8cjdp3EAmxs4+Ho6fFobienOG7EOxB/JrCTY6CQ74GUnaulf\n5Y0+spjVFvuvuQvuUTIIkEO9LmhaYo1IERvKFIkump/jTZZ7Tu/bvTJs0n2CwDiw\nabuhE9DtFh3N5FDJc98NN+I=\n-----END PRIVATE KEY-----\n",
      "client_email": "ewomdiva@diva-68985.iam.gserviceaccount.com",
      "client_id": "102898378681907957594",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/ewomdiva%40diva-68985.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"
    };
    List<String> scopes =  [
      "https://www.googleapis.com/auth/userinfo.email",
      "https://www.googleapis.com/auth/firebase.database",
      "https://www.googleapis.com/auth/firebase.messaging"
    ];
    http.Client client = await auth.clientViaServiceAccount(
      auth.ServiceAccountCredentials.fromJson(servicesAccountJson),
      scopes
    );
    // get the access token
    auth.AccessCredentials credentials =await auth.obtainAccessCredentialsViaServiceAccount(
       auth.ServiceAccountCredentials.fromJson(servicesAccountJson),
      scopes,
      client
    );

    client.close();

    return credentials.accessToken.data;
  }

  static sendNotificationToSelectedDriver ({required String deviceToken,required MyNotificationClass notifi,required String title}) async
  {
    final String serverKey = await getAcessToken();
    String endpointFirebaseCloudMessaging ="https://fcm.googleapis.com/v1/projects/diva-68985/messages:send";
    final Map<String, dynamic> message ={
      'message':{
        'token':deviceToken,
        "notification": {
      "title": title,
      "body": notifi.content,
    },
    "android": {
      "notification":{
         "icon":"logo_g1615",
       }
    },

    'data':{
      'reciverID':notifi.reciverID,
      'senderID':notifi.senderID,
      'imageSender':notifi.imageSender,
      'nameSender':notifi.nameSender,
      'content':notifi.content,
      'timestamp':notifi.timestamp,
    },
      }
    };

    final http.Response response = await http.post(
      Uri.parse(endpointFirebaseCloudMessaging),
      headers: <String,String>{
        'Content-Type':'application/json',
        'Authorization':'Bearer $serverKey',
      },
      body: jsonEncode(message),
    );
    if (response.statusCode == 200) {
      print("FCM message send sucessufly");
    }else{
      print("Faild ,Notification not send :${response.statusCode}");

    }

  }
  
}