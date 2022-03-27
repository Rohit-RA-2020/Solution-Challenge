import 'dart:convert';

List<BlogPost> blogPostFromJson(String str) =>
    List<BlogPost>.from(json.decode(str).map((x) => BlogPost.fromJson(x)));

String blogPostToJson(List<BlogPost> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlogPost {
  BlogPost({
    required this.title,
    required this.image,
    required this.desc,
    required this.author,
    required this.link,
  });

  String title;
  String image;
  String desc;
  String author;
  String link;

  factory BlogPost.fromJson(Map<String, dynamic> json) => BlogPost(
        title: json["title"],
        image: json["image"],
        desc: json["desc"],
        author: json["author"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "desc": desc,
        "author": author,
        "link": link,
      };
}
