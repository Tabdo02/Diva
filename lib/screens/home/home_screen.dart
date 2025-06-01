import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diva/class/boutique.dart';
import 'package:diva/class/notification.dart';
import 'package:diva/class/users.dart';
import 'package:diva/compoents/home/bottom_bar.dart';
import 'package:diva/provider/account/user_provider.dart';
import 'package:diva/routes/route_helper.dart';
import 'package:diva/screens/category/category.dart';
import 'package:diva/screens/category/sCategory.dart';
import 'package:diva/screens/home/pages/annouce.dart';
import 'package:diva/screens/home/pages/app%20bar%20page/favoris_page.dart';
import 'package:diva/screens/home/pages/app%20bar%20page/menu_drawer.dart';
import 'package:diva/screens/home/pages/app%20bar%20page/notification_page.dart';
import 'package:diva/screens/home/pages/home.dart';
import 'package:diva/screens/home/pages/profile/account.dart';
import 'package:diva/screens/home/pages/profile/boutique_profile.dart';
import 'package:diva/screens/home/pages/profile/centre_d_aide.dart';
import 'package:diva/screens/home/pages/profile/confi.dart';
import 'package:diva/screens/home/pages/profile/contacter_e_wom.dart';
import 'package:diva/screens/home/pages/profile/devenir/formulatir.dart';
import 'package:diva/screens/home/pages/profile/inforamtion_personelle.dart';
import 'package:diva/screens/home/pages/profile/mon_reseau.dart';
import 'package:diva/screens/home/pages/promotion.dart';
import 'package:diva/screens/home/search/search.dart';
import 'package:diva/utils/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class Home extends StatefulWidget {
  final bool isv;
  const Home({super.key,required this.isv});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _index=0;
  int _pindex=0;

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController _scrollController = ScrollController();
  final ScrollController _scrollController2 = ScrollController();

void scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
  void scrollToTop2() {
    _scrollController2.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
  // Initialize the FlutterLocalNotificationsPlugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = 
    FlutterLocalNotificationsPlugin();
@override
void initState() {
  super.initState();
  StartListening();
//  if (Provider.of<userProvider>(context,listen: false).myNotification==null) {
//         Provider.of<userProvider>(context,listen: false).getMyNotification();
//       }
  // Initialize settings for Android
  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('logo_g1615'); // Replace with your app icon

  // Initialize settings for both Android and iOS
  final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  // Listen for foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (message.notification!.title!.startsWith("Nouvel Abonné !,")) {
      Provider.of<userProvider>(context,listen: false).getFollowersList(Provider.of<userProvider>(context,listen: false).boutique!.docId);
    }

    if (message.notification!.title!.startsWith("Nous avons réduit les prix de certains de nos meilleurs produits !")) {
      Provider.of<userProvider>(context,listen: false).refreshPromotedCategory(context);
    }

    if (message.data["senderID"]=="admin") {
       Provider.of<userProvider>(context,listen: false).fetchboutique(Provider.of<userProvider>(context,listen: false).euser!.docId,FirebaseAuth.instance.currentUser!.uid);
    }

    if (message.notification != null) {
      // Show notification
      showNotification(message.notification!.title, message.notification!.body);
    }
  });
}

void showNotification(String? title, String? body) {
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your channel id',
    'your channel name',
    importance: Importance.max,
    priority: Priority.high,
    showWhen: false,
  );
  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);
  flutterLocalNotificationsPlugin.show(
    0, // Notification ID
    title,
    body,
    platformChannelSpecifics,
    payload: 'item x',
  );
}

void StartListening() async {

  FirebaseFirestore.instance
      .collection('usersNotifications')
      .where("reciverID", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .snapshots()
      .listen((QuerySnapshot snapshot) {
    if (snapshot.metadata.hasPendingWrites == false) {
      // New data from server, not local writes
      if (snapshot.docChanges.isNotEmpty) {
        // Process new notifications
        for (var change in snapshot.docChanges) {
          if (change.type == DocumentChangeType.added) {
            Map<String,dynamic> d = change.doc.data() as Map<String,dynamic>;
            Timestamp t = d["timestamp"];
            DateTime date = t.toDate();
            Provider.of<userProvider>(context,listen: false)
    .addNewNotification(
      MyNotificationClass(
        senderID: d["senderID"], 
        reciverID: d["reciverID"], 
        content: d["content"], 
        imageSender: d["imageSender"], 
        nameSender: d["nameSender"], 
        timestamp: date.toString(),
        )
        );
          }
        }
      }
    }
  }, onError: (error) {
    print('Error: $error');
  });
}



  @override
  Widget build(BuildContext context) {

     if (Provider.of<userProvider>(context,listen: false).context==null) {
           Provider.of<userProvider>(context,listen: false).setContext(context);
         }
   
return Scaffold(
  key:_scaffoldKey,

drawer:MenuDrawer(
 
),
 
backgroundColor: colors.bg,
body:
 IndexedStack(
  index: _index,
  children: [
    // accuiel
     WillPopScope(
            onWillPop: () async {
              Provider.of<userProvider>(context,listen: false).clearFilter();
               if (Get.nestedKey(5)?.currentState?.canPop() ?? false) {
                Get.nestedKey(5)?.currentState?.pop();
                 Provider.of<userProvider>(context,listen: false).removeLastItemFromSearchStack();
                          if (Provider.of<userProvider>(context,listen: false).LastsearchStack=="") {
                          Provider.of<userProvider>(context,listen: false).userType(false);
                            Provider.of<userProvider>(context,listen: false).clearContoller();
                          }else{
                            Provider.of<userProvider>(context,listen: false).search(Provider.of<userProvider>(context,listen: false).LastsearchStack,context);
                            Provider.of<userProvider>(context,listen: false).previousValue(Provider.of<userProvider>(context,listen: false).LastsearchStack);
                          }
                return false;
              }else{
                if (Get.nestedKey(1)?.currentState?.canPop() ?? false) {
                Get.nestedKey(1)?.currentState?.pop();
                Provider.of<userProvider>(context,listen: false).userType(false);
                return false;
              }
              return true;

              }
              
            },
            child: Navigator(
              key: Get.nestedKey(1),
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return GetPageRoute(
                    popGesture: false,
                    page: () => Accuiel(
                      onTap: openDrawer,
                      scroll: _scrollController,
                    ),
                    transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)
                    
                  );
                } else if (settings.name == RouteHelper.favorit) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () => FavorisPage(),
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                else if (settings.name == RouteHelper.notification) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () => MyNotification(),
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                else if (settings.name == RouteHelper.search ) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () => MySearch(),
                    transition: Transition.fadeIn,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                else if (settings.name?.startsWith(RouteHelper.sousCate) ?? false) {
                  final uri = Uri.parse(settings.name!);
                  final title = uri.queryParameters['title'];
                  final sCateString = uri.queryParameters['sCate'];
                  final sCate = sCateString?.split(',') ?? [];
                  if (sCate[0] !="") {
                     return GetPageRoute(
                    popGesture: false,
                    page: () => Category(
                      title: title,
                      sCate: sCate,
                    ),
                    transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)
                  );
                  }else{
                    return GetPageRoute(
                    popGesture: false,
                    page: () {
                      return SubCategory(
                        Cate: title!,
                        sCate:"",
                      );
                    } ,
                    transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)
                  );
                  }
                 
                }
                 else if (settings.name?.startsWith(RouteHelper.subCategory) ?? false) {
                      final uri = Uri.parse(settings.name!);
                      final category = uri.queryParameters['category'];
                      final sub = uri.queryParameters['sub'];
                  return GetPageRoute(
                    popGesture: false,
                    page: () {
                      return SubCategory(
                        Cate: category!,
                        sCate:sub!,
                      );
                    } ,
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                else if (settings.name?.startsWith(RouteHelper.boutiqueProfile) ?? false) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () {
                    final uri = Uri.parse(settings.name!);
                     Boutique boutique= Boutique.fromJson(jsonDecode(uri.queryParameters['boutique']!));
                      return BoutiqueProfile(
                      boutique: boutique,
                      );
                    } ,
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                return null;
              },
            ),
          ),
    // promotion 
     WillPopScope(  
            onWillPop: () async {
              if (Get.nestedKey(2)?.currentState?.canPop() ?? false) {
                Get.nestedKey(2)?.currentState?.pop();
                return false;
              }
              return true;
            },
            child: Navigator(
              key: Get.nestedKey(2),
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return GetPageRoute(
                    popGesture: false,
                    page: () => Promotion(
                      onTap: openDrawer,
                      scroll: _scrollController2,
                    ),
                    transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)
                    
                  );
                }
                //  else if (settings.name == RouteHelper.favorit) {
                //   return GetPageRoute(
                //     popGesture: false,
                //     page: () => FavorisPage(),
                //     transition: Transition.rightToLeftWithFade
                //   );
                // }
                // else if (settings.name == RouteHelper.notification) {
                //   return GetPageRoute(
                //     popGesture: false,
                //     page: () => MyNotification(),
                //     transition: Transition.rightToLeftWithFade,
                //   );
                // }
                return null;
              },
            ),
          ),
     // add product
     annouce(),
     // account
    WillPopScope(
            onWillPop: () async {
              if (Get.nestedKey(4)?.currentState?.canPop() ?? false) {
                if (Provider.of<userProvider>(context,listen: false).isIn) {
                  Provider.of<userProvider>(context,listen: false).updaetSocialPage(false);   
                  if (Provider.of<userProvider>(context,listen: false).removedFollowingList.length>0) {
                    Provider.of<userProvider>(context,listen: false).removeItemsFromFollowingList(context);
                  }
                }
                Get.nestedKey(4)?.currentState?.pop();

                return false;
              }
              return true;
            },
            child: Navigator(
              key: Get.nestedKey(4),
              initialRoute: '/',
              onGenerateRoute: (settings) {
                if (settings.name == '/') {
                  return GetPageRoute(
                    popGesture: false,
                    page: () => Account(
                      onTap: openDrawer,
                    
                    ),
                    transition: Transition.fade,transitionDuration: Duration(milliseconds: 150)
                    
                  );
                } 
                // else if (settings.name == RouteHelper.favorit) {
                //   return GetPageRoute(
                //     popGesture: false,
                //     page: () => FavorisPage(),
                //     transition: Transition.rightToLeftWithFade
                //   );
                // }
                // else if (settings.name == RouteHelper.notification) {
                //   return GetPageRoute(
                //     popGesture: false,
                //     page: () => MyNotification(),
                //     transition: Transition.rightToLeftWithFade,
                //   );
                // }
                else if (settings.name?.startsWith(RouteHelper.infoPerso) ?? false) {
                  return GetPageRoute(
                    popGesture: false,
                    page: (){
                      final uri = Uri.parse(settings.name!);
                      EUsers us = EUsers.fromJson(jsonDecode(uri.queryParameters['us']!));
                      return informationPersonelle(
                             us: us,
                         );
                    } ,
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                else if (settings.name == RouteHelper.monResau) {
                  Provider.of<userProvider>(context,listen: false).updaetSocialPage(true);
                  return GetPageRoute(
                    popGesture: false,
                    page: () => MonReseau(),
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                else if (settings.name?.startsWith(RouteHelper.contacterEwom) ?? false) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () {
                      final uri = Uri.parse(settings.name!);
                      final email = uri.queryParameters['email'];
                      final name = uri.queryParameters['name'];
                      return contacterEWom(
                        email: email!,
                        name: name!,
                      );
                    },
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                 else if (settings.name == RouteHelper.confi) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () => confidentialite(),
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                  else if (settings.name == RouteHelper.centerAide) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () => CentreDaide(),
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                   else if (settings.name?.startsWith(RouteHelper.formulaire) ?? false) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () {
                      final uri = Uri.parse(settings.name!);
                      final docId = uri.queryParameters['docId'];
                      final image = uri.queryParameters['image'];

                      return formulair(
                        docId: docId!,
                        image: image!,
                      );
                    } ,
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
                  else if (settings.name?.startsWith(RouteHelper.boutiqueProfile) ?? false) {
                  return GetPageRoute(
                    popGesture: false,
                    page: () {
                    final uri = Uri.parse(settings.name!);
                   Boutique boutique= Boutique.fromJson(jsonDecode(uri.queryParameters['boutique']!));
                      return 
                      BoutiqueProfile(
                      boutique: boutique,
                      );
                    } ,
                    transition: Transition.rightToLeftWithFade,transitionDuration: Duration(milliseconds: 150)
                  );
                }
              
                return null;
              },
            ),
          ),
  ],
),
bottomNavigationBar: MyBottomBar(
  isV: widget.isv,
  onPageUpdated: (p0) {
    bool samePage=false;
    if (_pindex==p0) {
      samePage=true;
    }else{
      setState(() {
      _pindex=p0;
      });
    }
     
    if (p0 == 0) {
            // Pop all pages in the nested navigator if the selected index is 0
            while ((Get.nestedKey(1)?.currentState?.canPop() ?? false)&& samePage) {
              if (Provider.of<userProvider>(context,listen: false).LastsearchStack!="") {
                 Provider.of<userProvider>(context,listen: false).userType(false);
                 Provider.of<userProvider>(context,listen: false).clearContoller();
                 Provider.of<userProvider>(context,listen: false).restSearch();
              }
              Get.nestedKey(1)?.currentState?.pop();
            }
            if (Get.nestedKey(1)?.currentState?.canPop()==false && samePage) {
            scrollToTop();
            }
          }
           if (p0 == 1) {
           
            // Pop all pages in the nested navigator if the selected index is 0
            while ((Get.nestedKey(2)?.currentState?.canPop() ?? false) && samePage) {
            Provider.of<userProvider>(context,listen: false).userType(false);
              Get.nestedKey(2)?.currentState?.pop();
            }
            if (Get.nestedKey(2)?.currentState?.canPop()==false && samePage) {
              
              scrollToTop2();
            }
          }
          if (p0 == 2) {
            // Pop all pages in the nested navigator if the selected index is 0
            while ((Get.nestedKey(3)?.currentState?.canPop() ?? false)&& samePage) {
              Get.nestedKey(3)?.currentState?.pop();
            }
          }
           if (p0 == 3) {
            // Pop all pages in the nested navigator if the selected index is 0
            while ((Get.nestedKey(4)?.currentState?.canPop() ?? false)&& samePage) {
              Get.nestedKey(4)?.currentState?.pop();
            }
          }
    setState(() {
      _index=p0;
    });
  },
  ),
)
 
;
  
    
  
   }
  //Method to open the drawer
  void openDrawer() {
   _scaffoldKey.currentState?.openDrawer();
  }
  void showModelsheet(){
    showModalBottomSheet(
      context: context, 
      builder: (context) {
        return Container(
          height: 400,
          color: colors.purpel1,
        );
      },
      );
  }
  
  }



