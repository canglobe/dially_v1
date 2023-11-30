// // ignore_for_file: prefer_const_constructors, library_prefixes, unused_local_variable, avoid_print

// import 'dart:io' as Io;

// import 'package:diali/boxes.dart';
// import 'package:diali/constants.dart';
// import 'package:diali/model/db.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import 'package:image/image.dart' as img;
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';

// //------------------------------------------------------------------------------//
// class AddPage extends StatefulWidget {
//   const AddPage({super.key});

//   @override
//   State<AddPage> createState() => _AddPageState();
// }

// class _AddPageState extends State<AddPage> {
//   final namecontroller = TextEditingController();
//   final numbercontroller = TextEditingController();

//   Io.File? image;
//   String? error;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var dheight = MediaQuery.of(context).size.height;
//     var dWidget = MediaQuery.of(context).size.width;

//     return CupertinoPageScaffold(
//       navigationBar: CupertinoNavigationBar(
//         backgroundColor: CupertinoColors.activeBlue,
//         middle: textt('Add Contact', '19', textcolor),
//       ),
//       child: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               image != null
//                   ? Padding(
//                       padding: const EdgeInsets.only(
//                         top: 12,
//                         bottom: 12,
//                       ),
//                       child: Image.file(Io.File(image!.path)),
//                     )
//                   : SizedBox(
//                       height: dheight / 3,
//                       child: Icon(
//                         CupertinoIcons.person_alt,
//                         size: 225,
//                       ),
//                     ),
//               //--------------------------------------------------------------
//               // Divider(),
//               // Column(
//               //   children: [
//               //     CupertinoButton.filled(
//               //         child: textt('GALLERY', '16'),
//               //         onPressed: () {
//               //           pickImage();
//               //         }),
//               //     SizedBox(
//               //       height: 5,
//               //     ),
//               //     CupertinoButton.filled(
//               //         child: textt('CAMERA', '16'),
//               //         onPressed: () {
//               //           // pickImage();
//               //           pickCamera();
//               //         }),
//               //   ],
//               // ),
//               // SizedBox(
//               //   height: 23,
//               // ),
//               //--------------------------------------------------------------
//               Divider(),
//               SizedBox(
//                 height: 2.5,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 9, right: 9),
//                 child: CupertinoTextField(
//                   prefix: Text(" NAME       "),
//                   controller: namecontroller,
//                   placeholder: "Enter Name Here",
//                   keyboardType: TextInputType.name,
//                 ),
//               ),

//               //------------------------------------------------------------
//               Divider(),
//               Padding(
//                 padding: const EdgeInsets.only(left: 9, right: 9),
//                 child: CupertinoTextField(
//                   prefix: Text(" MOBILE    "),
//                   controller: numbercontroller,
//                   placeholder: "Enter Mobile Number Here",
//                   keyboardType: TextInputType.phone,
//                   maxLength: 14,
//                 ),
//               ),
//               SizedBox(
//                 height: 2.5,
//               ),
//               Divider(),
//               //-----------------------------------------------------------
//               SizedBox(
//                 height: 45,
//               ),
//               //---------------------------------------------------------------

//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CupertinoButton.filled(
//                       child: textt('GALLERY', '9', textcolor),
//                       onPressed: () {
//                         pickImage();
//                       }),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   CupertinoButton.filled(
//                       child: textt('CAMERA', '9', textcolor),
//                       onPressed: () {
//                         // pickImage();
//                         pickCamera();
//                       }),
//                 ],
//               ),
//               SizedBox(
//                 height: 23,
//               ),
//               error != null ? textt(error!, '23', textcolor) : Text(''),
//               Padding(
//                 padding: const EdgeInsets.all(9),
//                 child: CupertinoButton.filled(
//                     onPressed: _doneMethod, child: Text("  DONE  ")),
//               ),
//               SizedBox(
//                 height: 50,
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _doneMethod() {
//     var name = namecontroller.text.trim();
//     var number = numbercontroller.text.trim();
//     if (name.isEmpty) {
//       setState(() {
//         error = 'Name Was Empty';
//       });
//     } else if (number.isEmpty) {
//       setState(() {
//         error = 'Phone Number Was Empty';
//       });
//     } else if (image != null) {
//       _copyImage(name);
//       addPage(
//         image!.path,
//         namecontroller.text.trim(),
//         int.parse(numbercontroller.text.trim()),
//       );
//       popout();
//     } else {
//       error = 'Image Was Not Selected';
//     }
//   }

//   // Pick the Image from Local Storage in Device
//   Future pickImage() async {
//     try {
//       final img = await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (img == null) return;

//       final imageTemp = Io.File(img.path);
//       setState(() => image = imageTemp);
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   // Pick the Image From Device Camera
//   Future pickCamera() async {
//     try {
//       final img = await ImagePicker().pickImage(source: ImageSource.camera);
//       if (img == null) return;

//       final imageTemp = Io.File(img.path);
//       setState(() => image = imageTemp);
//     } on PlatformException catch (e) {
//       print('Failed to pick image: $e');
//     }
//   }

//   // Copy image for resize
//   Future<void> _copyImage(name) async {
//     final directory = await getExternalStorageDirectory();
//     final imagePath = '${directory!.path}/$name.jpg';
//     final resizedImage = await _resizeImage(image!, 360, 360);
//     final newImage = await resizedImage.copy(imagePath);
//     setState(() {
//       image = newImage;
//     });
//   }

//   // This is Image Resize Class
//   Future<Io.File> _resizeImage(Io.File file, int width, int height) async {
//     final imageBytes = await file.readAsBytes();
//     final originalImage = img.decodeImage(imageBytes);
//     final resizedImage =
//         img.copyResize(originalImage!, width: width, height: height);
//     final directory = await getTemporaryDirectory();
//     final targetPath =
//         '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.jpg';
//     final resizedFile = Io.File(targetPath)
//       ..writeAsBytesSync(img.encodeJpg(resizedImage));
//     return resizedFile;
//   }

//   // Add the Contact in Hive Object
//   addPage(
//     String imagepath,
//     String name,
//     int phonenumber,
//   ) {
//     final contacts = Db(
//       imagepath: imagepath,
//       name: name,
//       number: phonenumber,
//     );

//     final box = Boxes.getContacts();
//     box.add(contacts);
//   }

//   // Finally Add the Contact Popout To Homescreen
//   popout() {
//     //
//     Navigator.of(context)
//         .pushReplacement(CupertinoPageRoute(builder: (context) => Done()));
//   }
// }

// class Done extends StatelessWidget {
//   const Done({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text("Contact Added Successfull.. Go Home Tab"),
//         SizedBox(
//           height: 27,
//         ),
//         CupertinoButton.filled(
//             child: Text('Add New Contact'),
//             onPressed: () {
//               //
//               Navigator.of(context).pushAndRemoveUntil(
//                   CupertinoPageRoute(builder: (context) => AddPage()),
//                   (route) => false);
//             })
//       ],
//     );
//   }
// }
