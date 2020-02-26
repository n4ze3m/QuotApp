class QuotesDb{
  int id;
  String quote;
  String  author;

  QuotesDb({this.id,this.quote,this.author});

  factory QuotesDb.fromMap(Map<String, dynamic> json) => new QuotesDb(
    id: json["_id"],
    quote: json["quote"],
    author: json["author"],
  );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "quote": quote,
        "author": author,
  };
}