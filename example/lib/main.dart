import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_in_text/image_in_text.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await init("assets/Roboto-Regular.ttf", isAsset: true);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        width: MediaQuery.of(context).size.width-MediaQuery.of(context).padding.horizontal,
        height: MediaQuery.of(context).size.height,
        child: FittedBox(
          fit: BoxFit.cover,
          child: ImageInText(
            text: "LAZY",
            boxFit: BoxFit.contain,
            image:  AssetImage(
                "assets/bg.jpg"
            ),
          ),
        ),
      ),
    );
  }
}
