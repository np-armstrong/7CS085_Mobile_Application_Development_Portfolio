import 'package:flutter/material.dart';
import 'package:wlv_blog/screens/home_page.dart';
import 'package:wlv_blog/utils/alert_dialog.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:wlv_blog/utils/reusable_button.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

var _blogBox = Hive.box('blogBox');
TextEditingController newPostTitle = TextEditingController();
TextEditingController newPostBody = TextEditingController();
bool validatePost(String titleCheck, String bodyCheck) {
  bool validEntry;
  titleCheck = titleCheck.replaceAll(
      ' ', ''); //Takes the values from the string and removes all spaces
  bodyCheck = bodyCheck.replaceAll(' ', '');
  if (titleCheck.length > 0 && bodyCheck.length > 0) {
    //this then checks the strings minus spaces. If nothing is entered, validEntry is set to false
    validEntry = true;
  } else {
    validEntry = false;
  }
  return validEntry;
}

String? postDate;
String whenPosted() {
  var postDay = DateTime.now().day.toString();
  var postMonth = DateTime.now().month.toString();
  var postYear = DateTime.now().year.toString();
  var whenPosted = 'Posted on: ${postDay}-${postMonth}-${postYear}';
  return whenPosted;
}

String defaultImage = 'assets/flutter.jpeg';

class _CreatePostState extends State<CreatePost> {
  Uint8List?
      imageBytes; //Hive can store Uint8List datatype, therefore we will convert images to this datatype
  bool imageSelected = false;
  File? file;

  uploadFromGallery() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    File pickedImage =
        File(selectedImage!.path); //Gets the path of the picked image
    //and stores it as a temporary file in the pickedImage variable
    imageBytes = await pickedImage.readAsBytesSync(); //This converts it to a
    //Uint8List data type which is compatible with the Hive database and allows
    //us to retrieve the image by accessing this data via our saved list
    setState(() {
      //We use a set state method to affect what is shown as the post image
      //The bool is used to toggle between the default image and the uploaded
      //image. if imageSelected is true, the selected image will be displayed to the user
      imageSelected = true;
      //The 'file' variable holds the XFile image in a temporary location
      //To show the user what is selected. When saved, this is converted to
      //Uint8List and stored in our list which is saved to the box for retrieval
      //later
      file = pickedImage;
    });
  }

//A repeat of the above function, but with the image source set as camera
  takePicture() async {
    XFile? selectedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    File image = File(selectedImage!.path);
    imageBytes = await image.readAsBytesSync();
    setState(() {
      imageSelected = true;
      file = image;
    });
  }

  //This function checks for a Uint8List value in the imageBytes variable
  //this sets the upload checker variable in the blogPost list so the rest of the app knows whether there is a
  //user uploaded image to display
  bool checkForImage() {
    if (imageBytes != null) {
      return true;
    } else {
      return false;
    }
  }

  //This function stores all of the inputted information into the blogPosts list then updates the hive box with the changes to the list
  bool? uploadChecker;
  void savePost() {
    blogPosts.add([
      newPostTitle.text, //0
      newPostBody.text, //1
      "assets/flutter.jpeg", //2
      false, //3
      '', //4
      postDate = whenPosted(), //5
      imageBytes, //6
      uploadChecker = checkForImage(), //7
      '' //8
    ]);
    _blogBox.put('blogBox', blogPosts); //updates the box
  }

  /* An explanation of the blank string values: I had some runtime issues when
  * accessing certain values in other parts of the app and padding out the list
  * objects seemed to fix the issue.
  * Future considerations for future builds will be to use a key:value map
  * rather than a dynamic list. I had a lot of features working by the point of
  * realisation so adapted the current model to ensure timely completion of
  * the project.
  * */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Post'),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0),
            child: IconButton(
              icon: Row(
                children: [Icon(Icons.save_outlined)],
              ),
              onPressed: () {
                //Calls validator function and stores validation return value in variable
                var validEntry =
                    validatePost(newPostTitle.text, newPostBody.text);
                //Checks variable. if true, post will save, if false, alert shown
                if (validEntry == false) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return PopUpAlert(
                          alertText:
                              'The post title and body can not be left blank. ',
                        );
                      });
                } else {
                  savePost();
                  //TODO: List view builder not updating when this is clicked.
                  notifier
                      .notifyListeners(); //Added the notifyListeners method to resolve this
                  //TODO: When clicking create post, values still present, add methods to reset controllers
                  //the below .clear() methods reset the create post textfields
                  //for the next 'new post'
                  newPostTitle.clear();
                  newPostBody.clear();
                  Navigator.of(context)
                      .pop(); //Navigates to back to the root screen
                }
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: newPostTitle,
                maxLines: 1,
                decoration: InputDecoration(
                  hintText: 'Add a title here..',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  'Select an Image',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NewButton(
                      buttonName: 'From Gallery',
                      onPressed: () {
                        setState(() {
                          uploadFromGallery();
                        });
                      }),
                  NewButton(
                      buttonName: 'From Camera',
                      onPressed: () {
                        setState(() {
                          takePicture();
                        });
                      })
                ],
              ),
            ),
            Container(
              height: 300,
              decoration: BoxDecoration(
                //If imageSelected is false, the default asset image will be displayed.
                image: imageSelected == false
                    ? DecorationImage(
                        image: AssetImage(
                            defaultImage)) //This is a default image displayed if a user does not select an image.
                    //Else the temporary file image is displayed.
                    : DecorationImage(
                        image: FileImage(
                            file!)), //This displays the selected image from its temporary location in the file variable if imageSelected == true.
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                maxLines: null, //As this is a body of text, the number of lines
                //is unlimited
                controller: newPostBody,
                decoration: InputDecoration(
                  hintText: 'Type blog post here...',
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
