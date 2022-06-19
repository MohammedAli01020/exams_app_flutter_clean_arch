import 'package:exams_app/features/exams/domain/entities/exam.dart';

class ExamModel extends Exam {

  const ExamModel({required int examId, required String examTitle,
    required int creationDateTime, required UserDetails userDetails}) :
        super(examId: examId, examTitle: examTitle, creationDateTime: creationDateTime, userDetails: userDetails);


  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
    examId: json["examId"],
    examTitle: json["examTitle"],
    creationDateTime: json["creationDateTime"],
    userDetails: UserDetails.fromJson(json["userDetails"]),
  );

  Map<String, dynamic> toJson() => {
    "examId": examId,
    "examTitle": examTitle,
    "creationDateTime": creationDateTime,
    "userDetails": userDetails.toJson(),
  };

}