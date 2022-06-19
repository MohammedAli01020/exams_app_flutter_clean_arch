// To parse this JSON data, do
//
//     final questionsData = questionsDataFromJson(jsonString);

import 'dart:convert';

import 'package:exams_app/features/exams/data/models/question_model.dart';

QuestionsData questionsDataFromJson(String str) => QuestionsData.fromJson(json.decode(str));

String questionsDataToJson(QuestionsData data) => json.encode(data.toJson());

class QuestionsData {
  QuestionsData({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.last,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  List<QuestionModel> content;
  Pageable pageable;
  int totalPages;
  int totalElements;
  bool last;
  int size;
  int number;
  Sort sort;
  bool first;
  int numberOfElements;
  bool empty;

  factory QuestionsData.fromJson(Map<String, dynamic> json) => QuestionsData(
    content: List<QuestionModel>.from(json["content"].map((x) => QuestionModel.fromJson(x))),
    pageable: Pageable.fromJson(json["pageable"]),
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
    last: json["last"],
    size: json["size"],
    number: json["number"],
    sort: Sort.fromJson(json["sort"]),
    first: json["first"],
    numberOfElements: json["numberOfElements"],
    empty: json["empty"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(content.map((x) => x.toJson())),
    "pageable": pageable.toJson(),
    "totalPages": totalPages,
    "totalElements": totalElements,
    "last": last,
    "size": size,
    "number": number,
    "sort": sort.toJson(),
    "first": first,
    "numberOfElements": numberOfElements,
    "empty": empty,
  };
}



class Pageable {
  Pageable({
    required this.sort,
    required this.offset,
    required this.pageSize,
    required this.pageNumber,
    required this.paged,
    required this.unpaged,
  });

  Sort sort;
  int offset;
  int pageSize;
  int pageNumber;
  bool paged;
  bool unpaged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
    sort: Sort.fromJson(json["sort"]),
    offset: json["offset"],
    pageSize: json["pageSize"],
    pageNumber: json["pageNumber"],
    paged: json["paged"],
    unpaged: json["unpaged"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort.toJson(),
    "offset": offset,
    "pageSize": pageSize,
    "pageNumber": pageNumber,
    "paged": paged,
    "unpaged": unpaged,
  };
}

class Sort {
  Sort({
    required this.empty,
    required this.unsorted,
    required this.sorted,
  });

  bool empty;
  bool unsorted;
  bool sorted;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
    empty: json["empty"],
    unsorted: json["unsorted"],
    sorted: json["sorted"],
  );

  Map<String, dynamic> toJson() => {
    "empty": empty,
    "unsorted": unsorted,
    "sorted": sorted,
  };
}
