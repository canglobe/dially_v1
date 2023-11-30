// // ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

// import 'dart:io';

// import 'package:diali/boxes.dart';
// import 'package:diali/constants.dart';
// import 'package:diali/model/db.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

// class HomePage extends StatefulWidget {
//   HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   TextEditingController namecontroller = TextEditingController();
//   TextEditingController numbercontroller = TextEditingController();
//   int? grid;

//   getHive() {
//     Box box = Boxes.getValues();
//     int gridvalue = box.get('gridvalue') ?? 3;
//     setState(() {
//       grid = gridvalue;
//     });
//   }

//   makephonecall(number) async {
//     await FlutterPhoneDirectCaller.callNumber(number);
//   }

//   @override
//   void initState() {
//     getHive();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoPageScaffold(
//         child: ValueListenableBuilder<Box<Db>>(
//             valueListenable: Boxes.getContacts().listenable(),
//             builder: (context, box, _) {
//               final contacts = box.values.toList().cast<Db>();
//               return buildContent(contacts);
//             }));
//   }

//   Widget buildContent(List<Db> contacts) {
//     //
//     var dheight = MediaQuery.of(context).size.height;
//     var dwidth = MediaQuery.of(context).size.width;
//     if (contacts.isEmpty) {
//       // if contacts were empty so return this widget.
//       return const Center(
//         child: Text(
//           'Not yet contacts!',
//           style: TextStyle(fontSize: 24),
//         ),
//       );
//       //
//     } else {
//       // if contacts have data so return this widget.
//       return SafeArea(
//         child: Column(
//           children: [
//             //
//             const Divider(),
//             Padding(
//               padding: const EdgeInsets.all(5),
//               child: const CupertinoSearchTextField(),
//             ),
//             //
//             Expanded(
//               child: GridView.builder(
//                 padding: const EdgeInsets.all(5),
//                 itemCount: contacts.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   var contact = contacts[index];

//                   return GestureDetector(
//                     onTap: () {
//                       makephonecall(contact.number.toString());
//                     },
//                     onLongPress: () {
//                       _showActionSheet(context, contact, index);
//                     },
//                     child: SizedBox(
//                       width: dwidth / 0.25,
//                       height: dheight / 6,
//                       child: Padding(
//                         padding: const EdgeInsets.all(5),
//                         child: ClipRRect(
//                           borderRadius: const BorderRadius.all(
//                             Radius.circular(15),
//                           ),
//                           child: Image.file(
//                             File(contact.imagepath),
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount: 2),
//               ),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   void _showActionSheet(BuildContext context, Db contact, index) {
//     namecontroller.text = contact.name;
//     numbercontroller.text = contact.number.toString();
//     showCupertinoModalPopup<void>(
//       context: context,
//       builder: (BuildContext context) => Padding(
//         padding:
//             EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: CupertinoActionSheet(
//           title: const Text('Edit'),
//           message: const Text('Enter Correct Information'),
//           actions: [
//             CupertinoActionSheetAction(
//               onPressed: () {},
//               child: CupertinoTextField(
//                 prefix: Text("Name       "),
//                 controller: namecontroller,
//                 placeholder: "Enter Name Here",
//                 keyboardType: TextInputType.name,
//               ),
//             ),
//             CupertinoActionSheetAction(
//               onPressed: () {},
//               child: CupertinoTextField(
//                 prefix: Text(" Mobile    "),
//                 controller: numbercontroller,
//                 placeholder: "Enter Mobile Number Here",
//                 keyboardType: TextInputType.phone,
//               ),
//             ),
//             CupertinoDialogAction(
//                 child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 CupertinoButton.filled(
//                     child:
//                         textt('Delete', '19', CupertinoColors.destructiveRed),
//                     onPressed: () {
//                       deleteContacts(contact);
//                       Navigator.pop(context);
//                     }),
//                 CupertinoButton.filled(
//                     child: textt('Update', '19', CupertinoColors.systemGreen),
//                     onPressed: () {
//                       editContacts(
//                           contact,
//                           contact.imagepath,
//                           namecontroller.text.trim(),
//                           int.parse(numbercontroller.text.trim()));
//                       Navigator.pop(context);
//                     })
//               ],
//             )),
//           ],
//         ),
//       ),
//     );
//   }

//   void editContacts(
//     Db contact,
//     String imagepath,
//     String name,
//     int phonenumber,
//   ) {
//     contact.name = name;
//     contact.number = phonenumber;

//     contact.save();
//   }

//   void deleteContacts(Db contact) {
//     contact.delete();
//   }
// }
