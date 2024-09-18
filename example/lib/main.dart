import 'package:fast_code/fast_code.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_easyloading/flutter_easyloading.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
    builder: EasyLoading.init(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

enum ClickType {
  pageLoading,
  loadingPage,
  image,
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  ClickType type = ClickType.image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fast code example app'),
      ),
      body: Column(
        children: [
          Wrap(
            children: [
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                child: Text('Ratio Image'),
                onPressed: () {
                  setState(() {
                    type = ClickType.image;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                child: Text('Page List Loading'),
                onPressed: () {
                  setState(() {
                    type = ClickType.pageLoading;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                child: Text('Page Inner Loading'),
                onPressed: () {
                  setState(() {
                    type = ClickType.loadingPage;
                  });
                },
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                child: Text('Loading Task'),
                onPressed: () async {
                  var result = await FastUi.loadingTask(
                    task: () async {
                      await Future.delayed(Duration(seconds: 2));
                      return 'Task completed!';
                    },
                  );
                  fastPrint('result: $result');
                },
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                child: Text('Select resources'),
                onPressed: () async {
                  var result = await FastUtils.pickMedias(
                    context: context,
                    maxImages: 9,
                    // from: MediaFrom.gallery,
                  );
                  fastPrint('result: ${result.length}');
                },
              ),
              SizedBox(
                height: 20,
              ),
              CupertinoButton(
                child: Text('IOS Dialog'),
                onPressed: () async {
                  var result =
                      await FastUi.showIosDialog<String>(context, textClick: [
                    TextClick(
                      text: '666',
                      tap: () async {
                        Future.delayed(Duration(seconds: 2));
                        await fastPrint('666 clicked');
                        return '666';
                      },
                    ),
                    TextClick(
                      text: '777',
                      tap: () async {
                        Future.delayed(Duration(seconds: 2));
                        await fastPrint('777 clicked');
                        return '777';
                      },
                    ),
                  ]);
                  fastPrint('result: ${result}');
                },
              ),
              Divider(),
              SizedBox(
                height: 20,
              ),
            ],
          ),
          Expanded(
            child: type == ClickType.loadingPage
                ? LoadingPage()
                : type == ClickType.pageLoading
                    ? PageListLoadingPage()
                    : _image(),
          )
        ],
      ),
    );
  }

  _image() {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('FastImageWidget Auto Width 1563px * 3840px'),
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: FastImageWidget(
              imageUrl: 'https://qifenpro.github.io/test1.jpg',
              width: MediaQuery.of(context).size.width,
              ratio: 3840 / 1563,
              stackBuilder: (width, height) {
                return Stack(
                  children: [
                    Container(
                      width: width / 2,
                      height: height / 2,
                      color: Colors.green,
                    ),
                  ],
                );
              },
            ),
          ),
          Text('FastImageWidget Auto Height 1563px * 3840px'),
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: FastImageWidget(
              imageUrl: 'https://qifenpro.github.io/test1.jpg',
              height: 100,
              ratio: 1563 / 3840,
            ),
          ),
          Text(
              'Asset Image FastImageWidget Auto Width 1563px * 3840px\nThe assets resource only supports image resources starting with assets'),
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: FastImageWidget(
              imageUrl: 'assets/test1.jpg',
              height: 100,
              ratio: 1563 / 3840,
            ),
          ),
          Divider(),
          Text('FastRatioWidget Auto Width 1563px * 3840px'),
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            child: FastRatioWidget(
              child: Opacity(
                  opacity: 0.5,
                  child: Image.network('https://qifenpro.github.io/test1.jpg')),
              width: MediaQuery.of(context).size.width,
              ratio: 3840 / 1563,
            ),
          ),
          Text('FastRatioWidget Auto Height 1563px * 3840px'),
          Container(
            color: Colors.red,
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: FastRatioWidget(
              child: Opacity(
                  opacity: 0.5,
                  child: Image.network('https://qifenpro.github.io/test1.jpg')),
              height: 100,
              ratio: 1563 / 3840,
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with FastStatusMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inner Loading'),
      ),
      body: FastRefreshWidget(
        onRefresh: refresh,
        child: isNormal
            ? Center(child: const Text('loading success'))
            : otherWidget,
      ),
    );
  }

  @override
  bool get empty => false;

  @override
  Future loadData() async {
    await Future.delayed(const Duration(seconds: 2));
  }
}

class PageListLoadingPage extends StatefulWidget {
  const PageListLoadingPage({super.key});

  @override
  State<PageListLoadingPage> createState() => _PageListLoadingPageState();
}

class _PageListLoadingPageState extends State<PageListLoadingPage>
    with FastPageMixin<String, PageListLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Loading'),
      ),
      body: FastRefreshWidget(
        onLoad:
            loadMore, //If the bottom loading is abnormal, you can continue to pull down the bottom
        // onLoad: noMore
        //     ? null
        //     : loadMore, //The bottom loading is abnormal and you cannot continue to pull down the bottom
        onRefresh: refresh,
        child: isNormal
            ? ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    child: Text('${data[index]}  Index: $index'),
                    height: 60,
                  );
                },
              )
            : otherWidget,
      ),
    );
  }

  @override
  int get initializePage => 0;

  @override
  Future<List<String>> loadData(int page) async {
    if (page == initializePage) {
      //other init loading
      await Future.delayed(Duration(seconds: 1));
      // Simulation error
      // throw 'error loading';
    }

    fastPrint('page  $page');

    await Future.delayed(Duration(seconds: 1));

    // Simulation error
    if (page == 5) throw 'error loading';

    return page >= 9
        ? []
        : List.generate(pageCount, (index) => 'Page $page, Item $index');
  }
}
