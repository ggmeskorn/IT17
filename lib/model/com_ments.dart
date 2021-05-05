class CommentsModel {
  String id;
  String postid;
  String authorpost;
  String useremail;
  String comments;
  String commentsdate;
  String isSeen;

  CommentsModel(
      {this.id,
      this.postid,
      this.authorpost,
      this.useremail,
      this.comments,
      this.commentsdate,
      this.isSeen});

  CommentsModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    postid = json['post_id'];
    authorpost = json['author_post'];
    useremail = json['user_email'];
    comments = json['comments'];
    commentsdate = json['comments_date'];
    isSeen = json['isSeen'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['post_id'] = this.postid;
    data['author_post'] = this.authorpost;
    data['user_email'] = this.useremail;
    data['comments'] = this.comments;
    data['comments_date'] = this.commentsdate;
    data['isSeen'] = this.isSeen;

    return data;
  }
}
