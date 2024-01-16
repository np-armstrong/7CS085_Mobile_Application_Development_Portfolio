import 'package:flutter/material.dart';
import 'package:wlv_blog/screens/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  var box = await Hive.openBox('blogBox');
  runApp(const WlvBlog());
}

class WlvBlog extends StatelessWidget {
  const WlvBlog({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile App Development Coursework',
      home: HomePage(),
      theme: ThemeData.dark(),
    );
  }
}
