import 'package:flutter_graph_ql/features/Article/ArticleModel.dart';
import 'package:flutter_graph_ql/features/Article/ArticleService.dart';
import 'package:flutter_graph_ql/helpers/Manager.dart';
import 'package:rxdart/rxdart.dart';

class ArticleManager implements Manager {
  final PublishSubject<String> _filterSubject = PublishSubject<String>();
  final PublishSubject<List<ArticleModel>> _collectionSubject =
      PublishSubject<List<ArticleModel>>();

  Stream<List<ArticleModel>> get browse$ => _collectionSubject.stream;

  Sink<String> get inFilter => _filterSubject.sink;

  ArticleManager() {
    _filterSubject.switchMap((filter) async* {
      yield await ArticleService.browse();
    }).listen(((colletion){
      _collectionSubject.add(colletion);
    }));
  }

  @override
  void dispose() {
    _filterSubject.close();
    _collectionSubject.close();
  }
}
