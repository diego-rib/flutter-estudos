import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onAnswerSubmit});

  final void Function(String arg) onAnswerSubmit;

  @override
  State<QuestionsScreen> createState() {
    return _QuestionScreenState();
  }
}

class _QuestionScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;

  final lastQuestionIndex = questions.length - 1;

  void answerQuestion(String selectedAnswer) {
    widget.onAnswerSubmit(selectedAnswer);
    setState(() {
      currentQuestionIndex += 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              // Texto da pergunta
              currentQuestion.text,
              style: GoogleFonts.acme(),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Botões contendo as respostas da pergunta
            ...currentQuestion.getShuffledAnswers().map(
                  (answer) => AnswerButton(
                    buttonText: answer,
                    onTap: () {
                      answerQuestion(answer);
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
