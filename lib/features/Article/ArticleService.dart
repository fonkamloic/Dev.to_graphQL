import 'dart:convert';

import 'package:flutter_graph_ql/features/Article/ArticleModel.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:http/http.dart' as http;


const ArticleQuery = """
query firstTry {
  devTo {
    articles {
      nodes {
        id
        title
        tags
        positiveReactionsCount
        user {
          profileImage90
        }
        description
      }
    }
  }
}
""";

class ArticleService {
  static String _url = "https://dev.to/api/articles";

  static HttpLink link = HttpLink(
    uri: 'https://serve.onegraph.com/dynamic?app_id=49c25375-a476-445c-a618-5a22aec9d365&show_metrics=true&show_api_request=false'
  );

  static GraphQLClient client = GraphQLClient(cache: InMemoryCache(), link: link);

  // GET /articles
  static Future<List<ArticleModel>> browse() async {
    http.Response response = await http.get('$_url');
    String payload = response.body;

    List collection = json.decode(payload);
    Iterable<ArticleModel> elements =
        collection.map((_) => ArticleModel.fromJSON(_));

    return elements.toList();
  }


  static Future<List<ArticleModel>> query() async {
    final QueryOptions _options = QueryOptions(documentNode: gql(ArticleQuery), variables:{} );

    QueryResult result = await client.query(_options);

    List data = result.data['devTo']['articles']['nodes'];

    Iterable<ArticleModel> elements =
    data.map((_) => ArticleModel.fromJSON(_));

    return elements.toList();


  }

  // GET /article/:id
  static Future<ArticleModel> fetch() {}
}
