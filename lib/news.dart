import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:url_launcher/url_launcher.dart';

class news extends StatefulWidget {
  const news({super.key});

  @override
  State<news> createState() => _newsState();
}

class _newsState extends State<news> {

  dynamic fetchnews=[];
bool isloading=true;
@override
  void initState() {
    fetchNews();
   super.initState();
  }
Future<void>fetchNews()async{
       final String token="77e53d938a724c508d1fb81ff977e03d";
   String query='name';   
var url = Uri.https('newsapi.org','/v2/everything',{'q':query});
var response = await http.get(url, headers: {
      'Authorization': 'Bearer $token'});

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var mydata=json.decode(response.body);
      Map<String,dynamic> myMap=json.decode(response.body);
      mydata=myMap['articles'];
      setState(() {
        fetchnews=mydata;
        isloading=false;
      });
}
 Future <void>_launchUrl(String url)async{
  final Uri uri=Uri.parse(url);
                if(!await launchUrl(uri,mode: LaunchMode.externalApplication)){
              
                  throw 'Colud not launch $url';
                }

 }
  @override 
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Fetch News")),
        backgroundColor: Colors.blue,
        ),
        body: isloading
        ?Center(child: CircularProgressIndicator())
        :fetchnews == null
        ?Center(child: Text("No News Details Found"))
        
        :Padding(padding: EdgeInsets.all(16.0),
        
        child:  Column(
          
        children: [
           Expanded( child: ListView.builder(
              itemCount: fetchnews.length,
              itemBuilder: (context,index){
                var item=fetchnews[index];
               // var url=item['url'];
                return GestureDetector(
                  
                  onTap: (){
                    final url=item['url'];
                    if(url.isNotEmpty){
                    _launchUrl(url);}
                    
                  },
                    child: Card(
                          margin: EdgeInsets.all(10),
                          child: Padding(padding: EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                            Image.network(item['urlToImage'],height: 300,width:double.infinity,fit: BoxFit.cover,),
                             Text("Name:-${item['source']['name']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
                             SizedBox(height: 20),
                              Text("Author:-${item['author']}",style: TextStyle(fontSize: 23,fontWeight: FontWeight.bold),),
                              SizedBox(height: 20),
                              Text("Title:-${item['title']}",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                               SizedBox(height: 20),
                              Text("Description:-${item['description']}",style: TextStyle(fontSize: 18)),
                              SizedBox(height: 20),
                              Text("PublishedAt:-${item['publishedAt']}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),),
                            ],
                          ),
                          ),
                        ),
                  );
                

            }))

        ],

          
        ),
        )
    );
      }
}