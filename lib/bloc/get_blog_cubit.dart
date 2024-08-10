import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:blog_explore/bloc/get_blog_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

part 'get_blog_state.dart';

class GetBlogCubit extends Cubit<GetBlogState> {
  GetBlogCubit() : super(GetBlogInitial());
  getBlog() async {
    try {
      emit(GetBlogLoadingState());
      String url = "https://intent-kit-16.hasura.app/api/rest/blogs";
      debugPrint("Url ===>>> $url ");
      var response = await get(
        Uri.parse(url),
        headers: {
          "x-hasura-admin-secret": "32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6",
        },
      );
      debugPrint("response ===>>> $response ");
      debugPrint("response status code ===>>> ${response.statusCode} ");
      final result = jsonDecode(response.body.toString());
      debugPrint("result is ===> ==> ==> $result ${response.statusCode}");
      if (response.statusCode == 200) {
        emit(
          GetBlogLoadedState(
            getBlogResponseModelFromJson(jsonEncode(result)),
          ),
        );
      } else {
        emit(GetBlogErrorState("Something went wrong , try again later"));
      }
    } catch (e) {
      emit(GetBlogErrorState("something went wrong, try again later"));
    }
  }
}
