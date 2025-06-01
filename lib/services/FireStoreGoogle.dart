import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreGoogleService {

  // get collection of emails
  final CollectionReference GoogleEmails = FirebaseFirestore.instance.collection("notes");


  // Create
  Future<void> addEmailGoogle  (String email){
    return GoogleEmails.add({
      "email":email
    });
  }

  //Read
// Read
  Future<QuerySnapshot> getGoogleEmail(String email) async {
    return GoogleEmails.where('email', isEqualTo: email).get();
  }
  
}