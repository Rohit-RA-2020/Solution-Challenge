import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../store.dart';

Color primaryColor = const Color(0xffFD6592);
Color bgColor = const Color(0xFF0D1321);
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
    if (!await launchUrl(Uri.parse(_url))) throw 'Could not launch $_url';
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
                      padding: const EdgeInsets.all(12.0),
                      margin: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0D1321),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        border: Border.all(
                          color: const Color.fromARGB(255, 255, 215, 217),
                          width: 2,
                        ),
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 100,
                            color: const Color(0xFF0D1321),
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
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0,
                                  ),
                                ),
                                const SizedBox(height: 10.0),
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      const WidgetSpan(
                                        child: SizedBox(width: 5.0, height: 5),
                                      ),
                                      TextSpan(
                                        text: blogPost[index].author,
                                        style: const TextStyle(
                                            color: Color.fromARGB(
                                                255, 230, 191, 252),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                      const WidgetSpan(
                                        child: SizedBox(width: 20.0),
                                      ),
                                      const WidgetSpan(
                                        child: SizedBox(width: 35.0),
                                      ),
                                      TextSpan(
                                        text: blogPost[index].desc,
                                        style: const TextStyle(
                                            color: Color(0xFFD3DCDE)),
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
