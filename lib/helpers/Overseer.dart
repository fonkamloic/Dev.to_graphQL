import 'package:flutter_graph_ql/features/Article/ArticleManager.dart';
import 'package:flutter_graph_ql/helpers/Manager.dart';

class Overseer{
  Map<dynamic, Manager> repository = {};

  Map<dynamic, Function> _factories = {
    ArticleManager:  () => ArticleManager(),

  };


  static final Overseer _singleton = Overseer._internal();
  Overseer._internal();
  factory Overseer() => _singleton;

  _summon(name) => repository[name] = _factories[name]();

  fetch(name) => repository.containsKey(name) ? repository[name] : _summon(name);

  release(name) {
    Manager manager = repository[name];
    manager.dispose();
    repository.remove(name);
  }
}