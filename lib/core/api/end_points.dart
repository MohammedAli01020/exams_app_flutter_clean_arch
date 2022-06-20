class EndPoints {
  // static const String baseUrl = 'http://192.168.1.16:5000/';

  static const String baseUrl = 'http://exams-env.eba-43bj942n.us-east-1.elasticbeanstalk.com/';


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
  static const String findUserExamByUserAndExam = '${baseUrl}api/userExam/byUserAndExam/';


  // email
  static const String sendEmail = '${baseUrl}api/email/send';


  // user

  static const String findUserByEmail = '${baseUrl}api/users/user/';

  static const String changePasswordById = '${baseUrl}api/users/updatePassword/';

  static const String updatePasswordByUsername = '${baseUrl}api/users/updatePasswordByUsername/';

  static const String changeUsernameById = '${baseUrl}api/users/updateUsername/';

  static const String getUserById = '${baseUrl}api/users/userId/';





}
