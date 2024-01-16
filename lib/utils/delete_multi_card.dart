import 'package:flutter/material.dart';
import 'package:wlv_blog/screens/home_page.dart';

/*This is a card that is used to display blog posts on the multidelete page
* it is a new card since it only features checkboxes that are used to select
* which posts to delete */
class DeleteCard extends StatelessWidget {
  final String postTitle;
  final String imageURL;
  Function(bool?)? onChecked;
  final bool? postSelected;
  int deleteIndex;
  bool imageSelector;

  DeleteCard(
      {super.key,
      required this.postTitle,
      required this.deleteIndex,
      required this.imageURL,
      required this.onChecked,
      required this.postSelected,
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
                    image: MemoryImage(blogPosts[deleteIndex][6])),
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
                  child: Text(postTitle,
                      softWrap: false,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w300)),
                ),
              ),
            ),
            Checkbox(
              activeColor: Colors.deepOrange,
              value: postSelected,
              onChanged: onChecked,
            ),
          ],
        ),
      ),
    );
  }
}
