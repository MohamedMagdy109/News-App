import 'package:News/core/ui_components/info_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'dart:async';
import 'detilsWeb.dart';

class detilesBage extends StatefulWidget {
  final String imgUrl, title, desc, content, posturl, author;
  var publishedAt;

  detilesBage({
    this.imgUrl,
    this.desc,
    this.title,
    this.publishedAt,
    this.content,
    this.author,
    @required this.posturl,
  });
  @override
  _detilesBageState createState() => _detilesBageState();
}

class _detilesBageState extends State<detilesBage> {
  Future<void> share() async {
    await FlutterShare.share(
        title: 'share',
        text: 'shared URL',
        linkUrl: widget.posturl,
        chooserTitle: 'share article URL');
  }

  @override
  Widget build(BuildContext context) {
    var c = MediaQuery.of(context).size;
    return InfoWidget(builder: (context, deviceInfo) {
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
                backgroundImage: NetworkImage(
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
                      'Author',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      width: c.width * 0.3, //190,
                      child: Text(
                        widget.author ?? "Mohamed Magdy",
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
                    Icons.share,
                    color: Colors.black,
                    size: 24.0,
                    semanticLabel: 'Text to announce in accessibility modes',
                  ),
                  onPressed: () {
                    share();
                  }),
            ],
          ),
        ),
        body: buildmobilebody(context),
      );
    });
  }

  Widget buildmobilebody(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Container(
              child: Column(
                //    mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black,
                    height: 7,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                      width: double.infinity,
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Container(
                      //color: Colors.red,
                      child: Text(
                        widget.publishedAt.toString(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                      child: Image.network(
                    widget.imgUrl,
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    fit: BoxFit.cover,
                  )),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                      child: Text(
                    widget.desc,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 19,
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: RaisedButton.icon(
              color: Colors.black38,
              textColor: Colors.white,
              icon: Icon(Icons.next_plan_outlined),
              label: Text('visit full article'),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ArticleView(
                              postUrl: widget.posturl,
                            )));
              }),
        ),
      ],
    );
  }

  Widget buildTabletbody(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5),
            child: Container(
              child: Column(
                //    mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.black,
                    height: 7,
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    children: [
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              Container(
                                  width: double.infinity * 0.5,
                                  child: Text(
                                    widget.title,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  )),
                              SizedBox(
                                height: 12,
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: Container(
                                  //color: Colors.red,
                                  child: Text(
                                    widget.publishedAt.toString(),
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                  child: Image.network(
                                widget.imgUrl,
                                height: 180,
                                width: MediaQuery.of(context).size.width,
                                fit: BoxFit.cover,
                              )),
                            ],
                          )),
                      // Divider(
                      //   height: double.infinity * 0.5,
                      //   color: Colors.black,
                      // ),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Container(
                                  child: Text(
                                widget.desc,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                ),
                              )),
                              SizedBox(
                                height: 30,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: RaisedButton.icon(
                                    color: Colors.black38,
                                    textColor: Colors.white,
                                    icon: Icon(Icons.next_plan_outlined),
                                    label: Text('visit full article'),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ArticleView(
                                                    postUrl: widget.posturl,
                                                  )));
                                    }),
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
