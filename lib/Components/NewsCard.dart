import 'package:flutter/material.dart';

class sCard extends StatefulWidget {
  sCard();

  @override
  State<sCard> createState() => _sCardState();
}

class _sCardState extends State<sCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 1.7,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 4.0),
                    child: Text(
                      "1 day",
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Text(
                      "name",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[700],
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                                left: 4.0, right: 8.0, bottom: 8.0, top: 8.0),
                            child: Text(
                              "title",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                left: 4.0, right: 4.0, bottom: 4.0),
                            child: Text(
                              "desc",
                              style: TextStyle(
                                color: Colors.grey[500],
                              ),
                            ),
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child: Image(
                            image: NetworkImage(
                                "https://www.reuters.com/resizer/TpLPsZMUdnAtVif7YeQJ9h0AGzY=/1200x628/smart/filters:quality(80)/cloudfront-us-east-2.images.arcpublishing.com/reuters/DVKGIGKQUROXJOX2UPABZD4PWA.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          GestureDetector(
                            child: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 5.0),
                                child: Icon(Icons.share)),
                            onTap: () {},
                          ),
                          GestureDetector(
                            child: Padding(
                                padding: EdgeInsets.all(5.0), child: Text("B")),
                            onTap: () {},
                          ),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
