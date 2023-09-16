import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController? textController = TextEditingController();
  String? image_url1;
  String? image_url2;
  String? image_url3;

  Future<void> getProductInfo() async {
    final uri = Uri.https('www.googleapis.com', '/customsearch/v1', {
      'key': 'AIzaSyDyGRKh8m8eXKN6ySVwh9RTHp6E5rc5xhk',
      'cx': '037367c4aa37345cc',
      'q': '${textController!.text}',
    });

    final response = await http.get(uri);

    final convertedResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        image_url1 = (convertedResponse["items"][0]["pagemap"]["cse_thumbnail"]
            [0]["src"]);
        image_url2 = (convertedResponse["items"][1]["pagemap"]["cse_thumbnail"]
            [0]["src"]);
        image_url3 = (convertedResponse["items"][2]["pagemap"]["cse_thumbnail"]
            [0]["src"]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'KUEHNE NAGEL YEDEK PARÇA',
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: TextField(
                            controller: textController,
                            onChanged: (value) {},
                            decoration: InputDecoration(
                                labelText: "Add Item",
                                hintText: "...",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            autofocus: true,
                            style: TextStyle(fontSize: 20)),
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: FilledButton(
                            onPressed: () {
                              getProductInfo();
                            },
                            child: Text("SEARCH"))),
                  ]),
            ),
          ),
          Expanded(
            flex: 2,
            child: Row(
              children: [
                Expanded(
                  child: Image.network(image_url1.toString()),
                ),
                Expanded(
                  child: Image.network(image_url2.toString()),
                ),
                Expanded(
                  child: Image.network(image_url3.toString()),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
