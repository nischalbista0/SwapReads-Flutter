import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../../config/router/app_route.dart';
import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/app_color_theme.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../../home/presentation/viewmodel/home_view_model.dart';
import '../../domain/entity/profile_entity.dart';
import '../viewmodel/logout_view_model.dart';
import '../viewmodel/profile_view_model.dart';

class MoreView extends ConsumerStatefulWidget {
  const MoreView({Key? key}) : super(key: key);

  @override
  ConsumerState<MoreView> createState() => _MoreViewState();
}

class _MoreViewState extends ConsumerState<MoreView> {
  checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? img;
  Future _browseImage(WidgetRef ref, ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          img = File(image.path);
          ref.read(profileViewModelProvider.notifier).uploadImage(img!);
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;

    var userBooksState = ref.watch(homeViewModelProvider);

    // if (userState.isLoading) {
    //   return const Center(
    //     child: CircularProgressIndicator(),
    //   );
    // }

    return Scaffold(
      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: const Text('Your Profile'),
      //   shape: const RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(15),
      //     ),
      //   ),
      // ),
      backgroundColor: AppColors.secondaryColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(profileViewModelProvider.notifier).getUserInfo();
          await ref.read(homeViewModelProvider.notifier).getUserBooks();
          await ref.read(homeViewModelProvider.notifier).getBookmarkedBooks();
        },
        child: FutureBuilder<bool>(
            future: checkConnectivity(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error: ${snapshot.error}'),
                );
              } else {
                final isNetworkConnected = snapshot.data ?? false;

                if (!isNetworkConnected) {
                  // If no internet, show the "No Internet" message.
                  return const Center(
                    child: Text('No Internet Connection'),
                  );
                } else {
                  userState.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container();
                  return userState.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : Center(
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                const SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet(
                                      backgroundColor: AppColors.secondaryColor,
                                      context: context,
                                      isScrollControlled: true,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(20),
                                        ),
                                      ),
                                      builder: (context) => Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                _browseImage(
                                                    ref, ImageSource.camera);
                                                Navigator.pop(context);
                                              },
                                              icon: const Icon(Icons.camera),
                                              label: const Text('Camera'),
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: () {
                                                _browseImage(
                                                    ref, ImageSource.gallery);
                                                Navigator.pop(context);

                                                setState(() {
                                                  ref
                                                      .read(
                                                          profileViewModelProvider
                                                              .notifier)
                                                      .getUserInfo();
                                                });
                                              },
                                              icon: const Icon(Icons.image),
                                              label: const Text('Gallery'),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  child: CircleAvatar(
                                    radius: 65,
                                    backgroundImage: img != null
                                        ? FileImage(img!)
                                        : userData.isNotEmpty &&
                                                userData[0].image != null
                                            ? NetworkImage(
                                                '${ApiEndpoints.baseUrl}/uploads/${userData[0].image}',
                                              ) as ImageProvider
                                            : const AssetImage(
                                                'assets/images/user.png'),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Column(
                                  children: [
                                    Text(
                                      userData[0].fullname,
                                      style: const TextStyle(
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      '@${userData[0].username}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black54,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      userData[0].bio ?? 'No bio',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Your Total Books',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            userBooksState.userBooks.length
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 50.0,
                                      child: VerticalDivider(
                                        thickness: 2.0,
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Bookmarked',
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            userBooksState
                                                .bookmarkedBooks.length
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0, vertical: 8),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                AppRoute.userBooksRoute);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            alignment: Alignment.centerLeft,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            elevation: 2.0,
                                            padding: const EdgeInsets.all(15),
                                          ),
                                          icon: const Icon(
                                            Icons.book,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Manage Your Books',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                AppRoute.bookmarkedBooksRoute);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            alignment: Alignment.centerLeft,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            elevation: 2.0,
                                            padding: const EdgeInsets.all(15),
                                          ),
                                          icon: const Icon(
                                            Icons.bookmark,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Bookmarked Books',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                AppRoute.editProfileRoute);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            alignment: Alignment.centerLeft,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            elevation: 2.0,
                                            padding: const EdgeInsets.all(15),
                                          ),
                                          icon: const Icon(
                                            Icons.manage_accounts,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Edit Profile',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.pushNamed(context,
                                                AppRoute.changePasswordRoute);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            alignment: Alignment.centerLeft,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            elevation: 2.0,
                                            padding: const EdgeInsets.all(15),
                                          ),
                                          icon: const Icon(
                                            Icons.lock,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Change Password',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            ref
                                                .read(logoutViewModelProvider
                                                    .notifier)
                                                .logout(context);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primaryColor,
                                            alignment: Alignment.centerLeft,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            elevation: 2.0,
                                            padding: const EdgeInsets.all(15),
                                          ),
                                          icon: const Icon(
                                            Icons.logout,
                                            color: Colors.white,
                                          ),
                                          label: const Text(
                                            'Log out',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12.0),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                }
              }
            }),
      ),
    );
  }
}
