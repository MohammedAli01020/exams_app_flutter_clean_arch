// To parse this JSON data, do
//
//     final examsData = examsDataFromJson(jsonString);

import 'dart:convert';

import 'package:exams_app/features/exams/data/models/exam_model.dart';

ExamsData examsDataFromJson(String str) => ExamsData.fromJson(json.decode(str));

String examsDataToJson(ExamsData data) => json.encode(data.toJson());

class ExamsData {
  ExamsData({
    required this.content,
    required this.pageable,
    required this.last,
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.numberOfElements,
    required this.empty,
  });

  List<ExamModel> content;
  Pageable pageable;
  bool last;
  int totalPages;
  int totalElements;
  int size;
  int number;
  Sort sort;
  bool first;
  int numberOfElements;
  bool empty;

  factory ExamsData.fromJson(Map<String, dynamic> json) => ExamsData(
    content: List<ExamModel>.from(json["content"].map((x) => ExamModel.fromJson(x))),
    pageable: Pageable.fromJson(json["pageable"]),
    last: json["last"],
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
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
    "last": last,
    "totalPages": totalPages,
    "totalElements": totalElements,
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
    required this.pageNumber,
    required this.pageSize,
    required this.paged,
    required this.unpaged,
  });

  Sort sort;
  int offset;
  int pageNumber;
  int pageSize;
  bool paged;
  bool unpaged;

  factory Pageable.fromJson(Map<String, dynamic> json) => Pageable(
    sort: Sort.fromJson(json["sort"]),
    offset: json["offset"],
    pageNumber: json["pageNumber"],
    pageSize: json["pageSize"],
    paged: json["paged"],
    unpaged: json["unpaged"],
  );

  Map<String, dynamic> toJson() => {
    "sort": sort.toJson(),
    "offset": offset,
    "pageNumber": pageNumber,
    "pageSize": pageSize,
    "paged": paged,
    "unpaged": unpaged,
  };
}

class Sort {
  Sort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });

  final bool empty;
  final bool sorted;
  final bool unsorted;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
    empty: json["empty"],
    sorted: json["sorted"],
    unsorted: json["unsorted"],
  );

  Map<String, dynamic> toJson() => {
    "empty": empty,
    "sorted": sorted,
    "unsorted": unsorted,
  };
}
