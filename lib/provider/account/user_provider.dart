import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/class/boutique.dart';
import 'package:diva/class/comments.dart';
import 'package:diva/class/home/ps.dart';
import 'package:diva/class/notification.dart';
import 'package:diva/class/product.dart';
import 'package:diva/class/social_class.dart';
import 'package:diva/class/users.dart';
import 'package:diva/compoents/title_text.dart';
import 'package:diva/provider/home/category_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/services/push_notification_services.dart';
import 'package:diva/utils/Dimensions.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class userProvider extends ChangeNotifier{
  final _firestore= FirebaseFirestore.instance;
  
  //class
  EUsers? _euser;
  Boutique? _boutique;

  // bool
  bool _isv = false;
  bool _offre = false;
  bool _isSearching=false;
  bool _checkTime=false;
  bool _hasMore=true;
  bool _otherHasMore=true;
  bool _isLoading = false;
  bool _isIn = false;
  bool get isIn => _isIn;
  bool _booster=false;
  bool get booster =>_booster;
  bool _isGood =true;
  bool get isGood =>_isGood;

  // int
  int _pageSize =9;
  int _favoritIndex=0;
  int get favoritIndex => _favoritIndex;
  int _otherFollowing = 0;
  int _otherFollowers = 0;
  int get otherFollowing => _otherFollowing;
  int get otherFollowers => _otherFollowers; 
  int _socialIndex=0;
  int get socialIndex =>_socialIndex;
  int _weeks =1;
  int get weeks =>_weeks;
     
  //strings
  String? _mode;
  String? _boutiqueDocId;
  String _otherBoutiqueId="";
  String _otherPublicationNumber="";
  String _PublicationNumber="";
  String _villeValue="";
  String _categoryValue="";
  String _sousCateValue="";
  String _favoritVilleValue="";
  String _favoritCategoryValue="";
  String _favoritSousCateValue="";
  String _promotionCategoryValue="";
  String _promotionSousCateValue="";
  String get promotionCategoryValue => _promotionCategoryValue;
  String get promotionSousCateValue =>  _promotionSousCateValue;
  String _searchSwitch="Produits";
  String _promotionSwitch="Produits";
  String _socialValue = "Abonnées";
  String get socialValue =>_socialValue;
  String get searchSwitch=> _searchSwitch;
  String get promotionSwitch=> _promotionSwitch;

  // list
  List<String>? _recentSearch;
  List<String> _searchStack=[""];
  List<String> _tapedList=[];
  List<String> _favoritTapedList=[];
  List<String> get favoritTapedList => _favoritTapedList;
  List<String> _promotionTapedList=[];
  List<String> _sousCateList=[];
  List<String> _favoritSousCateList=[];
  List<String> get favoritSousCateList => _favoritSousCateList;
  List<String> _promotionSousCateList=[];
  List<dynamic> _allBoutique=[];
  List<dynamic> _searchProducts=[];
  List<dynamic> _searchServices=[];
  List<dynamic> _searchBoutique=[];
  List<dynamic> _promotionProducts=[];
  List<dynamic> _promotionServices=[];
  List<Products> _products =[];
  List<Products> _otherProducts =[];
  List<productComment> _comment =[];
  List<String> _favoritProducts =[];
  List<String> _favoritBoutique =[];
  List<dynamic> _likedProduct = [];
  List<dynamic> _likedService = [];
  List<socialMedia>? _followersList;
  List<socialMedia>? _followingList;
  List<socialMedia> _removedFollowingList =[];

  List<socialMedia>? get followersList => _followersList;
  List<socialMedia>? get followingList => _followingList;
  List<socialMedia> get removedFollowingList => _removedFollowingList;

  List<dynamic> get likedProduct => _likedProduct;
  List<dynamic> get likedService => _likedService;  

  List<String> get favoritProducts => _favoritProducts;
  List<String> get favoritBoutique => _favoritBoutique;
  List<productComment> get comment => _comment;
  List<MyNotificationClass> _myNotification =[];
  List<MyNotificationClass> get myNotification =>_myNotification ;

  // other types
  ScrollController _scrollController = ScrollController();
  ScrollController _scrollController2 = ScrollController();


  TextEditingController _controller =TextEditingController();
  BuildContext? _context;
  DocumentSnapshot? _otherLastDocument;
  DocumentSnapshot? _lastDocument;
  // getter
  String get favoritVilleValue => _favoritVilleValue;
  String get favoritCategoryValue => _favoritCategoryValue;
  String get favoritSousCateValue => _favoritSousCateValue;
  List<dynamic> get  allBoutique =>_allBoutique;
  EUsers? get euser =>_euser;
  Boutique? get boutique =>_boutique;
  bool get isv => _isv;
  bool get offre => _offre;
  String? get mode =>_mode;
  String? get boutiqueDocId =>_boutiqueDocId;
  bool get checkTime =>_checkTime;
  List<Products> get products =>_products;
  List<Products> get otherpproducts =>_otherProducts;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  ScrollController get scrollController  =>_scrollController;
  ScrollController get scrollController2  =>_scrollController2;



  String get otherBoutiqueId =>_otherBoutiqueId;
  String get otherPublicationNumber => _otherPublicationNumber;
  String get PublicationNumber => _PublicationNumber;
  List<String>? get recentSearch => _recentSearch;
  bool get isSearching  =>_isSearching;
  String get LastsearchStack =>_searchStack.last;
  TextEditingController get controller => _controller;
  BuildContext? get context =>_context;
  List<String> get tapedList => _tapedList;
  List<String> get promotionTapedList => _promotionTapedList;
  String get villeValue => _villeValue;
  String get categoryValue => _categoryValue;
  String get sousCategoryValue => _sousCateValue;
  List<String> get sousCateList =>_sousCateList;
  List<String> get promotionSousCateList =>_promotionSousCateList;
  List<dynamic> get searchProducts => _searchProducts;
  List<dynamic> get searchServices => _searchServices;
  List<dynamic> get promotionProducts => _promotionProducts;
  List<dynamic> get promotionServices => _promotionServices;
  List<dynamic> get searchBoutique => _searchBoutique;
  List<dynamic> _likedBoutique = [];
  List<dynamic> get likedBoutique => _likedBoutique;

  userProvider() {
    scrollController.addListener(_scrollListener);
    scrollController2.addListener(_scrollListener2);

  }
  void RanaMlah() async{
    DocumentSnapshot doc = await _firestore.collection("dontdothat").doc("123456").get();
    if (!doc["good"]) {
      _isGood=false;
      notifyListeners();
    }
  }
  void getMyNotification() async{
 
      QuerySnapshot notifSnap = 
      await _firestore
      .collection("usersNotifications")
      .where("reciverID",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
      _myNotification=notifSnap.docs.map(
        (e) {
          Timestamp t = e["timestamp"];
          return MyNotificationClass(
          senderID: e["senderID"], 
          reciverID: e["reciverID"], 
          content: e["content"], 
          imageSender: e["imageSender"], 
          nameSender: e["nameSender"], 
          timestamp:t.toDate().toString(),
           );
        } 
      ).toList();
    
    // Sort the notifications by timestamp in descending order
  _myNotification.sort((a, b) {
    DateTime dateA = DateTime.parse(a.timestamp);
    DateTime dateB = DateTime.parse(b.timestamp);
    return dateB.compareTo(dateA); // Newest first
  });
  notifyListeners();
  }
  void addNewNotification(MyNotificationClass newNotif) {
    
      bool newOne = true;
      for (var n in _myNotification) {
        if (n.timestamp == newNotif.timestamp) {
          newOne =false;
        }
      }
      if (newOne) {
      _myNotification.add(newNotif);
      }
      
        _myNotification.sort((a, b) {
    DateTime dateA = DateTime.parse(a.timestamp);
    DateTime dateB = DateTime.parse(b.timestamp);
    return dateB.compareTo(dateA); // Newest first
  });
  notifyListeners();
  }
  void setContext(BuildContext context) {
    _context = context;
  }
  void showModalSheet(String title) {
    if (_context != null) {
  
      showModalBottomSheet(
        context: _context!,
        builder: (context) {
          return Container(
            height: Dimensitions.height300,
            decoration: BoxDecoration(
               color: colors.bg,
               borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensitions.height10),
                topRight: Radius.circular(Dimensitions.height10)
               )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Align(
                    alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensitions.height15),
                    height: Dimensitions.height3,
                    width: Dimensitions.width65,
                    decoration: BoxDecoration(
                      color: colors.shadow.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(Dimensitions.height10)
                    ),
                  ),
                ),
                MyTitleText(
                  title: title,
                  padding: EdgeInsets.only(top: Dimensitions.height20,left: Dimensitions.width25,bottom: Dimensitions.height10),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                      child: ListView.builder(
                        itemCount: _tapedList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: Dimensitions.height10),
                            child: GestureDetector(
                              onTap:(){
                                if (title=="Ville") {
                                 _villeValue=_tapedList[index]=="....."?"":_tapedList[index];
                                 notifyListeners();
                                 
                                }else if(title=="Catégorie"){
                                  _sousCateValue="";
                                 _categoryValue=_tapedList[index]=="....."?"":_tapedList[index];
                                 if (_tapedList[index]==".....") {
                                    _sousCateList=[];
                                 }
                                 for (PS e in Provider.of<CategoryProvider>(context,listen: false).service) {
                                   if (e.name==_tapedList[index] ) {
                                  _sousCateList=[];
                                   if (e.name==_tapedList[index] ) {
                                    if (e.sCategory!.isNotEmpty) {
                                      _sousCateList.add(".....");
                                      for (var e in e.sCategory!) {
                                        _sousCateList.add(e.toString());
                                      }
                                    }
                                   }
                                   }
                                 }
                                 for (PS e in Provider.of<CategoryProvider>(context,listen: false).produit) {
                                 
                                   if (e.name==_tapedList[index] ) {
                                     _sousCateList=[];
                                    if (e.sCategory!.isNotEmpty) {
                                      _sousCateList.add(".....");
                                      for (var e in e.sCategory!) {
                                        _sousCateList.add(e.toString());
                                      }
                                    }
                                   
                                   }
                                 }
                                }else if(title=="Sous catégorie"){
                                 _sousCateValue=_tapedList[index]=="....."?"":_tapedList[index];
                                 

                                }
                                notifyListeners();
                                applyFilters();
                                Get.back();
                              },
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                _tapedList[index],
                                style: GoogleFonts.openSans(
                                  fontSize: Dimensitions.width14,
                                  fontWeight: FontWeight.w500,
                                  color: colors.text2,
                                ),
                                ),
                            ),
                          );
                        },
                        ),
                    ),
                    ),
             
              ],
            ),
          );
        },
      );
    
    }
  }
  void showModalSheet2(String title,BuildContext context) {
    if (_context != null) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: Dimensitions.height300,
            decoration: BoxDecoration(
               color: colors.bg,
               borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensitions.height10),
                topRight: Radius.circular(Dimensitions.height10)
               )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Align(
                    alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensitions.height15),
                    height: Dimensitions.height3,
                    width: Dimensitions.width65,
                    decoration: BoxDecoration(
                      color: colors.shadow.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(Dimensitions.height10)
                    ),
                  ),
                ),
                MyTitleText(
                  title: title,
                  padding: EdgeInsets.only(top: Dimensitions.height20,left: Dimensitions.width25,bottom: Dimensitions.height10),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                      child: ListView.builder(
                        itemCount: _promotionTapedList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: Dimensitions.height10),
                            child: GestureDetector(
                              onTap:(){
                                if(title=="Catégorie"){
                                _promotionSousCateValue="";
                                _promotionCategoryValue=_promotionTapedList[index]=="....."?"":_promotionTapedList[index];
                                 if (_promotionTapedList[index]==".....") {
                                    _promotionSousCateList=[];
                                 }
                                 for (PS e in Provider.of<CategoryProvider>(context,listen: false).service) {
                                   if (e.name==_promotionTapedList[index] ) {
                                  _promotionSousCateList=[];
                                   if (e.name==_promotionTapedList[index] ) {
                               
                                    if (e.sCategory!.isNotEmpty) {
                                      _promotionSousCateList.add(".....");
                                      for (var e in e.sCategory!) {
                                        _promotionSousCateList.add(e.toString());
                                      }
                                    
                                    }
                                   }
                                   }
                                 }
                                 for (PS e in Provider.of<CategoryProvider>(context,listen: false).produit) {
                                 
                                   if (e.name==_promotionTapedList[index] ) {
                                     _promotionSousCateList=[];
                                    if (e.sCategory!.isNotEmpty) {
                                      _promotionSousCateList.add(".....");
                                      for (var e in e.sCategory!) {
                                        _promotionSousCateList.add(e.toString());
                                      }
                                    }
                                   }
                                 }
                                }else if(title=="Sous catégorie"){
                                _promotionSousCateValue=_promotionTapedList[index]=="....."?"":_promotionTapedList[index];
                                }
                                notifyListeners();
                                applyPromotionFilters();
                                Navigator.pop(context);
                              },
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                _promotionTapedList[index],
                                style: GoogleFonts.openSans(
                                  fontSize: Dimensitions.width14,
                                  fontWeight: FontWeight.w500,
                                  color: colors.text2,
                                ),
                                ),
                            ),
                          );
                        },
                        ),
                    ),
                    ),
              ],
            ),
          );
        },
      );
    }
  }
  void showModalSheet3(String title) {
    if (_context != null) {
      showModalBottomSheet(
        context: _context!,
        builder: (context) {
          return Container(
            height: Dimensitions.height300,
            decoration: BoxDecoration(
               color: colors.bg,
               borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Dimensitions.height10),
                topRight: Radius.circular(Dimensitions.height10)
               )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Align(
                    alignment: Alignment.center,
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensitions.height15),
                    height: Dimensitions.height3,
                    width: Dimensitions.width65,
                    decoration: BoxDecoration(
                      color: colors.shadow.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(Dimensitions.height10)
                    ),
                  ),
                ),
                MyTitleText(
                  title: title,
                  padding: EdgeInsets.only(top: Dimensitions.height20,left: Dimensitions.width25,bottom: Dimensitions.height10),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimensitions.width25),
                      child: ListView.builder(
                        itemCount: _favoritTapedList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: Dimensitions.height10),
                            child: GestureDetector(
                              onTap:(){
                                if (title=="Ville") {
                                 _favoritVilleValue=_favoritTapedList[index]=="....."?"":_favoritTapedList[index];
                                 notifyListeners();
                                }else if(title=="Catégorie"){
                                 _favoritSousCateValue="";
                                 _favoritCategoryValue=_favoritTapedList[index]=="....."?"":_favoritTapedList[index];
                                 if (_favoritTapedList[index]==".....") {
                                    _favoritSousCateList=[];
                                 }
                                 for (PS e in Provider.of<CategoryProvider>(context,listen: false).service) {
                                   if (e.name==_favoritTapedList[index] ) {
                                  _favoritSousCateList=[];
                                   if (e.name==_favoritTapedList[index] ) {
                                    if (e.sCategory!.isNotEmpty) {
                                      _favoritSousCateList.add(".....");
                                      for (var e in e.sCategory!) {
                                      _favoritSousCateList.add(e.toString());
                                      }
                                    }
                                   }
                                   }
                                 }
                                 for (PS e in Provider.of<CategoryProvider>(context,listen: false).produit) {
                                 
                                   if (e.name==_favoritTapedList[index] ) {
                                     _favoritSousCateList=[];
                                    if (e.sCategory!.isNotEmpty) {
                                      _favoritSousCateList.add(".....");
                                      for (var e in e.sCategory!) {
                                        _favoritSousCateList.add(e.toString());
                                      }
                                    }
                                   }
                                 }
                                }else if(title=="Sous catégorie"){
                                 _favoritSousCateValue=_favoritTapedList[index]=="....."?"":_favoritTapedList[index];
                                }
                                notifyListeners();
                                applyFavoritFilters();
                                Get.back();
                              },
                              child: Text(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                _favoritTapedList[index],
                                style: GoogleFonts.openSans(
                                  fontSize: Dimensitions.width14,
                                  fontWeight: FontWeight.w500,
                                  color: colors.text2,
                                ),
                                ),
                            ),
                          );
                        },
                        ),
                    ),
                    ),
              ],
            ),
          );
        },
      );
    }
  }
  void clearFilter(){
    _villeValue="";
    _categoryValue="";
    _sousCateValue="";
    _sousCateList=[];
    _searchSwitch="Produits";
    notifyListeners();
  }
  void _scrollListener() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent ) {
        if (boutique == null) {
        loadMoreOtherProducts(_otherBoutiqueId);
        }else{
 
          if (_otherBoutiqueId==boutique!.docId) {
        loadMoreProducts(boutique!.docId);
          }else{
        loadMoreOtherProducts(_otherBoutiqueId);
          }

        }
    }

  }
  void _scrollListener2() {
      if (scrollController2.position.pixels == scrollController2.position.maxScrollExtent ) {
        if (boutique == null) {
        loadMoreOtherProducts(_otherBoutiqueId);
        }else{
      
          if (_otherBoutiqueId==boutique!.docId) {
        loadMoreProducts(boutique!.docId);
          }else{
        loadMoreOtherProducts(_otherBoutiqueId);
          }

        }
    }

  }
  void restSearch(){
    _searchStack=[""];
    notifyListeners();
  }
  void fetchUser(String uid) async{
    QuerySnapshot currentEuser=await _firestore.collection("users").where("uid",isEqualTo: uid).get();
    Map<String,dynamic> userInfo=  currentEuser.docs.first.data() as Map<String,dynamic>;
    _euser=EUsers(
      email: userInfo["email"], 
      password: "",
      image: userInfo["image"] ?? "",
      name: userInfo["name"],
      date: userInfo["date"] ?? "",
      type: userInfo["type"],
      bio: userInfo["bio"] ??"",
      ville:userInfo["ville"] ??"" ,
      phone:userInfo["phone"] ??"" ,
      docId: currentEuser.docs.first.id,
      );
      notifyListeners();
  } 
  void fetchboutique(String docId,String uid) async{
    QuerySnapshot currentEuser=await _firestore.collection("boutiques").where("docId",isEqualTo: docId).get();
    if (currentEuser.docs.length==1) {
      Map<String,dynamic> offre=currentEuser.docs.first["offre"];
      _offre=offre.isNotEmpty;
      _isv=currentEuser.docs.first["accepted"];
      _mode=currentEuser.docs.first["mode"];
      _boutiqueDocId=currentEuser.docs.first.id;
        if (_isv) {
          fetchUser(uid);
          List<dynamic> dynamicList = currentEuser.docs.first["liens"];
          List<dynamic> sanitizedLiens = dynamicList.map((url) => url.replaceAll('&', '%26')).toList();
          String ss = currentEuser.docs.first["profileImage"].toString().replaceAll('&', '%26');
        _otherBoutiqueId=currentEuser.docs.first.id;
          _boutique=Boutique(
             owner: true, 
             category: currentEuser.docs.first["category"], 
             docId: currentEuser.docs.first.id, 
             liens:sanitizedLiens, 
             name: currentEuser.docs.first["name"], 
             phone: currentEuser.docs.first["phone"], 
             sCategory: currentEuser.docs.first["sCate"], 
             usDocID: currentEuser.docs.first["docId"], 
             bio: currentEuser.docs.first["bio"], 
             profilPicture: ss, 
             ville: currentEuser.docs.first["ville"], 
             followers: currentEuser.docs.first["followers"], 
             following: currentEuser.docs.first["following"]
             );
        }
    }
    notifyListeners();

    
  }
  void fetchAllboutique(String Cate,String sub) async{
    _allBoutique =[];
    QuerySnapshot currentEuser=await _firestore.
    collection("boutiques")
    .where("category",isEqualTo: Cate)
    .where("sCate",isEqualTo: sub)
    .where("accepted",isEqualTo: true)
    .get();
      int compareByPlace(QueryDocumentSnapshot a, QueryDocumentSnapshot b) {
    Map<String, dynamic> pA = a["pubs"];
    Map<String, dynamic> pB = b["pubs"];

    // Check the "place" value and prioritize "a" over "b"
    String placeA = pA["place"];
    String placeB = pB["place"];

    if (placeA == placeB) {
      return 0; // Same place, keep order unchanged
    } else if (placeA == "a") {
      return -1; // a comes before b
    } else {
      return 1; // b comes after a
    }
  }

    List<QueryDocumentSnapshot> boutiques = currentEuser.docs;
    List<QueryDocumentSnapshot> pubBoutique =[];
    List<QueryDocumentSnapshot> normalBoutique =[];
     for (var pub in boutiques) {
      Map<String,dynamic> p = pub["pubs"];
      if (p.isNotEmpty) {
        Timestamp o = p["time"];
        DateTime oldTimestamp = o.toDate();
        DateTime now = DateTime.now();
        Duration difference = now.difference(oldTimestamp);
        int weeksDifference = difference.inDays ~/ 7;
        if (weeksDifference<p["week"]) {
          pubBoutique.add(pub);
        }else{
          normalBoutique.add(pub);
        }
        
      }else{
        normalBoutique.add(pub);
      }
    }
    pubBoutique.sort(compareByPlace);
    pubBoutique.addAll(normalBoutique);

    if (currentEuser.docs.length>0) {

      for (var doc in pubBoutique) {
      Map<String,dynamic> offre=doc["offre"];

        if (offre.isNotEmpty) {
          List<dynamic> dynamicList = doc["liens"];
          List<dynamic> sanitizedLiens = dynamicList.map((url) => url.replaceAll('&', '%26')).toList();

          _allBoutique.add(
          [  Boutique(
             owner: _boutique !=null ?_boutique!.docId== doc.id: false, 
             category: doc["category"], 
             docId: doc.id, 
             liens:sanitizedLiens, 
             name: doc["name"], 
             phone: doc["phone"], 
             sCategory: doc["sCate"], 
             usDocID: doc["docId"], 
             bio: doc["bio"], 
             profilPicture: doc["profileImage"], 
             ville: doc["ville"], 
             followers: doc["followers"], 
             following:doc["following"]
             ),
             false
             ]
          
          );
          
        }
        
      }
      
    }
    notifyListeners();
  }
  void showSignaler(int index){
    _allBoutique[index][1]=!_allBoutique[index][1];
    notifyListeners();
  }
  void showSignaler2(int index){
    _searchBoutique[index][1]=!_searchBoutique[index][1];
    notifyListeners();
  }
  void chekTime(String docId,String boutiqueId) async{
    QuerySnapshot currentEuser=await _firestore.collection("boutiques").where("docId",isEqualTo: docId).get();

     if (currentEuser.docs.first["offre"].isNotEmpty && currentEuser.docs.length==1) {
      Timestamp timestamp1 = currentEuser.docs.first["offre"]["date"];
      DateTime dateTime1 = timestamp1.toDate();
      DateTime dateTime2 = Timestamp.now().toDate();

      int yearDifference = dateTime2.year - dateTime1.year;
      int monthDifference = dateTime2.month - dateTime1.month;

      if (monthDifference < 0) {
        yearDifference--;
        monthDifference += 12;
      }
      if (currentEuser.docs.first["offre"]["time"]=="mensuel") {
        _checkTime= monthDifference>=1;
      }else{
        _checkTime= yearDifference>=1;
      }
      if (_checkTime) {
      _offre=false;

        await _firestore.collection("boutiques").doc(boutiqueId).update(
          {
            "offre":{},
          }
        );
         Get.offAllNamed(RouteHelper.getinitial());  
        }

      }

    notifyListeners();
  }
  void updateUser(EUsers us){
    _euser=us;
    notifyListeners();
  }
  void offreStart(){
    _checkTime=false;
    notifyListeners();
  }
  Future<void> fetchProducts(String boutiqueID) async {

    if ( _isLoading ||!_hasMore) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      Query query = _firestore
          .collection("products")
          .where('idBoutique', isEqualTo: boutiqueID)
          .orderBy('time',descending: true) // Order by a unique field, like 'name' or 'productId'
          .limit(_pageSize);

      if (_lastDocument != null) {
        query = query.startAfterDocument(_lastDocument!);
      }

      QuerySnapshot snapshot = await query.get();

      List<Products> avProducts = [];
      if (snapshot.docs.isNotEmpty) {
        _lastDocument = snapshot.docs.last; // Update the last document

        for (var e in snapshot.docs) {
          List<dynamic> pp = e["images"];
          List<String> ff = pp.map((e) => e.toString()).toList();
          avProducts.add(
            Products(
              boutiqueId: e["idBoutique"],
              descriptiont: e["description"],
              iamges: ff,
              name: e["name"],
              price: e["price"],
              productId: e.id,
              promotion: e["promotion"],
              pubs: e["pubs"] ?? {},
              rating: e["rating"],
            ),
          );
        }
        for (var p in avProducts) {
               int i =productIndex(p);
                if (i == -1) {
              _products.add(p);
                }
        }
        // _products.addAll(avProducts);

        // // Check if there are more products to load
        if (snapshot.docs.length < _pageSize) {
          _hasMore = false;
        }
      }
       else {
         _hasMore = false;
      }
    } catch (error) {
      print("Error fetching products: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void loadMoreProducts(String boutiqueID) {
    if (_isLoading || !_hasMore) {
      return;
    }
    fetchProducts(boutiqueID);
  }
  void loadAgain(Products p){
       int i =productIndex(p);
   if (i == -1) {
   _products.insert(0, p);
   notifyListeners(); 
   }
}
  void deleteProduct(Products p){
   int i =productIndex(p);
   print(i);
   if (i != -1) {
    _products.removeAt(i);
   notifyListeners(); 
   }
  }
  int  productIndex(Products p){
    for (var i = 0; i < _products.length; i++) {
    if (p.productId==_products[i].productId) {
      return i;
    }
  }
  return -1;
  }
  bool isProductinTheList(Products p){
  for (var p1 in _products) {
    if (p.productId==p1.productId) {
      return true;
    }
  }
    return false;
}
  Future<void> fetchOtherProducts(String boutiqueID) async {
    if (_otherPublicationNumber=="") {
      Query query1 = _firestore
          .collection("products")
          .where('idBoutique', isEqualTo: boutiqueID);
      QuerySnapshot snapshot1 = await query1.get();
      _otherPublicationNumber=snapshot1.docs.length.toString();
      notifyListeners();
    }
    if ( _isLoading ||!_otherHasMore) {
      return;
    }
    _isLoading = true;
    notifyListeners();

    try {
      Query query = _firestore
          .collection("products")
          .where('idBoutique', isEqualTo: boutiqueID)
          .orderBy('time',descending: true)
          .limit(_pageSize);

      if (_otherLastDocument != null) {
        query = query.startAfterDocument(_otherLastDocument!);
      }

      QuerySnapshot snapshot = await query.get();

      List<Products> avProducts = [];
      if (snapshot.docs.isNotEmpty) {
        _otherLastDocument = snapshot.docs.last; // Update the last document

        for (var e in snapshot.docs) {
          List<dynamic> pp = e["images"];
          List<String> ff = pp.map((e) => e.toString()).toList();
          avProducts.add(
            Products(
              boutiqueId: e["idBoutique"],
              descriptiont: e["description"],
              iamges: ff,
              name: e["name"],
              price: e["price"],
              productId: e.id,
              promotion: e["promotion"],
              pubs: e["pubs"] ?? {},
              rating: e["rating"],
            ),
          );
        }
        _otherProducts.addAll(avProducts);
        // // Check if there are more products to load
        if (snapshot.docs.length < _pageSize) {
          _otherHasMore = false;
        }
      }
       else {
         _otherHasMore = false;
      }
    } catch (error) {
      print("Error fetching products: $error");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
  void loadMoreOtherProducts(String boutiqueID) {
    if (_isLoading || !_otherHasMore) {
      return;
    }
    fetchOtherProducts(boutiqueID);
  }
  void changeBoutiqueId(String id){
    _otherBoutiqueId=id;
    notifyListeners();
  }
  void clearOther(){
    _otherHasMore=true;
    _otherLastDocument=null;
    _otherProducts =[];
    _otherBoutiqueId="";
    _otherPublicationNumber="";
    notifyListeners();
  }
  void getPublicationLenght() async{
      Query query1 = _firestore
          .collection("products")
          .where('idBoutique', isEqualTo: boutique!.docId);
      QuerySnapshot snapshot1 = await query1.get();
      _PublicationNumber=snapshot1.docs.length.toString();
      notifyListeners();
  }
  void clearEverything(){
  _euser=null;
  _boutique =null;
  _isv=false;
  _offre=false;
  _mode=null;
  _boutiqueDocId=null;
  _checkTime=false;
  _products.clear();
  _hasMore=true;
  _isLoading = false;
  _lastDocument=null;
  _PublicationNumber="";
  _recentSearch=null;
  _context=null;
  _favoritIndex=0;
  _promotionSwitch="Produits";
  _promotionProducts.clear();
  _promotionServices.clear();
  _oldPromotionProducts.clear();
  _oldPromotionServices.clear();
  _promotionCategoryValue="";
  _promotionSousCateList.clear();
  _promotionSousCateValue="";
  _oldSearchProducts.clear();
  _searchProducts.clear();
  _oldSearchServices.clear();
  _searchServices.clear();
  _oldLikedBoutique.clear();
  _likedBoutique.clear();
  _oldLikedProduct.clear();
  _likedProduct.clear();
  _oldLikedService.clear();
  _likedService.clear();
  _favoritCategoryValue="";
  _favoritSousCateList.clear();
  _favoritSousCateValue="";
  _favoritVilleValue="";
  _favoritBoutique.clear();
  _favoritProducts.clear();
  _followingList=null;
  _followersList=null;
  _socialIndex=0;
  _socialValue = "Abonnées";
  _isIn=false;
  _booster=false;
  _weeks =1;
  _allBoutique=[];
  _myNotification =[];
  notifyListeners();
 }  
  void fetchRecentSearch() async{
    _recentSearch=[];
    QuerySnapshot currentRs=await 
    _firestore
    .collection("rs")
    .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .orderBy('time',descending:true)
    .get();
    for (var e in currentRs.docs) {
      _recentSearch!.add(e["name"].toString());
    }
   notifyListeners();
  }
  void removeRs(int index,String name) async{
    _recentSearch!.removeAt(index);
     QuerySnapshot currentRs=await 
    _firestore
    .collection("rs")
    .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .where("name",isEqualTo: name)
    .get();
    await _firestore.collection("rs").doc(currentRs.docs.first.id).delete();
    notifyListeners();
  }
  void addRs(String search) async{
    if (_recentSearch==null) {
      _recentSearch=[];
      _recentSearch!.insert(0, search);
        await FirebaseFirestore.instance.collection("rs").add({
                          'name':search,
                          'time':Timestamp.now(),
                          'uid':FirebaseAuth.instance.currentUser!.uid,
                        });
    }else{
      if (!_recentSearch!.contains(search)) {
          _recentSearch!.insert(0, search);
            await FirebaseFirestore.instance.collection("rs").add({
                          'name':search,
                          'time':Timestamp.now(),
                          'uid':FirebaseAuth.instance.currentUser!.uid,
                        });
      }else{
      QuerySnapshot currentRs=await 
    _firestore
    .collection("rs")
    .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    .where("name",isEqualTo: search)
    .get();
    await _firestore.collection("rs").doc(currentRs.docs.first.id).update({
      'time':Timestamp.now(),
    });
    int index = _recentSearch!.indexOf(search);
    _recentSearch!.removeAt(index);
    _recentSearch!.insert(0, search);
      }
    }
    notifyListeners();
  }
  void userType(bool isTyping){
    _isSearching=isTyping;
    notifyListeners();
  }
  void addToSearchStack(String newItem){
    _searchStack.add(newItem);
      notifyListeners();
  }
  void removeLastItemFromSearchStack(){
    if(_searchStack.length !=1){
      _searchStack.removeLast();
      notifyListeners();
    }
  }
  void clearContoller(){
    _controller.clear();
    notifyListeners();
  }
  void previousValue(String text){
    _controller.text =text;
  }
  void updatedTapedList(List<String> l,String tapedText,BuildContext pageContext){
  if (tapedText=="Catégorie") {
    if (_psnames.length==0) {
      searchList(pageContext);
    }else{
    _tapedList=_psnames;
    }
    
  }else if(tapedText=="Sous catégorie"){
    _tapedList=_sousCateList;
  }
  else{
  _tapedList=l;
  }
  notifyListeners();
}
  void updatedFavoritTapedList(List<String> l,String tapedText,BuildContext pageContext){
  if (tapedText=="Catégorie") {
    if (_psnames.length==0) {
      searchList(pageContext);
    }else{
    _favoritTapedList=_psnames;
    }
    
  }else if(tapedText=="Sous catégorie"){
    _favoritTapedList=_favoritSousCateList;
  }
  else{
  _favoritTapedList=l;
  }
  notifyListeners();
  }
  void updatedPromotionTapedList(String tapedText,BuildContext pageContext){
  if (tapedText=="Catégorie") {
    if (_psnames.length==0) {
      searchList(pageContext);
    }else{
    _promotionTapedList=_psnames;
    }
    
  }else if(tapedText=="Sous catégorie"){
    _promotionTapedList=_promotionSousCateList;
  }
  notifyListeners();
}
  List<String> _psnames=[];
  void searchList(BuildContext pageContext) async{
        _psnames.add(".....");
        List<PS> myps=[];
        myps.addAll(Provider.of<CategoryProvider>(pageContext,listen: false).produit);
        myps.addAll(Provider.of<CategoryProvider>(pageContext,listen: false).service);
          for (var e in myps) {
                  _psnames.add(e.name);
                  
              }
        _tapedList=_psnames;
        _promotionTapedList=_psnames;
        _favoritTapedList=_psnames;
        notifyListeners();                          
 }
  List<dynamic> _oldSearchProducts=[];
  List<dynamic> _oldSearchServices=[];
  List<dynamic> _oldSearchBoutique=[];
  void search(String query,BuildContext context) async{
    _searchBoutique=[];
    _searchProducts=[];
    _searchServices=[];
    _oldSearchProducts=[];
    _oldSearchServices=[];
    _oldSearchBoutique=[];
    _searchSwitch="Produits";
     int compareByPlace(QueryDocumentSnapshot a, QueryDocumentSnapshot b) {
    Map<String, dynamic> pA = a["pubs"];
    Map<String, dynamic> pB = b["pubs"];

    // Check the "place" value and prioritize "a" over "b"
    String placeA = pA["place"];
    String placeB = pB["place"];

    if (placeA == placeB) {
      return 0; // Same place, keep order unchanged
    } else if (placeA == "a") {
      return -1; // a comes before b
    } else {
      return 1; // b comes after a
    }
  }
    QuerySnapshot queryBoutique = await _firestore.collection("boutiques").where("accepted",isEqualTo: true).get();
      List<QueryDocumentSnapshot> boutiques = queryBoutique.docs.where((doc) {
      String productName = doc['name'].toString().toLowerCase().trim();
      return productName.contains(query.toLowerCase().trim());
    }).toList();
    List<QueryDocumentSnapshot> pubBoutique =[];
    List<QueryDocumentSnapshot> normalBoutique =[];
     for (var pub in boutiques) {
      Map<String,dynamic> p = pub["pubs"];
      if (p.isNotEmpty) {
        Timestamp o = p["time"];
        DateTime oldTimestamp = o.toDate();
        DateTime now = DateTime.now();
        Duration difference = now.difference(oldTimestamp);
        int weeksDifference = difference.inDays ~/ 7;
        if (weeksDifference<p["week"]) {
          pubBoutique.add(pub);
        }else{
          normalBoutique.add(pub);
        }
        
      }else{
        normalBoutique.add(pub);
      }
    }
    pubBoutique.sort(compareByPlace);
    pubBoutique.addAll(normalBoutique);

    _searchBoutique=pubBoutique.map(
      (e) =>
     [
       Boutique(
        owner: _boutique !=null ?_boutique!.docId== e.id: false, 
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
        false
     ],
        ).toList();
    _oldSearchBoutique=_searchBoutique;
    // products
    QuerySnapshot queryProducts = await _firestore.collection("products").get();
    List<QueryDocumentSnapshot> products = queryProducts.docs.where((doc) {
      String productName = doc['name'].toString().toLowerCase().trim();
      return productName.contains(query.toLowerCase().trim());
    }).toList();
    List<QueryDocumentSnapshot> pubProducts =[];
    List<QueryDocumentSnapshot> normalProducts =[];
    for (var pub in products) {
      Map<String,dynamic> p = pub["pubs"];
      if (p.isNotEmpty) {
        Timestamp o = p["time"];
        DateTime oldTimestamp = o.toDate();
        DateTime now = DateTime.now();
        Duration difference = now.difference(oldTimestamp);
        int weeksDifference = difference.inDays ~/ 7;
        if (weeksDifference<p["week"]) {
          pubProducts.add(pub);
        }else{
          normalProducts.add(pub);
        }
        
      }else{
        normalProducts.add(pub);
      }
    }
   
  pubProducts.sort(compareByPlace);

  pubProducts.addAll(normalProducts);


    for (var element in pubProducts) {
      for (var e in queryBoutique.docs) {
        for (var p in Provider.of<CategoryProvider>(context,listen: false).produit) {
          if (e.id==element["idBoutique"] && p.name==e["category"]) {
              _searchProducts.add([
                e,
                element
              ]);
          }
        }
        for (var s in Provider.of<CategoryProvider>(context,listen: false).service) {
          if (e.id==element["idBoutique"] && s.name==e["category"]) {
              _searchServices.add([
                e,
                element
              ]);
          }
        }
      
      
      }
    }
    _oldSearchProducts=_searchProducts;
    _oldSearchServices=_searchServices;
   
notifyListeners();
  }
  void searchSwitchPSB(String PSB){
    _searchSwitch=PSB;
    notifyListeners();
  }
  void promotionSwitchPSB(String PSB){
    _promotionSwitch=PSB;
    notifyListeners();
  }
  void applyFilters(){
    _searchBoutique=  _oldSearchBoutique.where((filteredBoutique) {
    // Extract boutique and product details
    var boutique = filteredBoutique[0];
    // Extract individual attributes
    var productVille = boutique.ville;
    var productCategory = boutique.category;
    var productSubCategory = boutique.sCategory;
    // Check each filter conditionally
    bool matchesVille =  _villeValue.isEmpty || productVille == _villeValue;
    bool matchesCategory = _categoryValue.isEmpty || productCategory == _categoryValue;
    bool matchesSubCategory = _sousCateValue.isEmpty || productSubCategory == _sousCateValue;
    // Return true if all conditions match
    return matchesVille && matchesCategory && matchesSubCategory;
  }).toList();
  //////////////////////////////////////////
   _searchServices=  _oldSearchServices.where((filteredBoutique) {
    // Extract boutique and product details
    var boutique = filteredBoutique[0];
    // Extract individual attributes
    var productVille = boutique["ville"];
    var productCategory = boutique["category"];
    var productSubCategory = boutique["sCate"];
    // Check each filter conditionally
    bool matchesVille =  _villeValue.isEmpty || productVille == _villeValue;
    bool matchesCategory = _categoryValue.isEmpty || productCategory == _categoryValue;
    bool matchesSubCategory = _sousCateValue.isEmpty || productSubCategory == _sousCateValue;
    // Return true if all conditions match
    return matchesVille && matchesCategory && matchesSubCategory;
  }).toList();
  ///////////////////////////////////////////////////////
   _searchProducts=  _oldSearchProducts.where((filteredBoutique) {
    // Extract boutique and product details
    var boutique = filteredBoutique[0];
    // Extract individual attributes
    var productVille = boutique["ville"];
    var productCategory = boutique["category"];
    var productSubCategory = boutique["sCate"];
    // Check each filter conditionally
    bool matchesVille =  _villeValue.isEmpty || productVille == _villeValue;
    bool matchesCategory = _categoryValue.isEmpty || productCategory == _categoryValue;
    bool matchesSubCategory = _sousCateValue.isEmpty || productSubCategory == _sousCateValue;
    // Return true if all conditions match
    return matchesVille && matchesCategory && matchesSubCategory;
  }).toList();
  notifyListeners();
  }
  void getPromoted({required String proID,required String oldPrice,required String reduction}) async{
    double op= double.parse(oldPrice);
    double rp= double.parse(reduction);
    double percentage = (rp*100)/op;
        for (var element in products) {
      if (element.productId==proID) {
        element.price='${(op-rp).toString()} DA';
        element.promotion={
          "oldPrice":'$oldPrice DA',
          "percentage":percentage.toString(),
        };
        await _firestore.collection("products").doc(proID).update(
          {
            "price":'${(op-rp).toString()} DA',
            "promotion":{
              "oldPrice":'$oldPrice DA',
              "percentage":percentage.toString(),
                        },
          }
        );
        notifyListeners();
      }
    }
  }
  List<dynamic> _oldPromotionProducts =[];
  List<dynamic> _oldPromotionServices =[];
  bool isPromotionProductThere(String id,List<dynamic> l){
    for (var e in l) {
      if (e[1].id==id) {
        return true;
      }
    }
    return false;
  }
  void getPromotedProducts(BuildContext context) async{
    QuerySnapshot queryBoutique = await _firestore.collection("boutiques").get();
    // Categorys
    QuerySnapshot queryProducts = await _firestore.collection("products").get();
    List<QueryDocumentSnapshot> products = queryProducts.docs.where((doc) {
      return doc['promotion'] is! bool;
    }).toList();
    if (_promotionProducts.length==0 && _promotionServices.length==0) {
      for (var element in products) {
      // Products
      for (var e in queryBoutique.docs) {
        for (var p in Provider.of<CategoryProvider>(context,listen: false).produit) {
          if (e.id==element["idBoutique"] && p.name==e["category"] && !isPromotionProductThere(element.id,_promotionProducts)) {
              _promotionProducts.add([
                e,
                element
              ]);
          }
        }
        // Services
        for (var s in Provider.of<CategoryProvider>(context,listen: false).service) {
          if (e.id==element["idBoutique"] && s.name==e["category"] && !isPromotionProductThere(element.id,_promotionServices)) {
              _promotionServices.add([
                e,
                element
              ]);
          }
        }

      
      
      }
    }
    _oldPromotionProducts =_promotionProducts;
    _oldPromotionServices =_promotionServices;
    notifyListeners();
    }
  }
  void refreshPromotedCategory(BuildContext context) async{
    _promotionCategoryValue="";
    _promotionSousCateValue="";
    List<dynamic> tempPromotionProducts=[];
    List<dynamic> tempPromotionServices=[];
    QuerySnapshot queryBoutique = await _firestore.collection("boutiques").get();
    // Categorys
    QuerySnapshot queryProducts = await _firestore.collection("products").get();
    List<QueryDocumentSnapshot> products = queryProducts.docs.where((doc) {
      return doc['promotion'] is! bool;
    }).toList();


    for (var element in products) {
      // Products
      for (var e in queryBoutique.docs) {
        for (var p in Provider.of<CategoryProvider>(context,listen: false).produit) {
          if (e.id==element["idBoutique"] && p.name==e["category"]) {
            var productPair=[e,element];
            if (!isPairInList(_oldPromotionProducts,productPair)) {
              tempPromotionProducts.add(productPair);
            }
          }
        }
        // Services
        for (var s in Provider.of<CategoryProvider>(context,listen: false).service) {
          if (e.id==element["idBoutique"] && s.name==e["category"]) {
              var servicePair=[e,element];
            if (!isPairInList(_oldPromotionServices,servicePair)) {
              tempPromotionServices.add(servicePair);
            }
          }
        }
      }
    }
    _oldPromotionProducts.addAll(tempPromotionProducts);
    _oldPromotionServices.addAll(tempPromotionServices);
    _promotionProducts=_oldPromotionProducts;
    _promotionServices=_oldPromotionServices;
    notifyListeners();
  }
  void promotionSearch(String query){
    _promotionCategoryValue="";
    _promotionSousCateValue="";
    _promotionSousCateList=[];                       
    _promotionProducts=_oldPromotionProducts.where((e) {
       String productName = e[1]['name'].toString().toLowerCase().trim();
      return productName.contains(query.toLowerCase().trim());
    //  return  e[1]["name"].toString().contains(query);
    },).toList();
    _promotionServices=_oldPromotionServices.where((e) {
       String productName = e[1]['name'].toString().toLowerCase().trim();
      return productName.contains(query.toLowerCase().trim());
    //  return  e[1]["name"].toString().toL.contains(query);
    },).toList();
    notifyListeners();
  }
  void restPromotionLists(){
    _promotionProducts=_oldPromotionProducts;
    _promotionServices=_oldPromotionServices;
    notifyListeners();
  }
  bool isPairInList(List<dynamic> list, var pair) {
      for (var e in list) {
        if (e[1].id==pair[1].id) {
          return true;
        }
        
      }
      return false;
    }
  int  getPairIndexInList(List<dynamic> list, String pair) {
    for (int i = 0; i < list.length; i++) {
      if (list[i][1].id == pair) {
        return i;
      }
    }
    return -1; // Return -1 if the pair is not found
  }
  void applyPromotionFilters(){

  //////////////////////////////////////////
   _promotionServices=  _oldPromotionServices.where((filteredBoutique) {
    // Extract boutique and product details
    var boutique = filteredBoutique[0];

    var productCategory = boutique["category"];
    var productSubCategory = boutique["sCate"];

    // Check each filter conditionally
    bool matchesCategory = _promotionCategoryValue.isEmpty || productCategory == _promotionCategoryValue;
    bool matchesSubCategory = _promotionSousCateValue.isEmpty || productSubCategory == _promotionSousCateValue;
    // Return true if all conditions match
    return  matchesCategory && matchesSubCategory;
  }).toList();
  ///////////////////////////////////////////////////////
   _promotionProducts=  _oldPromotionProducts.where((filteredBoutique) {
    // Extract boutique and product details
    var boutique = filteredBoutique[0];

    var productCategory = boutique["category"];
    var productSubCategory = boutique["sCate"];

    // Check each filter conditionally
    bool matchesCategory = _promotionCategoryValue.isEmpty || productCategory == _promotionCategoryValue;
    bool matchesSubCategory = _promotionSousCateValue.isEmpty || productSubCategory == _promotionSousCateValue;
    // Return true if all conditions match
    return  matchesCategory && matchesSubCategory;
  }).toList();
  notifyListeners();
  }
  void getProductComments(String id) async{
    QuerySnapshot commentSnapshot = await  _firestore.
    collection("comments").
    where("productId",isEqualTo:id )
    .orderBy("timestamp",descending: false)
    .get();

    _comment = commentSnapshot.docs.map((e) =>
    productComment(
      productId: e["productId"],
      content: e["content"], 
      date: e["timestamp"], 
      image: e["image"], 
      nameProfile: e["nameProfile"], 
      raiting: e["raiting"]
      ),
    ).toList();
    notifyListeners();
  }
  void clearProductComments(){
    _comment = [];
    notifyListeners();
  }
  void addComment(productComment c){
    _comment.add(c);
    notifyListeners();
  }
  void addRemoveFavoritProduct(String id,BuildContext context) async{
    if (_favoritProducts.contains(id)) {
      _favoritProducts.remove(id);
      QuerySnapshot snap = await FirebaseFirestore
      .instance
      .collection("favoritProducts")
      .where("productID",isEqualTo: id)
      .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
      await FirebaseFirestore.instance.collection("favoritProducts").doc(snap.docs.first.id).delete();
      
      int Pindex = getPairIndexInList(_oldLikedProduct,id);
      int Sindex = getPairIndexInList(_oldLikedService,id);
    
      if (Pindex != -1) {
        _oldLikedProduct.removeAt(Pindex);
      }else{
        _oldLikedService.removeAt(Sindex);
      }
    }else{
      _favoritProducts.add(id);
      await FirebaseFirestore.instance.collection("favoritProducts").add({
        "uid":FirebaseAuth.instance.currentUser!.uid,
        "productID":id,
      });
    getLikedProduct(context);
    }
    applyFavoritFilters();
    notifyListeners();
  }
  void loadFavoritProduct() async{
    if (_favoritProducts.length==0) {
      QuerySnapshot snap = await FirebaseFirestore
      .instance
      .collection("favoritProducts")
      .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
      _favoritProducts= snap.docs.map((e) => e["productID"].toString(),).toList();
    }
    notifyListeners();
  }
  void addRemoveFavoritBoutique(String id) async{
    if (_favoritBoutique.contains(id)) {
      _favoritBoutique.remove(id);
      int indexOldLiked=indexPairInLikedBoutiqueList(_oldLikedBoutique,id);
      if (indexOldLiked != -1) {
      _oldLikedBoutique.removeAt(indexOldLiked);
      }
      applyFavoritFilters();
      QuerySnapshot snap = await FirebaseFirestore
      .instance
      .collection("favoritBoutique")
      .where("boutiqueID",isEqualTo: id)
      .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
      await FirebaseFirestore.instance.collection("favoritBoutique").doc(snap.docs.first.id).delete();

    }else{
      _favoritBoutique.add(id);
      await FirebaseFirestore.instance.collection("favoritBoutique").add({
        "uid":FirebaseAuth.instance.currentUser!.uid,
        "boutiqueID":id,
      });
    getLikedBoutiques();
    }
    notifyListeners();
  }
  void loadFavoritBoutique() async{
    if (_favoritBoutique.length==0) {
      QuerySnapshot snap = await FirebaseFirestore
      .instance
      .collection("favoritBoutique")
      .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get();
      _favoritBoutique= snap.docs.map((e) => e["boutiqueID"].toString(),).toList();
    }
    notifyListeners();
  }
  void updateFavoritIndex(String val){
    if (val=="Produits") {
      _favoritIndex=0;
    }else if(val=="Services"){
      _favoritIndex=1;

    }else{
      _favoritIndex=2;

    }
    notifyListeners();
  }
  List<dynamic> _oldLikedBoutique =[];
  List<dynamic> _oldLikedProduct =[];
  List<dynamic> _oldLikedService =[];
  bool isPairInLikedBoutiqueList(List<dynamic> list, var pair) {
  for (var e in list) {
    if (e[0].docId==pair[0].docId) {
      return true;
    }
    
  }
  return false;
  }
  int indexPairInLikedBoutiqueList(List<dynamic> list, String pair) {
      for (var i = 0; i < list.length; i++) {
         if (list[i][0].docId==pair) {
            return i;
          }
      }
      return -1;
  }
  void getLikedBoutiques() async {
  QuerySnapshot queryBoutique = await _firestore.collection("boutiques").get();
  List<QueryDocumentSnapshot> boutiques = queryBoutique.docs.where((doc) {
    return _favoritBoutique.contains(doc.id);
  }).toList();
  if (boutiques.isNotEmpty) {
    List<dynamic> newLikedBoutique = boutiques.map((e) {
      Boutique boutique = Boutique(
        owner: false,
        docId: e.id,
        bio: e["bio"],
        category: e["category"],
        usDocID: e["docId"],
        liens: List<String>.from(e["liens"]).map((url) => url.replaceAll('&', '%26')).toList(),
        name: e["name"],
        phone: e["phone"],
        profilPicture: e["profileImage"],
        sCategory: e["sCate"],
        ville: e["ville"],
        followers: e["followers"],
        following: e["following"],
      );

      List<dynamic> pair = [boutique, false];
      if (!isPairInLikedBoutiqueList(_likedBoutique, pair)) {
        return pair;
      }
      return null;
    }).where((pair) => pair != null).toList();
    _oldLikedBoutique.addAll(newLikedBoutique);
    applyFavoritFilters();
  } else {
    _oldLikedBoutique = [];
    _likedBoutique = [];
  }
  notifyListeners();
}
  void getLikedProduct(BuildContext context) async{

    QuerySnapshot queryBoutique = await _firestore.collection("boutiques").get();
    // products
    QuerySnapshot queryProducts = await _firestore.collection("products").get();

    List<QueryDocumentSnapshot> products = queryProducts.docs.where((doc) {
      return _favoritProducts.contains(doc.id);
    }).toList();
    if (products.isNotEmpty) {
      for (var element in products) {
      for (var e in queryBoutique.docs) {
        for (var p in Provider.of<CategoryProvider>(context,listen: false).produit) {
          var pair = [e,element];
          if (e.id==element["idBoutique"] && p.name==e["category"] && !isPairInList(_likedProduct,pair)) {
              _likedProduct.add([
                e,
                element
              ]);
          }
        }
        for (var s in Provider.of<CategoryProvider>(context,listen: false).service) {
          var pair = [e,element];
          if (e.id==element["idBoutique"] && s.name==e["category"] && !isPairInList(_likedService,pair)) {
              _likedService.add([
                e,
                element
              ]);
          }
        }
      }
    }
    _oldLikedProduct=_likedProduct;
    _oldLikedService=_likedService;
    }
  }
  void applyFavoritFilters(){
    _likedBoutique=  _oldLikedBoutique.where((filteredBoutique) {
    // Extract boutique and product details
    var boutique = filteredBoutique[0];
    // Extract individual attributes
    var productVille = boutique.ville;
    var productCategory = boutique.category;
    var productSubCategory = boutique.sCategory;
    // Check each filter conditionally
    bool matchesVille =  _favoritVilleValue.isEmpty || productVille == _favoritVilleValue;
    bool matchesCategory = _favoritCategoryValue.isEmpty || productCategory == _favoritCategoryValue;
    bool matchesSubCategory = _favoritSousCateValue.isEmpty || productSubCategory == _favoritSousCateValue;
    // Return true if all conditions match
    return matchesVille && matchesCategory && matchesSubCategory;
  }).toList() ;
  //////////////////////////////////////////
   _likedService=  _oldLikedService.where((filteredBoutique) {
    // Extract boutique and product details
    var boutique = filteredBoutique[0];
    // Extract individual attributes
    var productVille = boutique["ville"];
    var productCategory = boutique["category"];
    var productSubCategory = boutique["sCate"];
    // Check each filter conditionally
     bool matchesVille =  _favoritVilleValue.isEmpty || productVille == _favoritVilleValue;
    bool matchesCategory = _favoritCategoryValue.isEmpty || productCategory == _favoritCategoryValue;
    bool matchesSubCategory = _favoritSousCateValue.isEmpty || productSubCategory == _favoritSousCateValue;
    // Return true if all conditions match
    return matchesVille && matchesCategory && matchesSubCategory;
  }).toList();
  ///////////////////////////////////////////////////////
   _likedProduct=  _oldLikedProduct.where((filteredBoutique) {
    // Extract boutique and product details
    var boutique = filteredBoutique[0];
    // Extract individual attributes
    var productVille = boutique["ville"];
    var productCategory = boutique["category"];
    var productSubCategory = boutique["sCate"];
    // Check each filter conditionally
     bool matchesVille =  _favoritVilleValue.isEmpty || productVille == _favoritVilleValue;
    bool matchesCategory = _favoritCategoryValue.isEmpty || productCategory == _favoritCategoryValue;
    bool matchesSubCategory = _favoritSousCateValue.isEmpty || productSubCategory == _favoritSousCateValue;
    // Return true if all conditions match
    return matchesVille && matchesCategory && matchesSubCategory;
  }).toList();
  notifyListeners();
  }
  void getFollowingList() async{
    QuerySnapshot followersSnap= await _firestore
        .collection("socialMedia")
        .where("uid",isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();
        _followingList = followersSnap.docs.map(
          (e) =>
          socialMedia(
            docId: e.id,
            bid: e["bid"],
            imageB: e["imageB"],
            imageU: e["imageU"],
            nameB: e["nameB"],
            nameU:e["nameU"],
            uid: e["uid"],
            ) ,
            )
          .toList();
    notifyListeners();
  }
  void addRemoveFollowingList({required String bid,required String imageB,required String nameB,required BuildContext context}) async{
    if (isInFolowingList(bid) != -1) {
      await _firestore.collection("socialMedia").doc(_followingList![isInFolowingList(bid)].docId).delete();
      _followingList!.removeAt(isInFolowingList(bid));
      _otherFollowers--;
      Provider.of<CategoryProvider>(context,listen: false).removeAbonnementBoutique(bid);
    }else{
    final us=  await _firestore.collection("socialMedia").add({
            "bid": bid,
            "uid": FirebaseAuth.instance.currentUser!.uid,
            "imageB": imageB,
            "imageU": _euser!.image,
            "nameB": nameB,
            "nameU":_euser!.name,
      });
  _followingList!.add(
      socialMedia(
        docId: us.id, 
        bid: bid, 
        uid: FirebaseAuth.instance.currentUser!.uid, 
        nameB: nameB, 
        nameU: _euser!.name, 
        imageB: imageB, 
        imageU: _euser!.image,
        )
    );
    _otherFollowers++;
    Provider.of<CategoryProvider>(context,listen: false).addToFollowingList(bid);
      DocumentSnapshot dd = await FirebaseFirestore.instance.collection("boutiques").doc(bid).get();
                     DocumentSnapshot ss = await FirebaseFirestore.instance.collection("users").doc(dd["docId"]).get();

                  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                    .collection("tokens")
                    .where("uid", isEqualTo: ss["uid"])
                    .get();
                    if (querySnapshot.docs.length > 0) {
                PushNotificationServices.sendNotificationToSelectedDriver(
                  deviceToken: querySnapshot.docs.first["token"], 
                  notifi: 
                  MyNotificationClass(
                    senderID: FirebaseAuth.instance.currentUser!.uid,
                    reciverID: ss["uid"], 
                    content: "a commencé à vous suivre. Restez à l'écoute pour interagir avec vos nouveaux abonnés et partager vos dernières nouveautés.", 
                    imageSender: euser!.image, 
                    nameSender: euser!.name, 
                    timestamp: DateTime.now().toString()
                    ), 
                  title: "Nouvel Abonné !, ${euser!.name}"
                  );
                  await FirebaseFirestore.instance.collection("usersNotifications").add({
                            "senderID":  FirebaseAuth.instance.currentUser!.uid,
                            "reciverID": ss["uid"],  
                            "content": "a commencé à vous suivre. Restez à l'écoute pour interagir avec vos nouveaux abonnés et partager vos dernières nouveautés.", 
                            "imageSender": euser!.image, 
                            "nameSender": euser!.name, 
                            "timestamp": Timestamp.now(),
                          });
                    }
    }
    notifyListeners();

  }
  int  isInFolowingList(String bid){
    if (_followingList != null) {
      for (var i = 0; i < _followingList!.length; i++) {
        if (_followingList![i].bid == bid && _followingList![i].uid == FirebaseAuth.instance.currentUser!.uid) {
          return i;
        }
      }
    }
    return -1;
  }
  void getFollowersList(String bid) async{
    QuerySnapshot followersSnap= await _firestore
    .collection("socialMedia")
    .where("bid",isEqualTo: bid)
    .get();
    _followersList = followersSnap.docs.map(
      (e) =>socialMedia(
            docId: e.id,
            bid: e["bid"],
            imageB: e["imageB"],
            imageU: e["imageU"],
            nameB: e["nameB"],
            nameU:e["nameU"],
            uid: e["uid"],
            ) ,
      ).toList();
      notifyListeners();
  }
  void getOtherFollowing(String docUBid) async{
    DocumentSnapshot documentSnapshot = await _firestore.collection("users").doc(docUBid).get();
     QuerySnapshot followersSnap= await _firestore
        .collection("socialMedia")
        .where("uid",isEqualTo: documentSnapshot["uid"])
        .get();

    _otherFollowing = followersSnap.docs.length;
    notifyListeners();

  }
  void getOtherFollowers(String bid) async{
      QuerySnapshot followersSnap= await _firestore
    .collection("socialMedia")
    .where("bid",isEqualTo: bid)
    .get();
    _otherFollowers = followersSnap.docs.length;
    notifyListeners();
  }
  void updateMysocialIndex(int index){
    _socialIndex = index;
    notifyListeners();
  }
  void updateMysocialValue(String social){
    _socialValue = social;
    notifyListeners();
  }
  void updaetSocialPage(bool state){
    _isIn = state;
    notifyListeners();
  }
  void addRemoveRemovedFollowingList(socialMedia sc){
    if (_removedFollowingList.contains(sc)) {
      _removedFollowingList.remove(sc);
    }else{
      _removedFollowingList.add(sc);
    }
  }
  void removeItemsFromFollowingList(BuildContext context){
    for (var e in _removedFollowingList) {
      addRemoveFollowingList(bid: e.bid, imageB: e.imageB, nameB: e.nameB,context: context);
    }
    _removedFollowingList.clear();
  }
  void updateBooster(){
    _booster =!booster;
    if (!_booster) {
      _weeks=1;
    }
    notifyListeners();
  }
  void updateWeeks(int newWeek){
    _weeks = newWeek;
    notifyListeners();
  }
}