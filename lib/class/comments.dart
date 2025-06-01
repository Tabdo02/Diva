import 'package:cloud_firestore/cloud_firestore.dart';

class productComment {
  final String productId;
  final String image;
  final String nameProfile;
  final int raiting;
  final Timestamp date;
  final String content;
  productComment({
    required this.productId,
    required this.content,
    required this.date,
    required this.image,
    required this.nameProfile,
    required this.raiting,
  });
  
}