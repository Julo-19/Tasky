import 'package:flutter/material.dart';
import 'package:tasky/widgets/onboarding.widget.dart';
import 'package:tasky/widgets/onboarding_dots.widget.dart';
import 'package:tasky/widgets/button.widget.dart';
import 'package:tasky/screens/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [

          //  pages
          PageView(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            children: const [
              // screen1
              OnboardingPage(
                image: 'assets/images/ic-toDoList.png',
                title: 'Toutes vos tâches,\nau même endroit',
                description: 'Créez, organisez et suivez vos tâches\nquotidiennes sans effort.',
              ),
              // screen2
              OnboardingPage(
                image: 'assets/images/flag.png',
                title: 'Priorisez ce qui compte',
                description: 'Attribuez des priorités colorées et\nconcentrez-vous sur l\'essentiel.',
              ),
              // screen3
              OnboardingPage(
                image: 'assets/images/alarm.png',
                title: 'Ne ratez\n plus rien',
                description: ' Des rappels au bon moment et un\npartage en un geste.',
              ),
            ],
          ),

        
          Positioned(
            top: 48,
            right: 24,
            child: GestureDetector(
              onTap: () {},
              child: const Text(
                'Passer',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ),

          Positioned(
              bottom: 120,
              left: 0,
              right: 0,
              child: OnboardingDots(currentPage: _currentPage),
          ),

          Positioned(
            bottom: 48,
            left: 24,
            right: 24,
            child: AppButton(
              label: _currentPage == 2 ? 'Commencer' : 'Suivant',
              onTap: () {
                if (_currentPage < 2) {
                  _pageController.nextPage(
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                    );
                }else {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                     );
                }
              },
            )
          )
        ],
      ),
    );
  }
}