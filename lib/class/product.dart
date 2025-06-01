
class Products {
  final String productId;
  final String boutiqueId;
  final String descriptiont;
  final List<dynamic> iamges;
  final String name;
  String price;
  dynamic promotion;
  final Map<String,dynamic> pubs;
  final String rating;
  
  Products(
    {
      required this.boutiqueId,
      required this.descriptiont,
      required this.iamges,
      required this.name,
      required this.price,
      required this.productId,
      required this.promotion,
      required this.pubs,
      required this.rating,
    }
  );

  // Convert Boutique object to a map
  Map<String, dynamic> toJson() {
    List<dynamic> ll = [];
    for (var element in iamges) {
      String e = element.toString().replaceAll('&', '%26');
      ll.add(e);
    }
    if(pubs.isNotEmpty){
      Map<String,dynamic> p = pubs;
      p["time"]=p["time"].toString();

    }
    return {
      'boutiqueId':boutiqueId,
      'descriptiont':descriptiont.replaceAll('#', '%23').replaceAll('&', '%26'),
      'iamges':ll,
      'name':name.replaceAll('&', '%26'),
      'price':price,
      'productId':productId,
      'promotion':promotion,
      'pubs':pubs,
      'rating':rating
    };
  }

  // Create Boutique object from a map
  factory Products.fromJson(Map<String, dynamic> json) {
    return Products(
      boutiqueId: json["boutiqueId"] ,
      descriptiont: json["descriptiont"],
      iamges: json["iamges"],
      name: json["name"],
      price: json["price"],
      productId:json["productId"] ,
      promotion: json["promotion"] ,
      pubs: json["pubs"] ?? {},
      rating: json["rating"],
    );
  }
  
}