import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tasky/controllers/auth_controller.dart';
import 'package:tasky/widgets/text_field.widget.dart';
import 'package:tasky/widgets/button.widget.dart';

class PersonalInfoScreen extends StatefulWidget {
  final String nom;
  final String prenom;
  final String email;

  const PersonalInfoScreen({
    super.key,
    required this.nom,
    required this.prenom,
    required this.email,
  });

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final AuthController _authController = AuthController();
  late TextEditingController _nomController;
  late TextEditingController _prenomController;
  late TextEditingController _emailController;
  bool _isLoading = false;
  String? _photoBase64;

  @override
  void initState() {
    super.initState();
    _nomController = TextEditingController(text: widget.nom);
    _prenomController = TextEditingController(text: widget.prenom);
    _emailController = TextEditingController(text: widget.email);
  }

  Future<void> _pickPhoto() async {
    final result = await _authController.pickProfileImage();
    if (result != null) {
      setState(() {
        _photoBase64 = result;
      });
    }
  }

  Future<void> _save() async {
    if (_nomController.text.isEmpty ||
        _prenomController.text.isEmpty ||
        _emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tous les champs sont obligatoires')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _authController.updateProfile(
        nom: _nomController.text,
        prenom: _prenomController.text,
        email: _emailController.text,
        photo: _photoBase64,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white, size: 20),
                SizedBox(width: 8),
                Text('Profil mis à jour !'),
              ],
            ),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        Navigator.pop(context, true); // true = profil modifié
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la mise à jour')),
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
      backgroundColor: Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              // Header
              Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.arrow_back, size: 24),
                    ),
                  ),
                  Text(
                    'Informations personnelles',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              // Avatar cliquable
              Center(
                child: GestureDetector(
                  onTap: _pickPhoto,
                  child: Stack(
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFF6B5C).withOpacity(0.15),
                          image: _photoBase64 != null
                              ? DecorationImage(
                                  image: MemoryImage(
                                      base64Decode(_photoBase64!)),
                                  fit: BoxFit.cover,
                                )
                              : null,
                        ),
                        child: _photoBase64 == null
                            ? Icon(
                                Icons.person,
                                size: 40,
                                color: Color(0xFFFF6B5C),
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color(0xFFFF6B5C),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  'Modifier la photo',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 24),
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
                label: 'Adresse Email',
                hintText: 'souleymane@gmail.com',
                prefixIcon: Icons.email_outlined,
                controller: _emailController,
              ),
              SizedBox(height: 40),
              AppButton(
                label: _isLoading ? 'Enregistrement...' : 'Enregistrer',
                onTap: _isLoading ? () {} : _save,
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}