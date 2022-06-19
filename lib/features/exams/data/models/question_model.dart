import 'package:exams_app/features/exams/domain/entities/question.dart';

class QuestionModel extends Question {

  const QuestionModel({required int questionId, required String title, required List<String> answers, required String correctAnswer, required int creationDateTime}) :
        super(questionId: questionId, title: title, answers: answers, correctAnswer: correctAnswer,creationDateTime: creationDateTime);


  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
    questionId: json["questionId"],
    title: json["title"],

    answers: List<String>.from(json["answers"].map((x) => x))..shuffle(),
    correctAnswer: json["correctAnswer"],
    creationDateTime: json["creationDateTime"],

  );

  Map<String, dynamic> toJson() => {
    "questionId": questionId,
    "title": title,
    "answers": List<dynamic>.from(answers.map((x) => x)),
    "correctAnswer": answers,
    "creationDateTime": creationDateTime,

  };


}