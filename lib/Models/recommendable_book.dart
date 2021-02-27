class RecommendableBook {
  final String Id;
  final String TITLE;
  final String GENRES;
  final String IMAGEURL;
  final String ISBN;
  final String PAGENUM;
  final String PUBYEAR;
  final String WRITER;
  final String RATING;

  RecommendableBook({
    this.Id,
    this.TITLE,
    this.GENRES,
    this.IMAGEURL,
    this.ISBN,
    this.PAGENUM,
    this.PUBYEAR,
    this.WRITER,
    this.RATING,
  });

  @override
  String toString() {
    return '\n Id:$Id  '
        'TITLE:$TITLE  '
        'GENRES:$GENRES  '
        'IMAGEURL:${IMAGEURL.toLowerCase()}  '
        'ISBN:$ISBN  '
        'PAGENUM:$PAGENUM  '
        'PUBYEAR:$PUBYEAR  '
        'WRITER:$WRITER  '
        'RATING:$RATING\n';
  }

  factory RecommendableBook.fromJson(String id, Map<String, dynamic> bookData) {
    return RecommendableBook(
      Id: id.toString(),
      GENRES: bookData['GENRES'].toString(),
      IMAGEURL: bookData['IMAGEURL'].toString().toLowerCase(),
      ISBN: bookData['ISBN'].toString(),
      PAGENUM: bookData['PAGENUM'].toString(),
      PUBYEAR: bookData['PUBYEAR'].toString(),
      TITLE: bookData['TITLE'].toString(),
      WRITER: bookData['WRITER'].toString(),
      RATING: bookData['RATING'].toString(),
    );
  }
  bool isEqual(RecommendableBook other) {
    return other.Id == Id;
  }
}
