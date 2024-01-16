import 'package:flutter/material.dart';
import 'package:wlv_blog/screens/home_page.dart';
import 'package:wlv_blog/utils/delete_dialog.dart';
import 'package:wlv_blog/screens/edit_post.dart';

/*This is a custom card that is used on the home page. the ListView.Builder
* pushes data from the list objects to the cards constructors to generate
* a list of widgets which display the image and title of the post in the
* homescreen. This card also features a button for deletion and a button
* to navigate to the edit screen */
class PostCard extends StatelessWidget {
  final String postTitle;
  final String imageURL;
  int deleteIndex;
  int editIndex;
  bool imageSelector;

  PostCard(
      {super.key,
      required this.postTitle,
      required this.deleteIndex,
      required this.imageURL,
      required this.editIndex,
      required this.imageSelector});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        height: 150.0,
        decoration: BoxDecoration(
            color: Colors.grey[800],
            image: imageSelector == false
                ? DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(imageURL))
                : DecorationImage(
                    fit: BoxFit.cover,
                    image: MemoryImage(blogPosts[editIndex][6])),
            borderRadius: BorderRadius.circular(10.0)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  height: 46,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[900],
                      backgroundBlendMode: BlendMode.darken),
                  child: Text(
                    postTitle,
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w300),
                  ),
                ),
              ),
            ), //Title
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[900],
                      backgroundBlendMode: BlendMode.darken),
                  child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPost(
                                      index: editIndex,
                                    )));
                      }),
                ),
                const SizedBox(
                  width: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[900],
                      backgroundBlendMode: BlendMode.darken),
                  child: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return DeleteDialog(
                              deleteAt: deleteIndex,
                            );
                          },
                        );
                      }),
                ),
                const SizedBox(
                  width: 5,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
