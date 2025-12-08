class QuizModel {
  final String image, questions, correctAnswer;
  List<String> options;

  QuizModel({
    required this.image,
    required this.questions,
    required this.options,
    required this.correctAnswer,
  });
}

class QuizLogic {
  int currentIndex = 0;
  List<QuizModel> quizQuestionBank = [
    QuizModel(
      image: 'assets/images/question1.webp',
      questions: "Which planet is known as the Red Planet?",
      options: ['Mars', 'Jupiter', 'Venus', 'Saturn'],
      correctAnswer: "Mars",
    ),
    QuizModel(
      image: 'assets/images/question2.webp',
      questions: "What is the capital city of France?",
      options: ['Berlin', 'Madrid', 'Paris', 'Rome'],
      correctAnswer: "Paris",
    ),
    QuizModel(
      image: 'assets/images/question3.webp',
      questions: "Which animal is known as the 'Ship of the Desert'?",
      options: ['Horse', 'Camel', 'Elephant', 'Donkey'],
      correctAnswer: "Camel",
    ),
    QuizModel(
      image: 'assets/images/question4.webp',
      questions: "How many colors are there in a rainbow?",
      options: ['5', '6', '7', '8'],
      correctAnswer: "7",
    ),
    QuizModel(
      image: 'assets/images/question5.webp',
      questions: "Which is the largest ocean on Earth?",
      options: ['Atlantic', 'Indian', 'Arctic', 'Pacific'],
      correctAnswer: "Pacific",
    ),
    QuizModel(
      image: 'assets/images/question6.webp',
      questions: "Who wrote the play 'Romeo and Juliet'?",
      options: ['Dickens', 'Shakespeare', 'Twain', 'Orwell'],
      correctAnswer: "Shakespeare",
    ),
    QuizModel(
      image: 'assets/images/question7.webp',
      questions: "Which gas do humans need to breathe to survive?",
      options: ['Nitrogen', 'Carbon', 'Oxygen', 'Helium'],
      correctAnswer: "Oxygen",
    ),
    QuizModel(
      image: 'assets/images/question8.webp',
      questions: "What is the fastest land animal?",
      options: ['Lion', 'Cheetah', 'Tiger', 'Leopard'],
      correctAnswer: "Cheetah",
    ),
    QuizModel(
      image: 'assets/images/question9.webp',
      questions: "Which continent is the Sahara Desert located in?",
      options: ['Asia', 'Africa', 'Europe', 'Australia'],
      correctAnswer: "Africa",
    ),
    QuizModel(
      image: 'assets/images/question10.webp',
      questions: "What is the boiling point of water in Celsius?",
      options: ['50', '90', '100', '120'],
      correctAnswer: "100",
    ),
  ];

  String getImage() {
    return quizQuestionBank[currentIndex].image;
  }

  String getQuestion() {
    return quizQuestionBank[currentIndex].questions;
  }

  String getCorrectAnswer() {
    return quizQuestionBank[currentIndex].correctAnswer;
  }

  List<String> getOptions() {
    return quizQuestionBank[currentIndex].options;
  }

  void nextQuestion() {
    if (currentIndex < quizQuestionBank.length - 1) {
      currentIndex++;
    }
  }

  bool isQuizFinished() {
    if (currentIndex >= quizQuestionBank.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  void restart() {
    currentIndex = 0;
  }
}
