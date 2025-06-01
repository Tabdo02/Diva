import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/auth_Firestor/users.dart';
import 'package:diva/class/users.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/services/FireStoreGoogle.dart';
import 'package:diva/services/firebase_messaging.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';




class AuthServices {
  final FireStoreGoogleService _fireStoreGoogleService = FireStoreGoogleService();
final FirebaseAuth _auth = FirebaseAuth.instance;
  // Sign in with google
  Future<void> signInWithGoogle() async {
    try {
      // Begin interactive sign-in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      // If the sign-in was successful
      if (gUser != null) {
            CollectionReference users = FirebaseFirestore.instance.collection('users');

          // Query for documents where the email field equals the provided email
            QuerySnapshot querySnapshot = await users.where('email', isEqualTo: gUser.email).limit(1).get();

            // Check if any documents were found
          
        // Obtain auth details from the request
            final GoogleSignInAuthentication gAuth = await gUser.authentication;

        // Query Firestore to check if the email exists
        // Check if the email exists in Firestore
        final QuerySnapshot emailQuery = await _fireStoreGoogleService.getGoogleEmail(gUser.email);
        if (emailQuery.docs.isNotEmpty && querySnapshot.docs.isNotEmpty) {
          // Email not found, proceed with sign up
          final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken,
            idToken: gAuth.idToken,
          );

          // Sign up the user with the Google credentials
          await FirebaseAuth.instance.signInWithCredential(credential);

          // Navigate to the home page after sign up
          Get.offAllNamed(RouteHelper.getHomeToggle());
          await FirebaseApi().initNotifications();
        } 
        else if(emailQuery.docs.isEmpty && querySnapshot.docs.isEmpty){
          final credential = GoogleAuthProvider.credential(
            accessToken: gAuth.accessToken,
            idToken: gAuth.idToken,
          );
   // Sign in to Firebase with the Google credential
        final UserCredential authResult = await _auth.signInWithCredential(credential);

    // Access the User object to get the UID
          final User user = authResult.user!;
          // Sign up the user with the Google credentials
          await FirebaseAuth.instance.signInWithCredential(credential);
          _fireStoreGoogleService.addEmailGoogle(gUser.email);
          AuthFirestore().createUser(EUsers(email: gUser.email, password: "",name: gUser.displayName!,image: gUser.photoUrl ?? ""), user.uid);
          // Navigate to the home page after sign up
          Get.offAllNamed(RouteHelper.getHomeToggle());
          await FirebaseApi().initNotifications();

        }
      }
    } catch (e) {
      // Handle the error, e.g., show an error message
      print(e); // Consider using a more user-friendly error handling
    }
  }
}

// Extension of FireStoreGoogleService to include email query
extension on FireStoreGoogleService {
  Future<QuerySnapshot> getGoogleEmail(String email) async {
    return GoogleEmails.where('email', isEqualTo: email).get();
  }
}


