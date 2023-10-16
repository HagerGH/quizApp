import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quizapp/model/question_model.dart';
import 'package:quizapp/model/question_model.dart';
import 'package:quizapp/model/question_model.dart';
import 'package:quizapp/screens/result/resultscreen.dart';

import '../model/question_model.dart';
import '../model/question_model.dart';
import '../model/question_model.dart';
import '../screens/welcome.dart';

class QuizController extends GetxController{
  String name='';
  final List<QuestionModel> _questionList=[
    QuestionModel(
      id: 1,
      question:
      "Best Channel for Flutter ",
      answer: 2,
      options: ['Sec it', 'Sec it developer', 'sec it developers', 'mesh sec it '],
    ),
    QuestionModel(
      id: 2,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
    QuestionModel(
      id: 3,
      question: "Best Flutter dev",
      answer: 2,
      options: ['sherif', 'sherif ahmed', 'ahmed sherif', 'doc sherif'],
    ),
    QuestionModel(
      id: 4,
      question: "Sherif is",
      answer: 1,
      options: ['eng', 'Doc', 'eng/Doc', 'Doc/Eng'],
    ),
    QuestionModel(
      id: 5,
      question:
      "Best Rapper in Egypt",
      answer: 3,
      options: ['Eljoker', 'Abyu', 'R3', 'All of the above'],
    ),
    QuestionModel(
      id: 6,
      question: "Real Name of ahmed sherif",
      answer: 2,
      options: ['ahmed sherif', 'sherif', 'Haytham', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 7,
      question: "Sherif love",
      answer: 3,
      options: ['Pharma', 'Micro', 'Medicnal', 'NONE OF ABOVE'],
    ),
    QuestionModel(
      id: 8,
      question: "hello",
      answer: 3,
      options: ['hello', 'hi', 'hola', 'Suiiiiiiiiiiii'],
    ),
    QuestionModel(
      id: 9,
      question:
      "Best Channel for Flutter ",
      answer: 2,
      options: ['Sec it', 'Sec it developer', 'sec it developers', 'mesh sec it '],
    ),
    QuestionModel(
      id: 10,
      question: "Best State Mangment Ststem is ",
      answer: 1,
      options: ['BloC', 'GetX', 'Provider', 'riverPod'],
    ),
  ];
  bool _isPressed=false;
  double _numberOfQuestion=1;
  int ? _selectAnswer;
  int   _countOfCorrectAnswer=0;
  final RxInt _sec=15.obs;
  int  get countOfQuestion =>_questionList.length;
  List<QuestionModel> get questionList => [..._questionList];
  bool get isPressed =>_isPressed;
  double get numberOfQuestion => _numberOfQuestion;
  int ? get selsectAnswer => _selectAnswer;
  int?  get countOfCorrectAnswer => _countOfCorrectAnswer;
  RxInt get sec => _sec;
 int ? _correctAnswer ;
 final Map<int ,bool> __questionIsAnswerd={};
 Timer ? _timer;
 final maxSec =15;
 late PageController pagerController ;
 @override
  void onInit() {
   pagerController  = PageController(initialPage: 0);
   resetAnswer();
    super.onInit();
  }
@override
  void onClose() {
   PageController().dispose();
    super.onClose();
  }
  double get scoreResult{
   return  countOfCorrectAnswer! *100/ _questionList.length;
  }
  void checkAnswer(QuestionModel questionModel ,int selectAnswer) {
 _isPressed = true;
 _selectAnswer =selectAnswer;
 _correctAnswer =questionModel.answer;
 if(_correctAnswer==_selectAnswer){
   _countOfCorrectAnswer++;
 }
 stopTimer();
 __questionIsAnswerd.update(questionModel.id, (value) => true);
 Future.delayed(const Duration(milliseconds:500)).then((value) => nextQuestion());
 update();
}
bool checkIsQuestionAnswerd(int quesID){
   return __questionIsAnswerd.entries
       .firstWhere((element) =>element.key== quesID)
       .value;
}
  void resetAnswer() {
   for(var element in  _questionList){
     __questionIsAnswerd.addAll({element.id:false});
   }
   update();
  }
  Color getColor(int answerIndex){
   if(_isPressed){
     if(answerIndex==_correctAnswer){
       return Colors.green;
     }
     else if(answerIndex==_selectAnswer && _correctAnswer!=_selectAnswer){
       return Colors.red;
     }
   }
   return Colors.white;
  }
  IconData  getIcon(int answerIndex){
    if(_isPressed){
      if(answerIndex==_correctAnswer){
        return Icons.done;
      }
      else if(answerIndex==_selectAnswer && _correctAnswer!=_selectAnswer){
        return Icons.close;
      }
    }
    return Icons.close;
  }

  void stopTimer()=>_timer!.cancel();

 void startAgain(){
   _correctAnswer=null;
   _countOfCorrectAnswer=0;
   _selectAnswer=null;
   resetAnswer();
   Get.offAllNamed(WelcomeScreen.routeName);
 }

  nextQuestion() {
   if(_timer!=null || _timer!.isActive){
     stopTimer();
   }
   if(pagerController.page==_questionList.length-1){
   Get.offAndToNamed(ResultScreen.routeName);
   }
   else {
     _isPressed=false;
     pagerController.nextPage(duration: const Duration(microseconds: 500), curve: Curves.linear);
     startTimer();
   }
   _numberOfQuestion=pagerController.page! +2;
   update();
  }

  void startTimer() {
   resetTimer();
   _timer=Timer.periodic(Duration(seconds: 1), (timer) {
     if(_sec.value>0){
       _sec.value--;
     }
     else{
       stopTimer();
       nextQuestion();
     }

   });
  }

  void resetTimer()=>_sec.value=maxSec;


}
