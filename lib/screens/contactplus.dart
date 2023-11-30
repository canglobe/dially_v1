// ignore_for_file: prefer_const_constructors

import 'dart:io' as Io;

import 'package:diali/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image/image.dart' as img;

import '../boxes.dart';
import '../model/db.dart';

class NewAddScreen extends StatefulWidget {
  const NewAddScreen({super.key});

  @override
  State<NewAddScreen> createState() => _NewAddScreenState();
}

class _NewAddScreenState extends State<NewAddScreen> {
  final namecontroller = TextEditingController();
  final numbercontroller = TextEditingController();

  Io.File? image;
  String? error;

  @override
  void initState() {
    super.initState();
  }

  void _doneMethod() {
    var name = namecontroller.text;
    var number = numbercontroller.text;
    if (number.isEmpty) {
      setState(() {
        error = 'Mobile Number Was Not Entered.';
      });
    } else if (image != null) {
      _copyImage(name);
      addPage(
        image!.path,
        name.trim(),
        int.parse(number.trim()),
      );
      popout();
    } else {
      setState(() {
        error = 'Image Was Not Selected';
      });
    }
  }

  // Pick the Image from Local Storage in Device
  Future pickImage() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (img == null) return;

      final imageTemp = Io.File(img.path);
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Pick the Image From Device Camera
  Future pickCamera() async {
    try {
      final img = await ImagePicker().pickImage(source: ImageSource.camera);
      if (img == null) return;

      final imageTemp = Io.File(img.path);
      setState(() => image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  // Copy image for resize
  Future<void> _copyImage(name) async {
    final directory = await getExternalStorageDirectory();
    final imagePath = '${directory!.path}/$name.jpg';
    final resizedImage = await _resizeImage(image!, 360, 360);
    final newImage = await resizedImage.copy(imagePath);
    setState(() {
      image = newImage;
    });
  }

  // This is Image Resize Class
  Future<Io.File> _resizeImage(Io.File file, int width, int height) async {
    final imageBytes = await file.readAsBytes();
    final originalImage = img.decodeImage(imageBytes);
    final resizedImage =
        img.copyResize(originalImage!, width: width, height: height);
    final directory = await getTemporaryDirectory();
    final targetPath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
    final resizedFile = Io.File(targetPath)
      ..writeAsBytesSync(img.encodeJpg(resizedImage));
    return resizedFile;
  }

  // Add the Contact in Hive Object
  addPage(
    String imagepath,
    String name,
    int phonenumber,
  ) {
    final contacts = Db(
      imagepath: imagepath,
      name: name,
      number: phonenumber,
    );

    final box = Boxes.getContacts();
    box.add(contacts);
  }

  popout() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var dheight = MediaQuery.of(context).size.height;
    var dWidget = MediaQuery.of(context).size.width;
    final Brightness brightness = CupertinoTheme.brightnessOf(context);
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            // backgroundColor: CupertinoColors.systemYellow,
            border: Border(
              bottom: BorderSide(
                color: brightness == Brightness.light
                    ? CupertinoColors.black
                    : CupertinoColors.white,
              ),
            ),
            // The middle widget is visible in both collapsed and expanded states.
            // middle: const Text('Add new contact'),
            // When the "middle" parameter is implemented, the largest title is only visible
            // when the CupertinoSliverNavigationBar is fully expanded.
            largeTitle: Text(
              'New contact',
              style: TextStyle(
                color: pmcolor,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SliverFillRemaining(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Divider(),
                  imageSelection(dheight, dWidget),
                  Divider(),
                  inputFields(),
                  error != null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Divider(),
                            Text(
                              error!,
                              style: TextStyle(
                                  color: CupertinoColors.destructiveRed),
                            ),
                          ],
                        )
                      : Text(''),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: saveButton(),
                  ),
                  Divider()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding imageSelection(double dheight, double dWidget) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          image != null
              ? SizedBox(
                  height: dheight / 4,
                  width: dWidget / 1.5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                    child: Image.file(
                      Io.File(image!.path),
                      fit: BoxFit.fill,
                    ),
                  ))
              : SizedBox(
                  height: dheight / 4,
                  // width: dWidget / 2,
                  child: Center(
                    child: Icon(
                      CupertinoIcons.photo,
                      size: 75,
                    ),
                  ),
                ),
          Divider(),
          // imagepicker
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  CupertinoButton(
                      child: Icon(CupertinoIcons.photo),
                      onPressed: () {
                        pickImage();
                        setState(() {
                          error = '';
                        });
                      }),
                  textt(
                    'Gallery',
                    pmcolor,
                    size: '16',
                  ),
                ],
              ),
              SizedBox(
                width: 135,
              ),
              Column(
                children: [
                  CupertinoButton(
                      child: Icon(CupertinoIcons.photo_camera),
                      onPressed: () {
                        pickCamera();
                        setState(() {
                          error = '';
                        });
                      }),
                  textt(
                    'Camera',
                    pmcolor,
                    size: '16',
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Padding inputFields() {
    return Padding(
      padding: const EdgeInsets.only(
        left: 30,
        right: 30,
        top: 15,
        bottom: 15,
      ),
      child: Column(
        children: [
          SizedBox(
            // height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Name'),
                textt('Name', pmcolor),
                SizedBox(
                  height: 3,
                ),
                CupertinoTextField(
                    prefix: Icon(CupertinoIcons.person),
                    controller: namecontroller,
                    placeholder: "Name",
                    keyboardType: TextInputType.name,
                    onTap: () {
                      setState(() {
                        error = '';
                      });
                    }),
              ],
            ),
          ),

          //
          SizedBox(
            height: 10,
          ),

          SizedBox(
            // height: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text('Mobile *'),
                textt('Mobile *', pmcolor),
                SizedBox(
                  height: 3,
                ),
                CupertinoTextField(
                  prefix: Icon(CupertinoIcons.phone),
                  controller: numbercontroller,
                  placeholder: "Mobile Number",
                  keyboardType: TextInputType.phone,
                  maxLength: 14,
                  onTap: () {
                    setState(() {
                      error = '';
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  CupertinoButton saveButton() {
    return CupertinoButton.filled(onPressed: _doneMethod, child: Text("Save"));
  }
}
