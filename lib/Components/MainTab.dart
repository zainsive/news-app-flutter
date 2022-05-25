import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tutor_side/Api/Constants.dart';
import 'package:tutor_side/Screens/SinglePostDisplay.dart';
import 'package:tutor_side/model/NewsPost.dart';
import 'package:intl/intl.dart';

class MainTab extends StatefulWidget {
  String category;
  MainTab(this.category);
  @override
  State<MainTab> createState() => _MainTabState();
}

class _MainTabState extends State<MainTab> {
  Future<NewsPost> topResultsPosts;
  Future<NewsPost> getPosts() async {
    var response = await Constants.getApi(
        Constants.POSTS_URL + "?category=" + widget.category);
    print(NewsPost.fromJson(jsonDecode(response)).totalResults);
    return NewsPost.fromJson(jsonDecode(response));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    topResultsPosts = getPosts();
  }

  Widget topItem(List<Article> items, int index) {
    double width = (MediaQuery.of(context).size.width - 48) / 2.5;
    double height = width * 1.5;
    return Padding(
      padding: EdgeInsets.only(
          top: 16.0,
          bottom: 16,
          left: index == 0 ? 16 : 8,
          right: index == 2 ? 16 : 8),
      child: Stack(
        children: <Widget>[
          Image.network(items[index].urlToImage,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent loadingProgress) {
                if (loadingProgress == null) return child;
                return Container(
                  width: width,
                  height: height,
                );
              },
              errorBuilder: (_, __, ___) => Container(
                    width: width,
                    height: height,
                  ),
              width: width,
              height: height,
              fit: BoxFit.fill),
          Container(
            width: width,
            height: height,
            decoration: new BoxDecoration(
                color: Colors.black.withOpacity(.6),
                borderRadius: new BorderRadius.all(Radius.circular(5.0))),
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  items[index].source.name,
                  style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.amber),
                ),
                Text(
                  items[index].title,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget top() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.only(top: 16.0, left: 16),
            child: Text(
              "Breaking News",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 243, 33, 33)),
            ),
          ),
          Container(
            height: 240,
            child: FutureBuilder<NewsPost>(
              future: topResultsPosts,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return topItem(snapshot.data.articles, index);
                    },
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget getText() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        "Latest News",
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
      ),
    );
  }

  Widget bottom() {
    return FutureBuilder<NewsPost>(
      future: topResultsPosts,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: snapshot.data.articles.sublist(10).length,
            itemBuilder: (context, index) {
              return cardItem(snapshot.data.articles.sublist(10), index);
            },
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget Body() {
    return ListView(
      scrollDirection: Axis.vertical,
      children: <Widget>[top(), getText(), bottom()],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Body();
  }

  Widget cardItem(List<Article> articles, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SinglePostDisplay(articles[index])));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(6),
              width: 90,
              height: 90,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  articles[index].urlToImage,
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorBuilder: (_, __, ___) => Container(
                    height: 90,
                    width: 90,
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(left: 6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(articles[index].title),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          articles[index].source.name,
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.amber),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(
                            DateFormat.yMMMEd()
                                .format(articles[index].publishedAt),
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
