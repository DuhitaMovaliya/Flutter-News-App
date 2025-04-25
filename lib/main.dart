import 'package:flutter/material.dart';
import 'package:task1/news.dart';
void main(){
  WidgetsFlutterBinding.ensureInitialized();
runApp(MaterialApp(
  title: "App",
home: news(),
initialRoute: "news",
routes: {
  "news":(context)=>news()

},

));

}