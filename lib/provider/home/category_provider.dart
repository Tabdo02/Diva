import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/class/boutique.dart';
import 'package:diva/class/home/ps.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CategoryProvider  extends ChangeNotifier{
  bool _pOrS=true;
  bool _followingProducts=true;
  bool _adv=true;
  bool _isSearching=false;
  bool get isSearching =>_isSearching;

 late List<PS> _produit=[];
 late List<PS> _service=[];
 List<String> _productPubs=[];
 List<String> _servicePubs=[];
 List<String> get productPubs => _productPubs;
 List<String> get servicePubs => _servicePubs;



 List<Boutique>? _abonnementBoutique;
 List<Boutique>? get abonnementBoutique =>_abonnementBoutique ;
 List<dynamic>? _abonnementProducts ;
 List<dynamic>? _abonnementServices ;

 List<dynamic>? get abonnementProducts => _abonnementProducts ;
 List<dynamic>? get abonnementServices => _abonnementServices ;





 

List<PS> get produit=>_produit;
List<PS> get service=>_service;
bool get pOrS=>_pOrS;
bool get adv=>_adv;

bool get followingProducts=>_followingProducts;



// toogle p and s
void toggleSP(){
  _pOrS=!_pOrS;
  if (_service.length==0) {
    allProducts();
  }
  notifyListeners();
}
void toggleFollowing(){
  _followingProducts=!_followingProducts;
  notifyListeners();
}
void toggleAdv(){
  _adv=!_adv;
  notifyListeners();
}


 // fetch products

 void allProducts() async {
    try {

  
    final QuerySnapshot<Map<String, dynamic>> snapshot1 = await FirebaseFirestore.instance.collection("category").get();

     for (var ps in snapshot1.docs) {
       _produit.add(
        PS(
          name: ps["name"].toString(), 
          image: ps["image"].toString(),
          sCategory: ps["sCategory"]??[],
          )
       );
     }
      notifyListeners();

   
   
    } catch (error) {
      print('Error fetching : $error');
    }
  }


// just service
 void allService() async {
    try {
     
     final QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection("services").get();

     for (var ps in snapshot.docs) {
     
       _service.add(
        PS(
          name: ps["name"].toString(), 
          image: ps["image"].toString(),
          sCategory: ps["sCategory"]??[],
          )
       );
     }
      notifyListeners();
   
   
    } catch (error) {
      print('Error fetching : $error');
    }
  }


  void getAllProdcutAbonnement(BuildContext context) async{
    List<String> ids = Provider.of<userProvider>(context,listen: false).followingList!.map((e)=>e.bid).toList();
    if (ids.length>0) {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("products")
        .where("idBoutique", whereIn: ids)
        .orderBy("time",descending: true)
        .get();
   QuerySnapshot queryBoutique = await FirebaseFirestore.instance
        .collection("boutiques")
        .where(FieldPath.documentId, whereIn: ids)
        .get();

    _abonnementBoutique=queryBoutique.docs.map(
      (e) =>
       Boutique(
        owner: false, 
        docId: e.id, 
        bio: e["bio"], 
        category: e["category"], 
        usDocID: e["docId"], 
        liens: e["liens"].map((url) => url.replaceAll('&', '%26')).toList(), 
        name: e["name"], 
        phone: e["phone"], 
        profilPicture: e["profileImage"], 
        sCategory: e["sCate"], 
        ville: e["ville"], 
        followers: e["followers"], 
        following: e["following"]
        ),
        ).toList();
    // products
    _isSearching =true;
    if (_abonnementProducts==null && _abonnementServices==null) {
      _abonnementProducts=[];
      _abonnementServices=[];
    notifyListeners();
      for (var p in querySnapshot.docs) {

          for (var e in queryBoutique.docs) {
            for (var cp in produit) {
              if (e.id==p["idBoutique"] && cp.name==e["category"]) {
                  _abonnementProducts!.add([
                    e,
                    p
                  ]);
              }
            }
            for (var s in service) {
              if (e.id==p["idBoutique"] && s.name==e["category"]) {
                  _abonnementServices!.add([
                    e,
                    p
                  ]);
              }
            }

          }
        }
    } else{
        for (var p in querySnapshot.docs) {
                  for (var e in queryBoutique.docs) {
                    for (var cp in produit) {
                      var pair = [e,p];
                      if (e.id==p["idBoutique"] && cp.name==e["category"] && !isPairInList(_abonnementProducts!, pair)) {
                          _abonnementProducts!.add([
                            e,
                            p
                          ]);
                      }
                    }
                    for (var s in service) {
                      var pair = [e,p];
                      if (e.id==p["idBoutique"] && s.name==e["category"] && !isPairInList(_abonnementServices!, pair)) {
                          _abonnementServices!.add([
                            e,
                            p
                          ]);
                      }
                    }

                  }
                }
    }
    _isSearching =false;
    notifyListeners();
    }

  }
  void removeAbonnementBoutique(String bid){
    List<Boutique> dB =[];
    List<dynamic> dProducts =[];
    List<dynamic> dServices =[];
    if(_abonnementBoutique !=null && _abonnementProducts!=null && _abonnementServices !=null){
        for (var b in _abonnementBoutique!) {
          if (b.docId == bid) {
            dB.add(b);
          }
        }

        for (var p in _abonnementProducts!) {
          if (p[0].id == bid) {
              dProducts.add(p);
          }
        }

        for (var s in _abonnementServices!) {
          if (s[0].id == bid) {
            dServices.add(s);
          }
        }
        _abonnementBoutique!.removeWhere((b) => dB.contains(b));
        _abonnementProducts!.removeWhere((p) => dProducts.contains(p));
        _abonnementServices!.removeWhere((s) => dServices.contains(s));
        notifyListeners();
    }
  }
  bool isPairInList(List<dynamic> list, var pair) {
      for (var e in list) {
        if (e[1].id==pair[1].id) {
          return true;
        }
        
      }
      return false;
    }

  void addToFollowingList(String bid) async{

    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("products")
        .where("idBoutique", isEqualTo: bid)
        .orderBy("time",descending: true)
        .get();
   QuerySnapshot queryBoutique = await FirebaseFirestore.instance
        .collection("boutiques")
        .where(FieldPath.documentId, isEqualTo: bid)
        .get();
    if (_abonnementBoutique !=null) {
    _abonnementBoutique!.add(
      Boutique(
        owner: false, 
        docId: queryBoutique.docs.first.id, 
        bio: queryBoutique.docs.first["bio"], 
        category: queryBoutique.docs.first["category"], 
        usDocID: queryBoutique.docs.first["docId"], 
        liens: queryBoutique.docs.first["liens"].map((url) => url.replaceAll('&', '%26')).toList(), 
        name: queryBoutique.docs.first["name"], 
        phone: queryBoutique.docs.first["phone"], 
        profilPicture: queryBoutique.docs.first["profileImage"], 
        sCategory: queryBoutique.docs.first["sCate"], 
        ville: queryBoutique.docs.first["ville"], 
        followers: queryBoutique.docs.first["followers"], 
        following: queryBoutique.docs.first["following"]
        )
    );


    // products
      for (var p in querySnapshot.docs) {
            for (var cp in produit) {
              if (queryBoutique.docs.first.id==p["idBoutique"] && cp.name==queryBoutique.docs.first["category"]) {
                  _abonnementProducts!.add([
                    queryBoutique.docs.first,
                    p
                  ]);
              }
            }
            for (var s in service) {
              if (queryBoutique.docs.first.id==p["idBoutique"] && s.name==queryBoutique.docs.first["category"]) {
                  _abonnementServices!.add([
                    queryBoutique.docs.first,
                    p
                  ]);
              }
            }
        }
    sortAbonnementProductsAndServices();
    notifyListeners();
    }
  }

  void sortAbonnementProductsAndServices() {
  _abonnementProducts!.sort((a, b) {
    var timeA = (a[1] as DocumentSnapshot)['time'] as Timestamp;
    var timeB = (b[1] as DocumentSnapshot)['time'] as Timestamp;
    return timeB.compareTo(timeA); // Descending order
  });

  _abonnementServices!.sort((a, b) {
    var timeA = (a[1] as DocumentSnapshot)['time'] as Timestamp;
    var timeB = (b[1] as DocumentSnapshot)['time'] as Timestamp;
    return timeB.compareTo(timeA); // Descending order
  });
}

  void getPubs() async{
    List<String> sPubs=[];
    List<String> pPubs=[];

    QuerySnapshot queryProductPubs = await FirebaseFirestore.instance.collection("pubs").where("category",isEqualTo: "product").limit(9).get();
    QuerySnapshot queryServicePubs = await FirebaseFirestore.instance.collection("pubs").where("category",isEqualTo: "service").limit(9).get();
    for (var p in queryProductPubs.docs) {
      pPubs.add(p["image"].toString());
    }
     for (var s in queryServicePubs.docs) {
      sPubs.add(s["image"].toString());
      
    }
    
    _productPubs=pPubs;
    _servicePubs=sPubs;
    notifyListeners();
  }
  void clearSwitch(){
    _pOrS=true;
    _followingProducts=true;
    _abonnementBoutique=null;
    _abonnementProducts =null;
    _abonnementServices =null;
    _productPubs=[];
    _servicePubs=[];
    notifyListeners();
  }
  
}