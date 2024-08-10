import 'package:blog_explore/bloc/get_blog_cubit.dart';
import 'package:blog_explore/screen/blog_detail_screen.dart';
import 'package:blog_explore/utils/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/get_blog_model.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> {
  List<String> categories = ["All", "Merchants", "Business", "Tutorial"];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
    context.read<GetBlogCubit>().getBlog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, 60),
        child: _buildAppBar(),
      ),
      body: BlocBuilder<GetBlogCubit, GetBlogState>(
        builder: (context, state) {
          if (state is GetBlogErrorState) {
            return Center(
              child: Text(
                state.errorMessage,
                style: TextStyle(
                  color: whiteColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
          if (state is GetBlogLoadingState) {
            return Center(
              child: CircularProgressIndicator(
                color: whiteColor,
              ),
            );
          }
          if (state is GetBlogLoadedState) {
            return _buildScreen(state);
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildScreen(GetBlogLoadedState state) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10.0,
        right: 10.0,
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
            child: ListView.builder(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      categories[index],
                      style: TextStyle(
                        color: index == 0 ? whiteColor : Colors.grey,
                        fontWeight: index == 0 ? FontWeight.w600 : FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      width: 30,
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: state.model.blogs?.length ?? 0,
              itemBuilder: (context, index) {
                var data = state.model.blogs?[index];
                return _blogCard(
                  data?.imageUrl,
                  data?.title,
                  data!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: blackColor,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.arrow_back_ios_rounded,
          color: Colors.white,
        ),
      ),
      title: const Text(
        'Blogs and Articles',
        style: TextStyle(
          color: Colors.white,
          fontSize: 19,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Container(
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(30),
          ),
          alignment: Alignment.center,
          height: 40,
          width: 40,
          child: const Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget _blogCard(String? blogUrl, String? title, Blog data) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BlogDetailScreen(data: data),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(bottom: 10),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              imageUrl: blogUrl ?? "",
              height: 180,
              width: double.infinity,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title ?? "",
              style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
