import 'package:flutter/material.dart';
import 'package:wlv_blog/screens/home_page.dart';
import 'package:wlv_blog/utils/reusable_button.dart';
import 'package:wlv_blog/screens/multi_delete.dart';

class DeleteDialog extends StatelessWidget {
  int deleteAt;
  DeleteDialog({
    super.key,
    required this.deleteAt,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
      backgroundColor: Colors.grey[800],
      content: Container(
        height: 100,
        width: 500,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            NewButton(
                buttonName: 'Delete',
                onPressed: () {
                  deleteSinglePost(deleteAt);
                  Navigator.of(context).pop();
                }),
            const SizedBox(
              width: 5,
            ),
            NewButton(
                buttonName: 'Delete Multiple',
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DeleteMultiple()));
                }),
          ],
        ),
      ),
    );
  }
}
