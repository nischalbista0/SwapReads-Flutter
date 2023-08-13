import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../domain/entity/profile_entity.dart';
import '../viewmodel/profile_view_model.dart';

class EditProfileView extends ConsumerStatefulWidget {
  const EditProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<EditProfileView> createState() => _EditProfileViewState();
}

class _EditProfileViewState extends ConsumerState<EditProfileView> {
  double screenHeight = window.physicalSize.height / window.devicePixelRatio;

  // Create form key and text editing controllers
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bioController = TextEditingController();
  final _phoneNumberController = TextEditingController();

  @override
  void initState() {
    super.initState();
    var userState = ref.read(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;
    if (userData.isNotEmpty) {
      _fullNameController.text = userData[0].fullname;
      _usernameController.text = userData[0].username;
      _emailController.text = userData[0].email;
      _bioController.text = userData[0].bio ?? '';
      _phoneNumberController.text = userData[0].phoneNumber ?? '';
    }
  }

  @override
  void dispose() {
    // Dispose the text editing controllers
    _fullNameController.dispose();
    _usernameController.dispose();
    _bioController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;

    var profileState = ref.watch(profileViewModelProvider.notifier);

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
                                  Text(
                                    userData[0].bio ?? 'No bio',
                                    style: const TextStyle(
                                      fontSize: 15.0,
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
                                        'Edit Profile',
                                        style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                        controller: _fullNameController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Full Name is required';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Full Name',
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                          ),
                                          labelText: 'Full Name',
                                          labelStyle: TextStyle(
                                            color: Colors.grey[700],
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                        controller: _usernameController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Username is required';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Username',
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                          ),
                                          labelText: 'Username',
                                          labelStyle: TextStyle(
                                            color: Colors.grey[700],
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                        controller: _emailController,
                                        validator: (value) {
                                          if (value!.isEmpty) {
                                            return 'Email is required';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Email',
                                          hintStyle: TextStyle(
                                            color: Colors.grey[400],
                                          ),
                                          labelText: 'Email',
                                          labelStyle: TextStyle(
                                            color: Colors.grey[700],
                                          ),
                                          filled: true,
                                          fillColor: Colors.grey[200],
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            borderSide: BorderSide.none,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                        controller: _bioController,
                                        decoration: InputDecoration(
                                          hintText: 'Bio',
                                          labelText: "Bio (Optional)",
                                          labelStyle: TextStyle(
                                            color: Colors.grey[700],
                                          ),
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
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextFormField(
                                        controller: _phoneNumberController,
                                        decoration: InputDecoration(
                                          hintText: 'Phone number',
                                          labelText: "Phone number (Optional)",
                                          labelStyle: TextStyle(
                                            color: Colors.grey[700],
                                          ),
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
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              // Create a new profile entity
                                              ProfileEntity profile =
                                                  ProfileEntity(
                                                fullname:
                                                    _fullNameController.text,
                                                username:
                                                    _usernameController.text,
                                                email: _emailController.text,
                                                bio: _bioController.text,
                                                phoneNumber:
                                                    _phoneNumberController.text,
                                              );

                                              // Call the edit profile method
                                              await profileState
                                                  .editProfile(profile);

                                              await ref
                                                  .read(profileViewModelProvider
                                                      .notifier)
                                                  .getUserInfo();

                                              showSnackBar(
                                                context: context,
                                                message:
                                                    'Profile edited successfully',
                                                color: Colors.green,
                                              );
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
                                            'Save Changes',
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
