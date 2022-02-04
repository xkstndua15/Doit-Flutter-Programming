import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HttpApp(),
    );
  }
}

class HttpApp extends StatefulWidget {
  const HttpApp({Key? key}) : super(key: key);

  @override
  _HttpAppState createState() => _HttpAppState();
}

class _HttpAppState extends State<HttpApp> {
  String result = '';
  List? data;
  TextEditingController? _editingController;
  ScrollController? _scrollController;
  int page = 1;

  @override
  void initState() {
    super.initState();
    data = List.empty(growable: true);
    _editingController = TextEditingController();
    _scrollController = ScrollController();

    _scrollController!.addListener(() {
      if (_scrollController!.offset >=
              _scrollController!.position.maxScrollExtent &&
          !_scrollController!.position.outOfRange) {
        page++;
        getJSONData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: TextField(
        controller: _editingController,
        style: const TextStyle(color: Colors.white),
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(hintText: '검색어를 입력하세요'),
      )),
      body: SizedBox(
        child: Center(
            child: data!.isEmpty
                ? const Text(
                    '데이터가 없습니다',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  )
                : ListView.builder(
                    itemBuilder: (context, index) {
                      if (data![index]['sale_price'] > 0) {
                        if (data?[index]['thumbnail'].toString() == "") {
                          data?[index]['thumbnail'] = null;
                        }
                        return Card(
                          child: SizedBox(
                            child: Column(
                              children: <Widget>[
                                Text(data![index]['title'].toString()),
                                Text(data![index]['authors'].toString()),
                                Text(data![index]['sale_price'].toString()),
                                Image.network(
                                  data?[index]['thumbnail'] ??
                                      'http://folo.co.kr/img/gm_noimage.png',
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.contain,
                                )
                              ],
                            ),
                          ),
                        );
                      } else
                        // ignore: curly_braces_in_flow_control_structures
                        return Card(
                          child: SizedBox(
                            child: Column(
                              children: <Widget>[
                                Text(data![index]['title'].toString()),
                                Text(data![index]['authors'].toString()),
                                const Text('단종된 책입니다'),
                              ],
                            ),
                          ),
                        );
                    },
                    itemCount: data!.length,
                    controller: _scrollController,
                  )),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          page = 1;
          data!.clear();
          getJSONData();
        },
        child: const Icon(Icons.file_download),
      ),
    );
  }

  Future<String> getJSONData() async {
    var url =
        'https://dapi.kakao.com/v3/search/book?target=title&page=$page&query=${_editingController!.value.text}';
    var response = await http.get(Uri.parse(url),
        headers: {"Authorization": "KakaoAK a58d7dded6ba72ce5b908b0e0a6102ec"});
    setState(() {
      var dataConvertToJSON = json.decode(response.body);
      List result = dataConvertToJSON['documents'];
      data!.addAll(result);
    });

    return response.body;
  }
}
