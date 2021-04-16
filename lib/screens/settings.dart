import 'package:flutter/material.dart';
import 'package:flutter_simple_rating_bar/flutter_simple_rating_bar.dart';

class settings extends StatefulWidget {
  @override
  _settingsState createState() => _settingsState();
}

class _settingsState extends State<settings> {
  bool notification = true, offer = true;
  @override
  Widget build(BuildContext context) {
    var c = MediaQuery.of(context).size;
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
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'News',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    Container(
                      width: c.width * 0.3, //190,
                      child: Text(
                        "Settings",
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
            ],
          ),
        ),
        body: body());
  }

  body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 10.0),
          const SizedBox(height: 20.0),
          Text(
            "PUSH NOTIFICATIONS",
            style: TextStyle(
                // color: Colors.black,
                // fontSize: 15,
                ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 0,
            ),
            child: Column(
              children: <Widget>[
                SwitchListTile(
                  activeColor: Colors.black,
                  value: notification,
                  title: Text("Received notification"),
                  onChanged: (val) {
                    if (notification == true) {
                      setState(() {
                        notification = false;
                      });
                    } else {
                      setState(() {
                        notification = true;
                      });
                    }
                  },
                ),
                _buildDivider(),
                SwitchListTile(
                  activeColor: Colors.purple,
                  value: false,
                  title: Text("Received newsletter"),
                  onChanged: null,
                ),
                _buildDivider(),
                SwitchListTile(
                  activeColor: Colors.black,
                  value: offer,
                  title: Text("Received Offer Notification"),
                  onChanged: (val) {
                    if (offer == true) {
                      setState(() {
                        offer = false;
                      });
                    } else {
                      setState(() {
                        offer = true;
                      });
                    }
                  },
                ),
                _buildDivider(),
                SwitchListTile(
                  activeColor: Colors.purple,
                  value: true,
                  title: Text("Received App Updates"),
                  onChanged: null,
                ),
              ],
            ),
          ),
          Card(
            margin: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 0,
            ),
            child: ListTile(
              leading: Icon(Icons.rate_review_outlined),
              title: Text("Rate APP"),
              onTap: () {
                showAlertDialog(context);
              },
            ),
          ),
          const SizedBox(height: 60.0),
        ],
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = FlatButton(
    color: Colors.black,
    child: Text(
      "OK",
    ),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  var rate = 0.0;
  AlertDialog alert = AlertDialog(
    title: Text("Rate APP"),
    content: Container(
      height: 50.0,
      width: 400.0,
      // alignment: Alignment.center,
      child: RatingBar(
        rating: rate,
        icon: Icon(
          Icons.star,
          size: 30,
          color: Colors.grey,
        ),
        starCount: 5,
        spacing: 5.0,
        size: 40,
        isIndicator: false,
        allowHalfRating: true,
        onRatingCallback: (double value, ValueNotifier<bool> isIndicator) {
          print('Number of stars-->  $value');
          //change the isIndicator from false  to true ,the RatingBar cannot support touch event;
          isIndicator.value = false;
        },
        clickedCallbackAsIndicator: () {
          // when isIndicator is true ,user click the stars, this callback can be called.
          print('clickedMe');
        },
        color: Colors.amber,
      ),
    ),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Container _buildDivider() {
  return Container(
    margin: const EdgeInsets.symmetric(
      horizontal: 8.0,
    ),
    width: double.infinity,
    height: 1.0,
    color: Colors.grey.shade300,
  );
}
