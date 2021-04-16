import 'package:News/article.dart';
import 'package:News/core/enums/device_type.dart';
import 'package:News/core/ui_components/info_widget.dart';
import 'package:News/newsAPI.dart';
import 'package:News/screens/categores.dart';
import 'package:News/screens/listCategores.dart';
import 'package:News/screens/settings.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:workmanager/workmanager.dart';

import '../API.dart';
import '../main.dart';
import 'detiles.dart';
import 'newsTile.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  var _loading = true;
  var newslist;
  News news = News();
  var indexofsearchList;
  void getNews() async {
    //News news = News();
    await news.getNews(
        'http://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=2a372c7196aa4c8dacddaf330b3c4053');
    newslist = news.news;

    searchListdata = news.searshList;
    setState(() {
      _loading = false;
    });
    // for (int i; i < 10; i++) {
    //   // setState(() {
    //   //   searchListdata[i] = newslist[i].title;
    //   // });
    //   print(newslist[i].title);
    // }
  }

  ///////////////////refresh
  Future test() async {
    setState(() {
      _loading = true;
    });

    getNews();
    await Future.delayed(Duration(seconds: 2));
  }

  /////////////////////search
  var searchList = ['test', 'test', 'test'];
  var searchListdata;

  serach() {
    setState(() {});
  }

  Future _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    indexofsearchList = news.news;
    getNews();

    // Services.getUsers().then((usersFromServer) {
    //   setState(() {
    //     searchListdata = usersFromServer;
    //   });
    // }
    // );
    Workmanager.registerPeriodicTask(TAG, "simplePeriodicTask",
        initialDelay: Duration(seconds: 10),
        frequency: Duration(hours: 6),
        constraints: Constraints(
          networkType: NetworkType.connected,
          requiresBatteryNotLow: false,
          requiresCharging: false,
          requiresDeviceIdle: false,
          requiresStorageNotLow: false,
        ));
  }

  int _counterValue = 0;

  @override
  Widget build(BuildContext context) {
    ConnectivityUtils.initialize(
        serverToPing:
            "https://gist.githubusercontent.com/Vanethos/dccc4b4605fc5c5aa4b9153dacc7391c/raw/355ccc0e06d0f84fdbdc83f5b8106065539d9781/gistfile1.txt",
        callback: (response) => response.contains("This is a test!"));

    Orientation o = MediaQuery.of(context).orientation;
    return InfoWidget(builder: (context, deviceInfo) {
      print(deviceInfo.deviceType);
      //   print(deviceInfo.orientation);
      if (deviceInfo.deviceType == DeviceType.Mobile &&
          deviceInfo.orientation != Orientation.landscape) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              resizeToAvoidBottomPadding: false,
              // appBar: _buildBar(context),
              body: Builder(
                // builder is used only for the snackbar, if you don't want the snackbar you can remove
                // Builder from the tree
                builder: (BuildContext context) => HawkFabMenu(
                  icon: AnimatedIcons.menu_arrow,
                  fabColor: Colors.black38, //white12
                  iconColor: Colors.white,
                  items: [
                    HawkFabMenuItem(
                      label: 'settings',
                      ontap: () {
                        // Scaffold.of(context)..hideCurrentSnackBar();
                        // Scaffold.of(context).showSnackBar(
                        //   SnackBar(content: Text('Menu 1 selected')),
                        // );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => settings()));
                      },
                      icon: Icon(Icons.settings),
                      color: Colors.black38,
                      //  labelColor: Colors.blue,
                    ),
                    HawkFabMenuItem(
                      label: 'Home',
                      ontap: () {},
                      icon: Icon(Icons.home),
                      color: Colors.black38,
                    ),
                  ],
                  body: SafeArea(
                    /////////////safearea

                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        _buildBody(),
                        buildFloatingSearchBar(),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      } else if (deviceInfo.orientation == Orientation.landscape) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              // appBar: _buildBar(context),
              body: Builder(
                // builder is used only for the snackbar, if you don't want the snackbar you can remove
                // Builder from the tree
                builder: (BuildContext context) => HawkFabMenu(
                  icon: AnimatedIcons.menu_arrow,
                  fabColor: Colors.black38, //white12
                  iconColor: Colors.white,
                  items: [
                    HawkFabMenuItem(
                      label: 'settings',
                      ontap: () {
                        // Scaffold.of(context)..hideCurrentSnackBar();
                        // Scaffold.of(context).showSnackBar(
                        //   SnackBar(content: Text('Menu 1 selected')),
                        // );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => settings()));
                      },
                      icon: Icon(Icons.settings),
                      color: Colors.black38,
                      //  labelColor: Colors.blue,
                    ),
                    HawkFabMenuItem(
                      label: 'Home',
                      ontap: () {},
                      icon: Icon(Icons.home),
                      color: Colors.black38,
                    ),
                  ],
                  body: SafeArea(
                    /////////////safearea

                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        _buildTabletBody(
                            deviceInfo.screenHeight, deviceInfo.localWidth),
                        buildFloatingSearchBar(),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      } else {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              // appBar: _buildBar(context),
              body: Builder(
                // builder is used only for the snackbar, if you don't want the snackbar you can remove
                // Builder from the tree
                builder: (BuildContext context) => HawkFabMenu(
                  icon: AnimatedIcons.menu_arrow,
                  fabColor: Colors.black38, //white12
                  iconColor: Colors.white,
                  items: [
                    HawkFabMenuItem(
                      label: 'settings',
                      ontap: () {
                        // Scaffold.of(context)..hideCurrentSnackBar();
                        // Scaffold.of(context).showSnackBar(
                        //   SnackBar(content: Text('Menu 1 selected')),
                        // );
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => settings()));
                      },
                      icon: Icon(Icons.settings),
                      color: Colors.black38,
                      //  labelColor: Colors.blue,
                    ),
                    HawkFabMenuItem(
                      label: 'Home',
                      ontap: () {},
                      icon: Icon(Icons.home),
                      color: Colors.black38,
                    ),
                  ],
                  body: SafeArea(
                    /////////////safearea

                    child: Stack(
                      fit: StackFit.loose,
                      children: [
                        _buildTabletBody(
                            deviceInfo.screenHeight, deviceInfo.localWidth),
                        buildFloatingSearchBar(),
                      ],
                    ),
                  ),
                ),
              ),
            ));
      }
    });
  }

  Widget _buildBody() {
    return ConnectivityWidget(
      builder: (context, isOnline) => (isOnline == false)
          ? Center(
              child: Icon(
                Icons.wifi_off_sharp,
                size: 100,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 77.0),
              child: (_loading == true)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: RefreshIndicator(
                          onRefresh: test,
                          child: Column(
                            children: [
                              Expanded(flex: 1, child: listCategores()),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'recomnded',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      'See all',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Expanded(
                                flex: 6,
                                child: ListView.builder(
                                    itemCount: newslist.length,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (BuildContext context, int i) {
                                      //print(snapshot.data[1].lenthg);
                                      return NewsTile(
                                        imgUrl: newslist[i].urlToImage ?? "",
                                        title: newslist[i].title ?? "",
                                        desc: newslist[i].description ?? "",
                                        content: newslist[i].content ?? "",
                                        posturl: newslist[i].articleUrl ?? "",
                                        author: newslist[i].author ?? "",
                                        publishedAt:
                                            newslist[i].publishedAt ?? "",
                                      );
                                    }),
                              ),
                            ],
                          )),
                    ),
            ),
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      leadingActions: [
        // CircularButton(
        //   icon: const Icon(Icons.search),
        //   onPressed: () {},
        // ),
      ],

      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      maxWidth: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
        // setState(() {
        //   searchList =
        //       searchListdata.where((u) => u.startsWith(query)).toList();
        // });
        setState(() {
          indexofsearchList = news.news.where((u) {
            // indexofsearchList.add(news.searshList.indexOf(u));

            var newstile = u.title.toLowerCase();
            return newstile.contains(query);
          }).toList();
        });
        print(indexofsearchList);
        // print(news2.news.where(
        //     (u) => (u.title.toLowerCase().contains(query.toLowerCase()))));
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.person_pin),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListView.builder(
                    itemCount: indexofsearchList.length ?? 3,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: (BuildContext context, int i) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => detilesBage(
                                            imgUrl:
                                                indexofsearchList[i].urlToImage,
                                            desc: indexofsearchList[i]
                                                .description,
                                            title: indexofsearchList[i].title,
                                            content:
                                                indexofsearchList[i].content,
                                            posturl:
                                                indexofsearchList[i].articleUrl,
                                            author: indexofsearchList[i].author,
                                            publishedAt: indexofsearchList[i]
                                                .publishedAt,
                                          )));
                            },
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    indexofsearchList[i].urlToImage ?? ''),
                              ),

                              // Image.network(
                              //   indexofsearchList[i].urlToImage ?? '',
                              //   width: 80,
                              // ),
                              title: Text(
                                indexofsearchList[i].title ?? 'sd',
                                maxLines: 2,
                              ),
                            ),
                          ),
                          Divider(
                            height: 10,
                          )
                        ],
                      );
                    })
              ],
            ),
            // child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            //   // mainAxisSize: MainAxisSize.min,
            //   // children: Colors.accents.map((color) {
            //   //   return Container(height: 112, color: color);
            //   // }).toList(),
            //   // Container(
            //   //     height: 112,
            //   //     width: 100,
            //   //     child: Text(newslist[1].title ?? 'sd')),
            //   // SizedBox(
            //   //   height: 18,
            //   // ),
            //   // ListTile(
            //   //   leading: Image.network(
            //   //     newslist[0].urlToImage,
            //   //     width: 80,
            //   //   ),
            //   //   title: Text(
            //   //     newslist[1].title ?? 'sd',
            //   //     maxLines: 2,
            //   //   ),
            //   // ),
            //   // SizedBox(
            //   //   height: 10,
            //   // ),
            // ]),
          ),
        );
      },
    );
  }

  Widget _buildTabletBody(var itemHeight, var itemWidth) {
    print('hi iam tablet');
    var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    // final double itemWidth = size.width / 2;
    Orientation orientation = MediaQuery.of(context).orientation;
    print(orientation);
    print(itemHeight);
    print(itemWidth);
    // if (orientation == Orientation.landscape) {
    //   itemHeight = size.width / 2;
    //   itemWidth = (size.height - kToolbarHeight - 24) / 2.5;
    // } else {
    //   itemHeight = (size.height - kToolbarHeight - 24) / 2.5;
    //   itemWidth = size.width / 2;
    // }

    return ConnectivityWidget(
      builder: (context, isOnline) => (isOnline == false)
          ? Center(
              child: Icon(
                Icons.wifi_off_sharp,
                size: 100,
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 77.0),
              child: (_loading == true)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: RefreshIndicator(
                          onRefresh: test,
                          child: Column(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Center(child: listCategores())),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'recomnded',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      'See all',
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(
                              //   height: 15,
                              // ),
                              Expanded(
                                flex: (size.height < 400) ? 2 : 6,
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3,
                                            childAspectRatio: (orientation ==
                                                    Orientation.landscape)
                                                ? itemHeight / itemWidth * 1.1
                                                : itemWidth / itemHeight,
                                            mainAxisSpacing: 0.0),
                                    itemCount: newslist.length,
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemBuilder: (BuildContext context, int i) {
                                      //print(snapshot.data[1].lenthg);
                                      return NewsTile(
                                        imgUrl: newslist[i].urlToImage ?? "",
                                        title: newslist[i].title ?? "",
                                        desc: newslist[i].description ?? "",
                                        content: newslist[i].content ?? "",
                                        posturl: newslist[i].articleUrl ?? "",
                                        author: newslist[i].author ?? "",
                                        publishedAt:
                                            newslist[i].publishedAt ?? "",
                                      );
                                    }),
                              ),
                            ],
                          )),
                    ),
            ),
    );
  }
}
