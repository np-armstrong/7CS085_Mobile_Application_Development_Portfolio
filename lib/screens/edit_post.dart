import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wlv_blog/screens/home_page.dart';
import 'package:wlv_blog/screens/create_post.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:wlv_blog/utils/reusable_button.dart';
import 'dart:io';

class EditPost extends StatefulWidget {
  int index;
  EditPost({super.key, required this.index});

  @override
  State<EditPost> createState() => _EditPostState();
}

var _blogBox = Hive.box('blogBox');

TextEditingController editTitle = TextEditingController();
TextEditingController editBody = TextEditingController();

class _EditPostState extends State<EditPost> {
  Uint8List? imageBytes;

  void updateFromGallery() async {
    XFile? updatedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageBytes = await updatedImage!.readAsBytes();
    setState(() {
      if (imageBytes != null) {
        blogPosts[widget.index][7] = true;
        updatePost(widget.index);
      } else {
        return;
      }
    });
  }

  void updateFromCamera() async {
    XFile? updatedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    imageBytes = await updatedImage!.readAsBytes();
    blogPosts[widget.index][7] = true;
    setState(() {
      print(imageBytes);
      updatePost(widget.index);
    });
  }

  void updatePost(int index) {
    //The below values in the list are updated below
    blogPosts[index][0] = editTitle.text;
    blogPosts[index][1] = editBody.text;
    if (blogPosts[index][7] == true) {
      blogPosts[index][6] = imageBytes;
    }
    //the new updated list is then put into the box
    _blogBox.put('blogBox', blogPosts);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blogPosts[widget.index][0]),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
                onPressed: () {
                  bool _validatePost =
                      validatePost(editTitle.text, editBody.text);
                  if (_validatePost != true) {
                    print('Edit validator working');
                  } else {
                    updatePost(widget.index);
                    notifier.notifyListeners();
                    Navigator.of(context).pop();
                  }
                },
                icon: Icon(Icons.save_outlined)),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: editTitle = TextEditingController(
                    text: blogPosts[widget.index]
                        [0]), //Starting text generated from list value
              ),
            ), //Edit title
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Update Image From',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    NewButton(
                        buttonName: 'From Gallery',
                        onPressed: () {
                          setState(() {
                            updateFromGallery();
                          });
                        }),
                    NewButton(
                        buttonName: 'From Camera',
                        onPressed: () {
                          setState(() {
                            updateFromCamera();
                          });
                        })
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: blogPosts[widget.index][7] == true
                  ? Image.memory(blogPosts[widget.index][6])
                  : Image.asset(blogPosts[widget.index][2]),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                maxLines: null,
                controller: editBody = TextEditingController(
                    text: blogPosts[widget.index]
                        [1]), //Starting text generated from list value
              ),
            ),
          ],
        ),
      ),
    );
  }
}
