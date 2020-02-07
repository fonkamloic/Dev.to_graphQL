class ArticleModel {
  final int id;
  final String title;
  final String description;
  final String avatar;
  final int reactionCount;
  final List<dynamic> tags;

  ArticleModel.fromJSON(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        avatar = json['user']['profileImage90'],
        reactionCount = json['positiveReactionsCount'],
        tags = json['tags'] ?? [],
        description = json['title'];
}
