import 'package:flutter/material.dart';
import 'package:wlv_blog/screens/home_page.dart';
import 'package:wlv_blog/utils/search_card.dart';
import 'package:wlv_blog/screens/view_search_result.dart';

class SearchPosts extends StatefulWidget {
  const SearchPosts({super.key});

  @override
  State<SearchPosts> createState() => _SearchPostsState();
}

class _SearchPostsState extends State<SearchPosts> {
  bool foundPosts = false;
  String searchTerm = '';
  TextEditingController searchController = TextEditingController();
  List duplicatePosts = blogPosts;
  List? filteredPosts;

  void updateList(String searchQuery) {
    searchTerm = searchQuery;
    filteredPosts = duplicatePosts
        .where((blogPost) => //The where method cycles through the blogposts
            // in duplicateList and checks if the search term is within
            //index 0 OR 1 - these are the indexes of each list object containing
            //Title and body of text. Everything is parsed to lowercase to prevent
            //capitalisation disrupting the search.
            blogPost[0].toLowerCase().contains(searchTerm.toLowerCase()) ||
            blogPost[1].toLowerCase().contains(searchTerm.toLowerCase()))
        .toList(); //All items that match the criteria will be added to the
    //filtered post list using the toList() method.
    foundPosts = filteredPosts!.isNotEmpty; //This sets the found posts to true
    //if the filteredPosts list is populated.
    notifier.notifyListeners(); //Notifies listeners of a change
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Posts'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextField(
              onChanged: (value) => updateList(value),
              cursorColor: Colors.deepOrange,
              decoration: const InputDecoration(
                hintText: 'Search for a post',
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: notifier,
              builder: (context, value, child) {
                //If/Else to decide what to show on screen for a search.
                //If no results found, text widget displayed
                if (foundPosts != false) {
                  return ListView.builder(
                    itemCount: filteredPosts!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SearchResult(
                                        index: index,
                                        searchResults: filteredPosts!,
                                        //Passes the new list to the SearchResult widget along with the index of the post
                                      )));
                        },
                        child: SearchCard(
                          memoryImage: filteredPosts![index][6],
                          imageSelector: filteredPosts![index][7],
                          postTitle: filteredPosts![index][0],
                          imageURL: filteredPosts![index][2],
                          viewIndex: index,
                          searchResults:
                              filteredPosts!, //Passes the new list to the SearchCard
                          //widget
                        ),
                      );
                    },
                  );
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 24.0),
                    child: Text(
                      'No Posts Found',
                      style: TextStyle(fontSize: .0),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
