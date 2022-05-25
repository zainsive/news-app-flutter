import 'package:flutter/material.dart';
import 'package:tutor_side/model/NewsPost.dart';
import 'package:intl/intl.dart';

class SinglePostDisplay extends StatefulWidget {
  Article article;
  SinglePostDisplay(this.article);
  @override
  _SinglePostDisplayState createState() => _SinglePostDisplayState();
}

class _SinglePostDisplayState extends State<SinglePostDisplay> {
  int current = 0;

  Widget getDescription(Article article) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              DateFormat.yMMMEd().format(article.publishedAt),
              style: TextStyle(color: Colors.amber, fontSize: 12),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    article.title,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    article.source.name,
                    style: TextStyle(
                        color: Colors.black45,
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Text(
              article.content,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget getBuildBody(Article article) {
    return ListView(
      children: <Widget>[
        Image.network(
              article.urlToImage,
              width: double.infinity,
              fit: BoxFit.cover,
              height: 400,
            ) ??
            Container(
              height: 400,
              width: double.infinity,
            ),
        getDescription(article),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text(''),
      ),
      body: getBuildBody(widget.article),
    );
  }
}
