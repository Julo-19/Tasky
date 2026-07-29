import 'package:flutter/material.dart';
import 'package:tasky/controllers/auth_controller.dart';
import 'package:tasky/widgets/text_field.widget.dart';
import 'package:tasky/widgets/button.widget.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final AuthController _authController = AuthController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prenomController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isChecked = false;
  bool _isLoading = false;

  Future<void> _register() async {
    // Validation des champs
    if (_nomController.text.isEmpty ||
        _prenomController.text.isEmpty ||
        _usernameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tous les champs sont obligatoires')),
      );
      return;
    }

    
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez accepter les conditions')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authController.register(
        nom: _nomController.text,
        prenom: _prenomController.text,
        email: _emailController.text,
        username: _usernameController.text,
        password: _passwordController.text,
      );

      // Succès redirige vers Login
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Compte créé ! Connectez-vous.'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de l\'inscription')),
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
              'Créer un compte',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1A1A2E),
              ),
            ),
            SizedBox(height: 8),
            const Text(
              'Quelques secondes et c\'est parti.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 40),
            AppTextField(
              label: 'Nom',
              hintText: 'BARRO',
              prefixIcon: Icons.person_outline,
              controller: _nomController,
            ),
            SizedBox(height: 24),
            AppTextField(
              label: 'Prénom',
              hintText: 'Souleymane',
              prefixIcon: Icons.person_outline,
              controller: _prenomController,
            ),
            SizedBox(height: 24),
            AppTextField(
              label: 'Nom d\'utilisateur',
              hintText: 'souleymane19',
              prefixIcon: Icons.alternate_email,
              controller: _usernameController,
            ),
            SizedBox(height: 24),
            AppTextField(
              label: 'Adresse Email',
              hintText: 'souleymane@gmail.com',
              prefixIcon: Icons.email_outlined,
              controller: _emailController,
            ),
            SizedBox(height: 24),
            AppTextField(
              label: 'Mot de passe',
              hintText: '••••••••••••',
              prefixIcon: Icons.lock_outline,
              obscureText: true,
              controller: _passwordController,
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Checkbox(
                  value: _isChecked,
                  onChanged: (value) {
                    setState(() {
                      _isChecked = value!;
                    });
                  },
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
              label: _isLoading ? 'Création...' : 'Créer mon compte',
              onTap: _isLoading ? () {} : _register,
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
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}