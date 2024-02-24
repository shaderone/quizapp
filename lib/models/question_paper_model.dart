// ? We build model from json with the deeply nested map first.

// ** json to dart - online converted model

class QuestionPaperModel {
  String id;
  String title;
  String imageUrl;
  String description;
  int timeSeconds;
  List<Questions> questions;

  QuestionPaperModel({required this.id, required this.title, required this.imageUrl, required this.description, required this.timeSeconds, required this.questions});

  QuestionPaperModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['Description'] as String,
        timeSeconds = json['time_seconds'] as int,
        // we cast question as Map<String,dynamic> because its the type required.
        questions = (json['questions'] as List).map((question) => Questions.fromJson(question as Map<String, dynamic>)).toList();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['image_url'] = imageUrl;
    data['Description'] = description;
    data['time_seconds'] = timeSeconds;
    data['questions'] = questions.map((v) => v.toJson()).toList();
    return data;
  }
}

class Questions {
  String id;
  String question;
  List<AnswersModal> answers;
  String correctAnswer;

  Questions({required this.id, required this.question, required this.answers, required this.correctAnswer});

  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        question = json['question'] as String,
        // Get the answers from json (in Map from) and convert it to List. Then Iterate over this list and call Answers modal to convert each answer from Map to list type.
        // we cast question as Map<String,dynamic> because its the type required.
        answers = (json['answers'] as List).map((answer) => AnswersModal.fromJson(answer as Map<String, dynamic>)).toList(),
        // answers will now have the answers as a list.
        correctAnswer = json['correct_answer'] as String;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['question'] = question;
    data['answers'] = answers.map((answer) => answer.toJson()).toList();
    data['correct_answer'] = correctAnswer;
    return data;
  }
}

class AnswersModal {
  String identifier;
  String answer;

  AnswersModal({required this.identifier, required this.answer});

  AnswersModal.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['Answer'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['identifier'] = identifier;
    data['Answer'] = answer;
    return data;
  }
}



// ** Manual model
//class AnswerModel {
//  final String? identifier;
//  final String? answer;
//
//  AnswerModel({required this.identifier, required this.answer});
//
//  ? The data recieved by this model is json form. we need to convert it into Map.
//  AnswerModel.fromJson(Map<String, dynamic> json)
//  ? here we directly assign values (without creating definition scope{}) from the input data (json -  we get this as Map in the app) to the fields or variables || the value gets initialized before the constructor body runs
//      : identifier = json['identifier'] as String?,
//        answer = json['Answer'] as String?;
//}
