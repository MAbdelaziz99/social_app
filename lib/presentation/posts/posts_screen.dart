import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Posts',
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0).r,
            child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.search,
                  size: 30.0.r,
                )),
          ),
        ],
      ),
    );
  }
}
