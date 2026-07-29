import 'package:flutter/material.dart';
import 'package:tasky/controllers/auth_controller.dart';
import 'package:tasky/widgets/text_field.widget.dart';
import 'package:tasky/widgets/button.widget.dart';
import 'package:tasky/screens/register_screen.dart';
import 'package:tasky/screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController _authController = AuthController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    // Validation
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tous les champs sont obligatoires')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authController.login(
        username: _usernameController.text,
        password: _passwordController.text,
      );

      // Succès → direction Home
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeScreen()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Identifiants incorrects')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

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
              label: 'Nom d\'utilisateur',
              hintText: 'souleymane19',
              prefixIcon: Icons.person_outline,
              controller: _usernameController,
            ),
            SizedBox(height: 24),
            AppTextField(
              label: 'Mot de passe',
              hintText: '••••••••••••',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              controller: _passwordController,
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
              label: _isLoading ? 'Connexion...' : 'Se Connecter',
              onTap: _isLoading ? () {} : _login,
            ),
            SizedBox(height: 24),
            // Séparateur
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
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}