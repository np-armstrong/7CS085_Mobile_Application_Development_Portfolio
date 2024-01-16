import 'package:flutter/material.dart';
import 'package:wlv_blog/screens/home_page.dart';
import 'package:wlv_blog/screens/edit_post.dart';

class ViewPost extends StatefulWidget {
  final int index;

  const ViewPost({super.key, required this.index});

  @override
  State<ViewPost> createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blogPosts[widget.index][0]),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 12.0,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditPost(
                              index: widget.index,
                            )));
              },
              icon: const Icon(Icons.edit),
            ),
          )
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Text(
              blogPosts[widget.index][0],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
            child: Text(
              blogPosts[widget.index][5],
              style: const TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: blogPosts[widget.index][7] == true
                ? Image.memory(blogPosts[widget.index][6])
                : Image.asset(blogPosts[widget.index][2]),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Text(
              blogPosts[widget.index][1],
              style: const TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
