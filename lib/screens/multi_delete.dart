import 'package:flutter/material.dart';
import 'package:wlv_blog/screens/home_page.dart';
import 'package:wlv_blog/utils/delete_multi_card.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class DeleteMultiple extends StatefulWidget {
  const DeleteMultiple({super.key});

  @override
  State<DeleteMultiple> createState() => _DeleteMultipleState();
}

class _DeleteMultipleState extends State<DeleteMultiple> {
  void postSelected(bool? value, int index) {
    //All posts initially have a false bool at index 3, the below will
    //set the bool to true by setting it as the opposite of its current value
    blogPosts[index][3] = !blogPosts[index][3];
    //Listeners are notified to display the changes on the delete screen list view
    notifier.notifyListeners();
  }

  final _blogBox = Hive.box('blogBox');
  void deleteMultiplePosts() {
    var i = 0;
    while (i < blogPosts.length) {
      if (blogPosts[i][3] != false) {
        //When check box is = true, the below code will remove that list
        // item at the current index
        blogPosts.removeAt(i);
        //Listeners are notified to update the list views
        notifier.notifyListeners();
        //Counter reset as the remaining list items are moved down an index
        i = 0;
      } else {
        i++;
      }
      //updates the box with the remaining list items once the loop has completed
      _blogBox.put('blogBox', blogPosts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Delete Multiple Posts'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteMultiplePosts();
                Navigator.of(context).pop();
              },
            ),
          )
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: notifier,
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: blogPosts.length,
            itemBuilder: (context, index) {
              return DeleteCard(
                postSelected: blogPosts[index][3],
                onChecked: (value) => postSelected(value, index),
                imageURL: blogPosts[index][2],
                deleteIndex: index,
                postTitle: blogPosts[index][0],
                imageSelector: blogPosts[index][7],
              );
            },
          );
        },
      ),
    );
  }
}
