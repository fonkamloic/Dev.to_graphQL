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
        avatar = json['user']['profile_image_90'],
        reactionCount = json['positive_reactions_count'],
        tags = json['tag_list'] ?? [],
        description = json['title'];
}
