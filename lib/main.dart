import 'package:diali/model/db.dart';
import 'package:diali/splash.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(DbAdapter());
  await Hive.openBox<Db>("contacts");
  await Hive.openBox("values");

  runApp(const IosDial());
}

class IosDial extends StatefulWidget {
  const IosDial({super.key});

  @override
  State<IosDial> createState() => _IosDialState();
}

class _IosDialState extends State<IosDial> {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          brightness: Brightness.light,
          primaryColor: Color.fromARGB(255, 76, 176, 80),
          barBackgroundColor: Color.fromARGB(255, 242, 241, 246),
          scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255)),
      home: Splash(),
    );
  }
}
