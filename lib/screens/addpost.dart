import 'dart:typed_data';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flyin/controllers/authcontroller.dart';
import 'package:flyin/controllers/locationController.dart';
import 'package:flyin/controllers/postController.dart';
import 'package:flyin/models/post.dart';
import 'package:flyin/screens/feedScreen.dart';
import 'package:flyin/screens/home.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';
import '../controllers/storageController.dart';


class AddPostScreen extends StatefulWidget {
  const AddPostScreen({super.key});

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  final PostController _postController = Get.find();
  var _file;
  bool isloading = false;
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  String username = PhoneAuthController.useralldata['username'];

  pickvideo(ImageSource source) async {
    ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickVideo(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No video Selected');
  }

  _selectVideo(BuildContext parentContext) async {
    return showDialog(
      context: parentContext,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Create a post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: Text('Take a Video'),
              onPressed: () async {
                Navigator.pop(context);
                Uint8List file = await pickvideo(ImageSource.camera);

                setState(() {
                  _file = file;
                });
              },
            ),
            SimpleDialogOption(
                padding: const EdgeInsets.all(20),
                child: const Text('Choose from Gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await pickvideo(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                }),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  // void postVideo(String uid, String username) async {
  //   setState(() {
  //     isloading = true;
  //   });
  //   try {
  //     String res = await firestoreMethods().uploadPost(
  //         _descriptionController.text,
  //         uid,
  //         username,
  //         PhoneAuthController.useralldata['photoUrl'],
  //         _categoryController.text,
  //         _titleController.text,
  //         postUrl);
  //   } catch (e) {}
  // }

  void clear() {
    setState(() {
      _file = null;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    _titleController.dispose();
  }

  // final path='files/${_file}';

  @override
  Widget build(BuildContext context) {
    //final UserProvider userProvider = Provider.of<UserProvider>(context);

    //final photoUrl = userProvider.getUser.photoUrl!;

    return _file == null
        ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Center(
              child: IconButton(
                onPressed: () {
                  _selectVideo(context);
                },
                icon: Icon(
                  Icons.add_a_photo_outlined,
                  size: 35,
                ),
              ),
            ),
            SizedBox(height: 10, width: 10),
            RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: "Add video",
                style: TextStyle(color: Colors.black54, fontSize: 25),
              ),
            ),
          ])
        : Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.greenAccent,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: clear,
              ),
              title: const Text(
                'Post to',
              ),
              centerTitle: false,
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    String posturl = await StorageMethods()
                        .uploadVideoToStrorage('Posts', _file);
                    String postid = Uuid().v1();
                    Post postData = Post(
                        title: _titleController.text,
                        category: _categoryController.text,
                        location: _locationController.text,
                        description: _descriptionController.text,
                        uid: PhoneAuthController.useralldata['uId'],
                        username: username,
                        postId: postid,
                        datePublished: DateTime.now(),
                        postUrl: posturl,
                        profImage: PhoneAuthController.useralldata['photoUrl']);
                    clear();
                    _postController.createPost(postData, homeScreen(),postid);

                    Get.snackbar('Posted', 'video Uploaded Successfully');
                  },
                  child: const Text(
                    "Post",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )
              ],
            ),
            // POST FORM
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  isloading
                      ? const LinearProgressIndicator()
                      : const Padding(padding: EdgeInsets.only(top: 0.0)),
                  const Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                            PhoneAuthController.useralldata['photoUrl'],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 200.0,
                        width: 200.0,
                        child: Container(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                  const Divider(),
                  Container(
                    height: 55,
                    width: 200,
                    decoration: BoxDecoration(
                        border: Border.all(width: 1, color: Colors.grey),
                        borderRadius: BorderRadius.circular(10)),
                    child: Expanded(
                      child: TextFormField(
                        autofocus: true,
                        maxLines: 1,
                        onSaved: (newValue) {
                          _titleController.text = newValue!;
                        },
                        textAlign: TextAlign.center,
                        controller: _titleController,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Give a title...",
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Text(
                    '${_locationController.text}',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  ElevatedButton(
                    onPressed: () async {
                      _locationController.text =
                          await LocationMethods().getLocation();
                      setState(() {
                        _locationController.text;
                      });
                    },
                    child: const Text('Get Location'),
                  ),
                  const Divider(),
                  Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Expanded(
                      child: TextFormField(
                        autofocus: true,
                        maxLines: 8,
                        textAlign: TextAlign.center,
                        controller: _descriptionController,
                        onSaved: (value) {
                          _descriptionController.text = value!;
                        },
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "write a description...",
                        ),
                      ),
                    ),
                  ),
                  const Divider(),
                  Container(
                    height: 55,
                    width: 300,
                    decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      maxLines: 1,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      controller: _categoryController,
                      onSaved: (value) {
                        _categoryController.text = value!;
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Category",
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            ),
          );
    ;
  }
}
