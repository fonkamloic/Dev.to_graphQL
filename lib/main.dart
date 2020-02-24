import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_graph_ql/features/Article/ArticleManager.dart';
import 'package:flutter_graph_ql/features/Article/ArticleModel.dart';
import 'package:flutter_graph_ql/helpers/Observer.dart';
import 'package:flutter_graph_ql/helpers/Overseer.dart';
import 'package:flutter_graph_ql/helpers/Provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      data: Overseer(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Colors.white,
        ),
        home: MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    ArticleManager manager = Provider.of(context).fetch(ArticleManager);
    manager.inFilter.add('');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Observer(
        stream: manager.browse$,
        onSuccess: (context, data) => ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            ArticleModel element = data[index];

            return Card(
              child: Column(
                children: <Widget>[
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(element.avatar),
                    ),
                    title: Text(element.title),
                    subtitle: Column(
                      children: <Widget>[
                        Text(element.description),
                        Row(children: <Widget>[
                          for (var tag in element.tags)  Text('#$tag ')
                        ],)
                      ],
                    ),
                    isThreeLine: true,
                  ),
                  Padding(padding: EdgeInsets.only(left:8.0, bottom: 5), child: Container(child: Row(
                    children: <Widget>[
                      Icon(Icons.favorite, color: Colors.redAccent, size: 15,),
                      Text(element.reactionCount.toString()),
                    ],
                  ),),)
                ],
              ),
            );
          },
          itemCount: data.length,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: null,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
