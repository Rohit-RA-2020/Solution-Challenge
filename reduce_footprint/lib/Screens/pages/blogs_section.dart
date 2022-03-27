import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../store.dart';

Color primaryColor = const Color(0xffFD6592);
Color bgColor = const Color(0xffF9E0E3);
Color secondaryColor = const Color(0xff324558);

class Blogs extends StatefulWidget {
  const Blogs({
    Key? key,
  }) : super(key: key);

  @override
  State<Blogs> createState() => _BlogsState();
}

class _BlogsState extends State<Blogs> {
  void _launchURL(String _url) async {
    if (!await launch(_url)) throw 'Could not launch $_url';
  }

  @override
  Widget build(BuildContext context) {
    return blogPost.isEmpty
        ? const CircularProgressIndicator()
        : ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: blogPost.length,
            itemBuilder: (context, index) {
              //Map blog = blogPost[index];
              return GestureDetector(
                onTap: () {
                  _launchURL(blogPost[index].link);
                },
                child: Stack(
                  children: <Widget>[
                    Container(
                      width: 90,
                      height: 90,
                      color: bgColor,
                    ),
                    Container(
                      color: Colors.white,
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 100,
                            color: Colors.transparent,
                            width: 100.0,
                            child: Image.network(
                              blogPost[index].image,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  blogPost[index].title,
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    color: secondaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      WidgetSpan(
                                        child: CircleAvatar(
                                          radius: 15.0,
                                          backgroundColor: primaryColor,
                                        ),
                                      ),
                                      const WidgetSpan(
                                        child: SizedBox(width: 5.0, height: 5),
                                      ),
                                      TextSpan(
                                          text: blogPost[index].author,
                                          style:
                                              const TextStyle(fontSize: 16.0)),
                                      const WidgetSpan(
                                        child: SizedBox(width: 20.0),
                                      ),
                                      const WidgetSpan(
                                        child: SizedBox(width: 35.0),
                                      ),
                                      TextSpan(
                                        text: blogPost[index].desc,
                                      ),
                                    ],
                                  ),
                                  style: const TextStyle(height: 2.0),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              );
            },
          );
  }
}
