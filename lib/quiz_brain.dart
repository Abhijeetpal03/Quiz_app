import 'question.dart';

int _questionNum = 0;

class QuizBrain {
  List<Question> _questionBank = [
    Question(
        q: 'Sage Veda Vyasa was another incarnation of Lord Vishnu.', a: true),
    Question(
        q: 'Sage Durvasa taught Kunti the mantras that helped her beget children by invoking the blessings of the Devas? ',
        a: true),
    Question(q: 'Bhishma real name is Devadut', a: false),
    Question(
        q: ' Hastinapuram was the capital city of the Kuru dynasty of kings?',
        a: true),
    Question(
        q: 'Karna sent the Brahma Astra into Uttara\'s womb when she was pregnant with Abhimanyu\'s child? ',
        a: false),
    Question(q: ' Kunti was Vasudevar\'s sister? ', a: true),
    Question(q: ' Aamba was re-born as Shikhandi to slay Bhishma? ', a: true),
  ];

  void nextQuestion() {
    if (_questionNum < _questionBank.length - 1) {
      _questionNum++;
      print(_questionNum);
      print(_questionBank.length);
    }
  }

  String getQuestionText() {
    return _questionBank[_questionNum].questionText;
  }

  bool getCorrectAnswer() {
    return _questionBank[_questionNum].questionAns;
  }

  bool isFinished() {
    return _questionNum >= _questionBank.length - 1;
  }

  void reset() {
    _questionNum = 0;
  }
}
