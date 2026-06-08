import 'package:flutter/material.dart';
import 'package:tasky/widgets/text_field.widget.dart';
import 'package:tasky/widgets/button.widget.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/TASKY-logo-orange.png',
                width: 200,
              ),
            ),
            SizedBox(height: 8),
            const Text(
              'Créer un compte',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
            SizedBox(height: 8),
            const Text(
              'Quelques secondes et c’est parti.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            AppTextField(
              label: 'Nom complet',
              hintText: 'Souleymane BARRO',
               prefixIcon: Icons.person_outline,
            ),

            SizedBox(height: 24),
            AppTextField(
              label: 'Adresse Email',
              hintText: 'souleymane@gmail.com',
              prefixIcon: Icons.email_outlined,
            ),
            SizedBox(height: 24),
            AppTextField(
              label: 'Mot de passe',
              hintText: '••••••••••••',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
            ),
            
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: false,
                  onChanged: (value) {},
                  activeColor: Color(0xFFFF6B5C),
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(fontSize: 13, color: Colors.grey),
                      children: [
                        TextSpan(text: 'j\'accepte les '),
                        TextSpan(
                          text: 'conditions générales',
                          style: TextStyle(
                            color: Color(0xFFFF6B5C),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextSpan(text: ' et la '),
                        TextSpan(
                          text: 'politique de confidentialité',
                          style: TextStyle(
                            color: Color(0xFFFF6B5C),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 32),
            AppButton(
              label: 'Créer mon compte',
              onTap: () {},
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Déjà inscrit ? ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Se connecter',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFFFF6B5C),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}