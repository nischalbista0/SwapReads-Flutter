import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/password_entity.dart';
import '../../domain/entity/profile_entity.dart';
import '../viewmodel/password_view_model.dart';
import '../viewmodel/profile_view_model.dart';
import '../../../../config/constants/api_endpoint.dart';

class ChangePasswordView extends ConsumerStatefulWidget {
  const ChangePasswordView({Key? key}) : super(key: key);

  @override
  ConsumerState<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends ConsumerState<ChangePasswordView> {
  double screenHeight = window.physicalSize.height / window.devicePixelRatio;

  // Create form key and text editing controllers
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmNewPasswordController = TextEditingController();

  bool _obscureOldPassword = true;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  void _toggleOldPasswordVisibility() {
    setState(() {
      _obscureOldPassword = !_obscureOldPassword;
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  void dispose() {
    // Dispose the text editing controllers
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmNewPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;

    var passwordState = ref.watch(passwordViewModelProvider);

    return Scaffold(
      backgroundColor: const Color(0xFF0166AA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Stack(
                  children: [
                    Positioned(
                      top: 10,
                      left: 5,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 180.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      constraints: BoxConstraints(
                        minHeight: screenHeight - 180.0,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            top: -60,
                            left: 0,
                            right: 0,
                            child: Center(
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 3.0,
                                  ),
                                ),
                                child: CircleAvatar(
                                  radius: 60,
                                  backgroundColor: Colors.white,
                                  child: CircleAvatar(
                                    radius: 100,
                                    backgroundImage: userData[0].image != null
                                        ? NetworkImage(
                                            '${ApiEndpoints.baseUrl}/uploads/${userData[0].image}',
                                          ) as ImageProvider
                                        : const AssetImage(
                                            'assets/images/user.png'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 80.0),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    userData[0].fullname,
                                    style: const TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '@${userData[0].username}',
                                    style: const TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 160.0,
                              left: 18.0,
                              right: 18.0,
                              bottom: 18.0,
                            ),
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Change Password',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                        controller: _oldPasswordController,
                                        obscureText: _obscureOldPassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Old Password is required';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Old Password',
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: _obscureOldPassword
                                                ? const Icon(
                                                    Icons.visibility_off)
                                                : const Icon(Icons.visibility),
                                            onPressed:
                                                _toggleOldPasswordVisibility,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                        controller: _newPasswordController,
                                        obscureText: _obscurePassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'New Password is required';
                                          }
                                          if (value.length < 8) {
                                            return 'New Password must be at least 8 characters long';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'New Password',
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: _obscurePassword
                                                ? const Icon(
                                                    Icons.visibility_off)
                                                : const Icon(Icons.visibility),
                                            onPressed:
                                                _togglePasswordVisibility,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                        controller:
                                            _confirmNewPasswordController,
                                        obscureText: _obscureConfirmPassword,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Confirm New Password is required';
                                          }
                                          if (value !=
                                              _newPasswordController.text) {
                                            return 'New Password and Confirm New Password must match';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Confirm New Password',
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                          suffixIcon: IconButton(
                                            icon: _obscureConfirmPassword
                                                ? const Icon(
                                                    Icons.visibility_off)
                                                : const Icon(Icons.visibility),
                                            onPressed:
                                                _toggleConfirmPasswordVisibility,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              ref
                                                  .read(
                                                      passwordViewModelProvider
                                                          .notifier)
                                                  .changePassword(
                                                    PasswordEntity(
                                                      oldPassword:
                                                          _oldPasswordController
                                                              .text,
                                                      newPassword:
                                                          _newPasswordController
                                                              .text,
                                                      confirmPassword:
                                                          _confirmNewPasswordController
                                                              .text,
                                                    ),
                                                  );

                                              if (passwordState.error != null) {
                                                showSnackBar(
                                                  context: context,
                                                  message: passwordState.error!,
                                                  color: Colors.red,
                                                );
                                              } else {
                                                _oldPasswordController.clear();
                                                _newPasswordController.clear();
                                                _confirmNewPasswordController
                                                    .clear();

                                                showSnackBar(
                                                  context: context,
                                                  message:
                                                      'Password changed successfully',
                                                  color: Colors.green,
                                                );
                                              }
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color(0xFF0166AA),
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 16.0,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                          ),
                                          child: const Text(
                                            'Change Password',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
