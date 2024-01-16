import 'package:flutter/material.dart';

class SearchResult extends StatefulWidget {
  final int index;
  final List searchResults;
  SearchResult({super.key, required this.index, required this.searchResults});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.searchResults[widget.index][0])),
      body: ListView(
        children: [
          //Title
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              widget.searchResults[widget.index][0],
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
          //Date
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
            child: Text(
              widget.searchResults[widget.index][5],
              style: const TextStyle(fontSize: 12),
            ),
          ),
          //Image
          Container(
              child: widget.searchResults[widget.index][7] ==
                      true //Operator checks to see if a Uint8List is stored in the list object
                  ? Image(
                      image: MemoryImage(widget.searchResults[widget.index][6]),
                    )
                  : Image(
                      image: AssetImage(widget.searchResults[widget.index][2]),
                    )),
          //body
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
            child: Text(
              widget.searchResults[widget.index][1],
              style: const TextStyle(fontSize: 16),
            ),
          )
        ],
      ),
    );
  }
}
