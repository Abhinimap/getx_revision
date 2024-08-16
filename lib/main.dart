import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:getx_revision/bindings/apple_binding.dart';
import 'package:getx_revision/bindings/global_binding.dart';
import 'package:getx_revision/bindings/tech_crunch_binding.dart';
import 'package:getx_revision/presentation/anotherpage.dart';
import 'package:getx_revision/presentation/home.dart';
import 'package:getx_revision/presentation/next_page.dart';

void main() async{
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
     getPages: [
       GetPage(name: '/', page:()=> HomePage(),binding: GlobalBinding()),
       GetPage(name: '/homepage', page: ()=>HomePage(),binding: GlobalBinding()),
       GetPage(name: '/nextpage', page: ()=>NextPage(),binding: AppleControllerBinding()),
       GetPage(name: '/anotherpage', page: ()=>AnotherPage(),binding: TechCrunchBinding()),
     ],
      home: HomePage(),
    );
  }
}

