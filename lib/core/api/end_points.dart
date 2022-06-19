class EndPoints {
  // static const String baseUrl = 'http://192.168.1.16:5000/';

  static const String baseUrl = 'http://exams-env.eba-43bj942n.us-east-1.elasticbeanstalk.com:5000/';


  static const String login = '${baseUrl}login';
  static const String getAllExams = '${baseUrl}api/exams/all';
  static const String createExam = '${baseUrl}api/exams/create';
  static const String deleteExam = '${baseUrl}api/delete/';

  // questions

  static const String addQuestion = '${baseUrl}api/questions/add/';
  static const String allQuestion = '${baseUrl}api/questions/all';

  // user exams
  static const String addUserExam = '${baseUrl}api/userExam/add';
  static const String allUserExam = '${baseUrl}api/userExam/all';
  static const String allUserExamByUserId = '${baseUrl}api/userExam/allByUserId/';

  static const String sendEmail = '${baseUrl}api/email/send';

  static const String findUserByEmail = '${baseUrl}api/users/user/';


}
