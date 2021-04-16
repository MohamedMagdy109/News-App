import 'package:flutter/material.dart';

import 'detiles.dart';

class NewsTile extends StatelessWidget {
  final String imgUrl, title, desc, content, posturl, author;
  var publishedAt;

  NewsTile(
      {this.imgUrl,
      this.publishedAt,
      this.desc,
      this.title,
      this.content,
      this.author,
      @required this.posturl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(this.posturl);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => detilesBage(
                      imgUrl: imgUrl,
                      desc: desc,
                      title: title,
                      content: content,
                      posturl: posturl,
                      author: author,
                      publishedAt: publishedAt,
                    )));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 24),
          width: MediaQuery.of(context).size.width,
          child: Container(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  //color: Colors.black, ////////////
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        imgUrl,
                        height:
                            MediaQuery.of(context).size.height * 0.31, //180,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      )),
                  ////////////
                  // CachedNetworkImage(
                  //   imageUrl: imgUrl,
                  //   imageBuilder: (context, imageProvider) => ClipRRect(
                  //       borderRadius: BorderRadius.circular(6),
                  //       child: Image.network(
                  //         imgUrl,
                  //         height: 180,
                  //         width: MediaQuery.of(context).size.width,
                  //         fit: BoxFit.cover,
                  //       )),
                  //   placeholder: (context, url) => CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  // ),
                  SizedBox(
                    height: 12,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      title,
                      maxLines: 2,
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      desc,
                      maxLines: 2,
                      style: TextStyle(color: Colors.black54, fontSize: 14),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
