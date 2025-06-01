import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class storagService {

  FirebaseStorage _storage =FirebaseStorage.instance;
  
  Future<String> getImageUrl(String imagePath) async {
  // Reference to an image file in Firebase Storage
  Reference ref = _storage.ref().child(imagePath);

  // Get the download URL for the image
  String imageUrl = await ref.getDownloadURL();

  return imageUrl;
}

Future<String> uploadFile(File file,String name,String Folderpath) async{
  final path='${Folderpath}${name}';
  final ref = _storage.ref().child(path);
   // Start the file upload and await its completion
    TaskSnapshot snapshot = await ref.putFile(file);
  // Get the download URL
    final urlDownload = await snapshot.ref.getDownloadURL();
   return urlDownload; 
}
}