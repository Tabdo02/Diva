class EUsers {
  final String docId;
  final String uid;
  final String image;
  final String name;
  final String email;
  final String password;
  final String type;
  // new just for now 
  final String bio;
  final String ville;
  final String phone;
  final String date;


  EUsers({
     this.type="user",
     this.name="",
     this.uid="",
     this.image="",
     this.bio="",
     this.ville="",
     this.phone="",
     this.date="",
     this.docId="",
     required this.email,
     required this.password,
  });

   // Convert EUsers object to a map
  Map<String, dynamic> toJson() => {
    'uid': uid,
    'image': image.toString().replaceAll('&', '%26'),
    'name': name,
    'email': email,
    'password': password,
    'type': type,
    'bio': bio,
    'ville': ville,
    'phone': phone,
    'date': date,
    'docId':docId,
  };

  // Create EUsers object from a map
  factory EUsers.fromJson(Map<String, dynamic> json) => EUsers(
    uid: json['uid'],
    image: json['image'],
    name: json['name'],
    email: json['email'],
    password: json['password'],
    type: json['type'],
    bio: json['bio'],
    ville: json['ville'],
    phone: json['phone'],
    date: json['date'],
    docId: json['docId'],
  );
}