import 'package:flutter/material.dart';
import 'package:quiz_app/quiz_logic.dart';
// import 'package:quiz_app/quiz_starting_page.dart';

String homePageImage =
    'https://imgs.search.brave.com/EIGWitMpqppqsbx9U9M_Cfvwa6SmsyrJQpIiOKKqR58/rs:fit:860:0:0:0/g:ce/aHR0cHM6Ly9pbWcu/ZnJlZXBpay5jb20v/ZnJlZS1waG90by9w/b3J0cmFpdC1tYW4t/Y2FydG9vbi1zdHls/ZV8yMy0yMTUxMTMz/OTU1LmpwZz9zZW10/PWFpc19zZV9lbnJp/Y2hlZCZ3PTc0MCZx/PTgw';

class QuizAppHomeScreen extends StatefulWidget {
  const QuizAppHomeScreen({super.key});

  @override
  State<QuizAppHomeScreen> createState() => _QuizAppHomeScreenState();
}

class _QuizAppHomeScreenState extends State<QuizAppHomeScreen> {
  TextEditingController nameController = TextEditingController();
  bool isQuizStarted = false;
  QuizLogic quiz = QuizLogic();
  int score = 0;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz app",
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.favorite, color: Colors.white),
                        SizedBox(width: 10),
                        Icon(Icons.bookmark, color: Colors.white),
                      ],
                    ),
                    if (!isQuizStarted) entryUI() else quizUI(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget entryUI() {
    return Column(
      children: [
        SizedBox(height: 20),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.network(homePageImage, height: 300),
        ),
        SizedBox(height: 30),
        Text(
          "Enter your name to start the quiz",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        SizedBox(height: 50),
        TextField(
          // style: TextStyle(color: Colors.red),
          controller: nameController,
          decoration: InputDecoration(
            labelText: "Enter your name",
            errorText: errorMessage,
            border: OutlineInputBorder(),
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
        SizedBox(height: 50),
        ElevatedButton(
          onPressed: () {
            setState(() {
              if (nameController.text.trim().isEmpty) {
                errorMessage = 'Please enter your name to start';
              } else {
                isQuizStarted = true;
              }
            });
          },
          child: Text("Start", style: TextStyle(fontSize: 18)),
        ),
      ],
    );
  }

  Widget quizUI() {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              quiz.restart();
              isQuizStarted = false;
            });
          },
          child: Text("Restart"),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Image.asset(quiz.getImage(), height: 300),
        ),
        SizedBox(height: 30),
        Text(
          quiz.getQuestion(),
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        SizedBox(height: 50),
        ...quiz.getOptions().map((option) {
          return ElevatedButton(
            onPressed: () {
              setState(() {
                checkAnswer(option);
              });
            },
            child: Text(option),
          );
        }),
        SizedBox(height: 50),
      ],
    );
  }

  void checkAnswer(String userPicked) {
    String correctAnswer = quiz.getCorrectAnswer();
    if (userPicked == correctAnswer) {
      score++;
    }
    if (quiz.isQuizFinished()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Dear ${nameController.text}, your Quiz is finished. Your score: $score",
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    quiz.restart();
                    score = 0;
                    isQuizStarted = false;
                  });
                  Navigator.pop(context);
                },
                child: Text('Restart quiz'),
              ),
            ],
          );
        },
      );
    } else {
      quiz.nextQuestion();
    }
  }
}
