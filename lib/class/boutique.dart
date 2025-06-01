class Boutique {
  final bool owner;
  final String docId;
  final String bio;
  final String category;
  final String usDocID;
  final List<dynamic> liens;
  final String name;
  final String phone;
  final String profilPicture;
  final String sCategory;
  final String ville;
  String followers;
  String following;

  Boutique({
    required this.owner,
    required this.docId,
    required this.bio,
    required this.category,
    required this.usDocID,
    required this.liens,
    required this.name,
    required this.phone,
    required this.profilPicture,
    required this.sCategory,
    required this.ville,
    required this.followers,
    required this.following,
  });




  // Convert Boutique object to a map
  Map<String, dynamic> toJson() {
    return {
      'owner': owner,
      'docId': docId,
      'bio': bio.replaceAll('&', '%26').replaceAll('#', '%23'),
      'category': category,
      'usDocID': usDocID,
      'liens':  liens,
      'name': name,
      'phone': phone,
      'profilPicture': profilPicture.replaceAll('&', '%26'),
      'sCategory': sCategory,
      'ville': ville,
      'followers': followers,
      'following': following,
    };
  }

  // Create Boutique object from a map
  factory Boutique.fromJson(Map<String, dynamic> json) {
    return Boutique(
      owner: json['owner'] ?? false,
      docId: json['docId'] ?? '',
      bio: json['bio'] ?? '',
      category: json['category'] ?? '',
      usDocID: json['usDocID'] ?? '',
      liens: json['liens'],
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      profilPicture: json['profilPicture'] ?? '',
      sCategory: json['sCategory'] ?? '',
      ville: json['ville'] ?? '',
      followers: json['followers'] ?? '',
      following: json['following'] ?? '',
    );
  }
}


