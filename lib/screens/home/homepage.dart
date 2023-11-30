import 'dart:io';

import 'package:diali/screens/contactplus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../boxes.dart';
import '../../constants.dart';
import '../../model/db.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final namecontroller = TextEditingController();
  final numbercontroller = TextEditingController();
  int? grid;

  getHive() {
    Box box = Boxes.getValues();
    int gridvalue = box.get('gridvalue') ?? 3;
    setState(() {
      grid = gridvalue;
    });
  }

  makephonecall(number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  void initState() {
    // get grid value
    getHive();
    super.initState();
  }

  navToNewContactScreen() {
    Navigator.push(
      context,
      CupertinoPageRoute<Widget>(
        builder: (BuildContext context) {
          return const NewAddScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      // A ScrollView that creates custom scroll effects using slivers.
      child: CustomScrollView(
        // A list of sliver widgets.
        slivers: <Widget>[
          CupertinoSliverNavigationBar(
            leading: Padding(
              padding: const EdgeInsets.only(top: 3, bottom: 3),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(9),
                  ),
                  child: Image.asset('assets/app_store_icon.png')),
            ),
            // This title is visible in both collapsed and expanded states.
            // When the "middle" parameter is omitted, the widget provided
            // in the "largeTitle" parameter is used instead in the collapsed state.
            largeTitle: Text(
              'Contacts',
              style: TextStyle(
                color: pmcolor,
                fontFamily: 'Comfortaa',
                fontWeight: FontWeight.bold,
              ),
            ),

            trailing: GestureDetector(
                onTap: navToNewContactScreen,
                child: const Icon(CupertinoIcons.add)),
          ),
          // This widget fills the remaining space in the viewport.
          // Drag the scrollable area to collapse the CupertinoSliverNavigationBar.
          SliverFillRemaining(
              fillOverscroll: true,
              child: ValueListenableBuilder<Box<Db>>(
                  valueListenable: Boxes.getContacts().listenable(),
                  builder: (context, box, _) {
                    final contacts = box.values.toList().cast<Db>();
                    return buildContent(contacts);
                  })),
        ],
      ),
    );
  }

  Widget buildContent(List<Db> contacts) {
    //
    var dheight = MediaQuery.of(context).size.height;
    var dwidth = MediaQuery.of(context).size.width;
    if (contacts.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 145),
            child: Image.asset('assets/arrow.png'),
          ),
          SizedBox(
            height: 90,
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              'Please click + sympol to add new contacts',
              style: TextStyle(
                fontSize: 24,
                fontFamily: 'SF Pro Display',
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Divider(),
        ],
      );
      //
    } else {
      // if contacts have data so return this widget.
      return Column(
        children: [
          // const Padding(
          //   padding: EdgeInsets.all(5),
          //   child: CupertinoSearchTextField(),
          // ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(5),
              itemCount: contacts.length,
              itemBuilder: (BuildContext context, int index) {
                var contact = contacts[index];

                return GestureDetector(
                  onTap: () {
                    makephonecall(contact.number.toString());
                  },
                  onLongPress: () {
                    _showActionSheet(context, contact, index);
                  },
                  child: SizedBox(
                    width: dwidth / 0.25,
                    height: dheight / 6,
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(9),
                        ),
                        child: Image.file(
                          File(contact.imagepath),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
            ),
          ),
        ],
      );
    }
  }

  void _showActionSheet(BuildContext context, Db contact, index) {
    namecontroller.text = contact.name;
    numbercontroller.text = contact.number.toString();
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: CupertinoActionSheet(
          title: const Text('Modify'),
          message: const Text('Any Changes You Made It Here'),
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {},
              child: SizedBox(
                // height: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name'),
                    CupertinoTextField(
                      prefix: Icon(CupertinoIcons.person),
                      controller: namecontroller,
                      placeholder: "Enter Name Here",
                      keyboardType: TextInputType.name,
                    ),
                  ],
                ),
              ),
            ),
            CupertinoActionSheetAction(
              onPressed: () {},
              child: SizedBox(
                // height: 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Mobile'),
                    CupertinoTextField(
                      prefix: Icon(CupertinoIcons.phone),
                      controller: numbercontroller,
                      placeholder: "Enter Mobile Number Here",
                      keyboardType: TextInputType.phone,
                      maxLength: 14,
                    ),
                  ],
                ),
              ),
            ),
            CupertinoDialogAction(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CupertinoButton(
                    child: textt('Delete', CupertinoColors.destructiveRed),
                    onPressed: () {
                      // deleteContacts(contact);
                      Navigator.pop(context);
                      _showAlertDialog(context, contact);
                    }),
                CupertinoButton(
                    child: textt('Update', CupertinoColors.systemGreen),
                    onPressed: () {
                      editContacts(
                          contact,
                          contact.imagepath,
                          namecontroller.text.trim(),
                          int.parse(numbercontroller.text.trim()));
                      Navigator.pop(context);
                    })
              ],
            )),
          ],
        ),
      ),
    );
  }

  void _showAlertDialog(BuildContext context, contact) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: const Text('Alert'),
        content: const Text('Please confirm this contact to delete?'),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          CupertinoDialogAction(
            /// This parameter indicates the action would perform
            /// a destructive action such as deletion, and turns
            /// the action's text color to red.
            isDestructiveAction: true,
            onPressed: () {
              deleteContacts(contact);
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }

  void editContacts(
    Db contact,
    String imagepath,
    String name,
    int phonenumber,
  ) {
    contact.name = name;
    contact.number = phonenumber;

    contact.save();
  }

  void deleteContacts(Db contact) {
    contact.delete();
  }
}
