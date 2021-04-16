import 'package:News/Background/local_notification.dart';
import 'package:News/core/enums/device_type.dart';
import 'package:News/core/ui_components/info_widget.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../newsAPI.dart';
import 'package:News/Background/local_notification.dart';

import 'newsTile.dart';

class Category extends StatefulWidget {
  final String Url, name, imgURL;

  Category({
    this.Url,
    this.name,
    this.imgURL,
  });
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var notifcationIcon = Icons.notifications_none;
  var _loading = true;
  var newslist;
  News news = News();
  void getNews() async {
    //News news = News();
    await news.getNews(widget.Url);
    newslist = news.news;
    searchListdata = news.searshList;
    setState(() {
      _loading = false;
    });
  }

  ///////////////////refresh
  Future test() async {
    getNews();
    await Future.delayed(Duration(seconds: 2));
  }

  /////////////////////search
  var searchList = List();
  var searchListdata;
  serach() {
    setState(() {});
  }

  Future _data;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 24.0,
                semanticLabel: 'Text to announce in accessibility modes',
              ),
              onPressed: () {
                Navigator.of(context).pop();
              }),
          elevation: 0.0,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                backgroundImage: NetworkImage(widget.imgURL ??
                    'https://image.freepik.com/free-icon/important-person_318-10744.jpg'),
              ),
              SizedBox(
                width: 8,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.3, //190,
                      child: Text(
                        widget.name ?? "Mohamed Magdy",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              IconButton(
                icon: Icon(
                  notifcationIcon,
                  color: Colors.black,
                  size: 24.0,
                  semanticLabel: 'Text to announce in accessibility modes',
                ),
                onPressed: () {
                  // notifcation n = new notifcation();
                  // n.notifcation_Func();
                  Toast.show(
                      "you will start to get more notification about" +
                          " " +
                          widget.name,
                      context,
                      duration: Toast.LENGTH_SHORT,
                      gravity: Toast.BOTTOM);
                  setState(() {
                    notifcationIcon = Icons.notifications_active_sharp;
                  });
                },
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constrains) {
            if (constrains.maxWidth >= 600) {
              return _buildTabletBody(size.height, size.width);
            } else {
              return _buildBody();
            }
          },
        )
        //     InfoWidget(
        //   builder: (context, deviceInfo) {
        //     if (deviceInfo.deviceType == DeviceType.Mobile &&
        //         deviceInfo.orientation != Orientation.landscape) {
        //       return _buildBody();
        //     } else if (deviceInfo.orientation == Orientation.landscape) {
        //       return _buildTabletBody(size.height, size.width);
        //     } else {
        //       return _buildTabletBody(size.height, size.width);
        //     }
        //   },
        // ),
        );
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
              padding: const EdgeInsets.only(top: 0), //77.0
              child: (_loading == true)
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      child: RefreshIndicator(
                          onRefresh: test,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 13, right: 13, top: 5),
                                child: Container(
                                  color: Colors.black,
                                  height: 7,
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Expanded(
                                flex: 6,
                                child: ListView.builder(
                                    itemCount: 10, //newslist.length,
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

  ////////////////////////////////////////////////////////////////////////////////////////////////
  Widget _buildTabletBody(var itemHeight, var itemWidth) {
    print('hi iam tablet');
    var size = MediaQuery.of(context).size;
    Orientation orientation = MediaQuery.of(context).orientation;
    print(orientation);
    print(itemHeight);
    print(itemWidth);

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
                        child: GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio:
                                        (orientation == Orientation.landscape)
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
                                publishedAt: newslist[i].publishedAt ?? "",
                              );
                            }),
                      ),
                    ),
            ),
    );
  }
}
