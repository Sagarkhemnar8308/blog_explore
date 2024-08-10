import 'package:blog_explore/bloc/get_blog_model.dart';
import 'package:blog_explore/utils/colors.dart';
import 'package:flutter/material.dart';

class BlogDetailScreen extends StatefulWidget {
  final Blog? data;
  const BlogDetailScreen({super.key, required this.data});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: _buildAppBar(),
      ),
      body: _buildScreen(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: blackColor,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_rounded,
          color: whiteColor,
        ),
      ),
      title: Text(
        widget.data?.title ?? "",
        style: TextStyle(
          color: whiteColor,
          fontSize: 19,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildScreen() {
    return const Column(
      children: [],
    );
  }
}
