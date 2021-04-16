import 'package:flutter/material.dart';

import 'categores.dart';

class listCategores extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> names = <String>[
      'Apple News',
      'Tesla News',
      'TechCrunch',
      'Wall Street Journal',
      'Top business headlines in the US',
      'Top business headlines in the US',
      'Tesla News',
      'Apple News',
      'TechCrunch',
      'Wall Street Journal',
    ];
    final List<String> urls = <String>[
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
      'https://newsapi.org/v2/everything?q=tesla&from=2021-03-12&sortBy=publishedAt&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
      'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
      'https://newsapi.org/v2/everything?q=apple&from=2021-04-07&to=2021-04-07&sortBy=popularity&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
      'https://newsapi.org/v2/everything?q=tesla&from=2021-03-12&sortBy=publishedAt&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
      'https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
      'https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
      'https://newsapi.org/v2/everything?domains=wsj.com&apiKey=2a372c7196aa4c8dacddaf330b3c4053',
    ];
    final List<String> imgURLS = <String>[
      'https://sm.ign.com/ign_mear/screenshot/default/og-default_pecu.jpg',
      'https://i.pinimg.com/originals/7b/80/b3/7b80b3276866f2258b570aa6c07e54ca.jpg',
      'https://pbs.twimg.com/profile_images/1096066608034918401/m8wnTWsX.png',
      'https://s.wsj.net/img/meta/wsj-social-share.png',
      'https://www.countryflags.com/wp-content/uploads/round-button-states-package.jpg',
      'https://images.photowall.com/products/55995/gold-us-flag.jpg?h=699&q=85',
      'https://mir-s3-cdn-cf.behance.net/project_modules/fs/930e0b29948727.561390457a764.jpg',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSORt_ZOQkkpl4XF4k4WGAlJ0t2GTkbXVQ_qQ&usqp=CAU',
      'https://cdn.iconscout.com/icon/free/png-256/techcrunch-458202.png',
      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTd3dpNbtYrrhVS1UQbbzQarh_tJD6L4Pwi4Q&usqp=CAU',
    ];
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Container(
        //  height: MediaQuery.of(context).size.height * 0.3, //100,
        child: ListView.separated(
          itemCount: names.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Category(
                                  Url: urls[index],
                                  name: names[index],
                                  imgURL: imgURLS[index],
                                )));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      //  color: Colors.black,
                    ),
                    height: MediaQuery.of(context).size.height * 0.1, // 60,
                    width: MediaQuery.of(context).size.width * 0.17, //60,

                    child: CircleAvatar(
                      backgroundColor: Colors.black,
                      backgroundImage: NetworkImage(
                        imgURLS[index] ??
                            'https://image.freepik.com/free-icon/important-person_318-10744.jpg',
                      ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 15,
                // ),
                // Text(names[index])
              ],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            width: 20,
          ),
        ),
      ),
    );
  }
}
