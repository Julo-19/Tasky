import 'package:flutter/material.dart';
import 'package:tasky/widgets/text_field.widget.dart';
import 'package:tasky/widgets/button.widget.dart';
import 'package:tasky/screens/register_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
              'Connectez-vous',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
            SizedBox(height: 8),
            const Text(
              'Connectez-vous pour retrouver vos tâches.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
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
            SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {},
                child: Text(
                  'Mot de passe oublié ?',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFFFF6B5C),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
            AppButton(
              label: 'Se Connecter',
              onTap: () {},
            ),
            SizedBox(height: 24),

            // Séparator
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey.shade400),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'ou continuer avec',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.grey.shade400),
                ),
              ],
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Image.asset('assets/images/Google.png', width: 24),
                  label: Text(
                    'Google',
                    style: TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                SizedBox(width: 16),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.apple, color: Colors.black, size: 24),
                  label: Text(
                    'Apple',
                    style: TextStyle(
                      color: Color(0xFF1A1A2E),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    side: BorderSide(color: Colors.grey.shade300),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),

        
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Pas encore de compte ? ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterScreen()),
                    );
                  },
                  child: Text(
                    'S\'inscrire',
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