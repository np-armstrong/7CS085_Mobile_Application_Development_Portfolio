import 'package:flutter/material.dart';
import 'package:wlv_blog/screens/create_post.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wlv_blog/screens/search_posts.dart';
import 'package:wlv_blog/screens/view_post.dart';
import 'package:wlv_blog/utils/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

//Example ipsum stored in a variable
String yoloIpsum =
    'Yolo ipsum dolor sit amet, consectetur adipiscing elit. Ut ac suscipit leo. Carpe diem vulputate est nec commodo rutrum. Pellentesque mattis convallis nisi eu and I ain’t stoppin until the swear jar’s full. Ut rhoncus velit at mauris interdum, fringilla dictum neque rutrum. Curabitur mattis odio at erat viverra lobortis.';

var _blogbox = Hive.box('blogBox');

void deleteSinglePost(int index) {
  //Removes the list object at the index passed as argument
  blogPosts.removeAt(index);
  //Notifies listener to rebuild listview.builders
  notifier.notifyListeners();
  //Stores the updated list in the hive box
  _blogbox.put('blogBox', blogPosts);
}

List initialPosts = [
  [
    "Example Post!",
    yoloIpsum,
    "assets/flutter.jpeg",
    false,
    '',
    'Posted on: 19-6-2023',
    '',
    false,
    '',
  ],
];

List blogPosts = [];

final ValueNotifier<List<dynamic>> notifier = ValueNotifier(blogPosts);

class _HomePageState extends State<HomePage> {
  var _blogbox = Hive.box('blogBox');

  void loadBox() {
    blogPosts = _blogbox.get('blogBox');
  }

  @override
  void initState() {
    /*The if statement checks to see if there is a list stored in the box 'blogBox'
    if 'null', we create an initial list then store this to the hive box as a starting list.
    */
    if (_blogbox.get('blogBox') == null) {
      blogPosts = initialPosts;
      _blogbox.put('blogBox', blogPosts);
    } else {
      loadBox(); //Retrieves the list stored in the box when app is opened
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('WLV'),
            const Text(
              'BLOG',
              style: const TextStyle(color: Colors.deepOrange),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => SearchPosts()));
                },
                icon: const Icon(Icons.search)),
          )
        ],
      ),
      body: ValueListenableBuilder(
        //notifier signals any changes to the VLB widget
        valueListenable: notifier,
        //triggers a the child of the widget when notifier detects change
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: blogPosts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ViewPost(
                              index: index,
                            ))),
                child: PostCard(
                  //values passed to the constructors of the PostCard widget
                  editIndex: index,
                  imageURL: blogPosts[index][2],
                  deleteIndex: index,
                  postTitle: blogPosts[index][0],
                  imageSelector: blogPosts[index][7],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          newPostTitle.text =
              ''; //If you start typing text into the new post but go back to homepage, the text in the controllers is reset when navigating back to the create post screen
          newPostBody.text = '';
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CreatePost()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
