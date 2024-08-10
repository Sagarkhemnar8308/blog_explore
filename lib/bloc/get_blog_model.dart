// To parse this JSON data, do
//
//     final getBlogResponseModel = getBlogResponseModelFromJson(jsonString);

import 'dart:convert';

GetBlogResponseModel getBlogResponseModelFromJson(String str) => GetBlogResponseModel.fromJson(json.decode(str));

String getBlogResponseModelToJson(GetBlogResponseModel data) => json.encode(data.toJson());

class GetBlogResponseModel {
    List<Blog>? blogs;

    GetBlogResponseModel({
        this.blogs,
    });

    factory GetBlogResponseModel.fromJson(Map<String, dynamic> json) => GetBlogResponseModel(
        blogs: json["blogs"] == null ? [] : List<Blog>.from(json["blogs"]!.map((x) => Blog.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "blogs": blogs == null ? [] : List<dynamic>.from(blogs!.map((x) => x.toJson())),
    };
}

class Blog {
    String? id;
    String? imageUrl;
    String? title;

    Blog({
        this.id,
        this.imageUrl,
        this.title,
    });

    factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        imageUrl: json["image_url"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "image_url": imageUrl,
        "title": title,
    };
}
