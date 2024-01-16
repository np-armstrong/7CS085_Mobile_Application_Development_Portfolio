import 'package:flutter/material.dart';

/* This card is similar to the post card but accesses data from the
* filtered list rather than the main blogPosts list */
class SearchCard extends StatelessWidget {
  final String postTitle;
  final String imageURL;
  int viewIndex;
  bool? imageSelector;
  var memoryImage;
  List searchResults;

  SearchCard(
      {super.key,
      required this.postTitle,
      required this.imageURL,
      required this.viewIndex,
      required this.searchResults,
      required this.memoryImage,
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
                    image: MemoryImage(memoryImage!),
                  ),
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
            ),
          ],
        ),
      ),
    );
  }
}
