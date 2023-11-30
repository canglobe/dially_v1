// // ignore_for_file: prefer_const_constructors

// import 'package:diali/constants.dart';
// import 'package:diali/screens/home/homepage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class BasementPage extends StatefulWidget {
//   const BasementPage({super.key});

//   @override
//   State<BasementPage> createState() => _BasementPageState();
// }

// class _BasementPageState extends State<BasementPage> {
//   List<Widget> wids = <Widget>[
//     HomeScreen(),
//   ];

//   @override
//   void initState() {
//     setState(() {});
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return CupertinoTabScaffold(
//         tabBar: CupertinoTabBar(
//           items: const [
//             BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: ''),
//             BottomNavigationBarItem(
//                 icon: Icon(CupertinoIcons.add_circled), label: 'diali'),
//             BottomNavigationBarItem(
//                 icon: Icon(CupertinoIcons.settings), label: ''),
//           ],
//         ),
//         tabBuilder: (context, index) {
//           return CupertinoTabView(
//             builder: (context) => wids[index],
//           );
//         });
//   }
// }
