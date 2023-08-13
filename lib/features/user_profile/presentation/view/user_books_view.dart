import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swapreads/config/router/app_route.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/app_color_theme.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../home/domain/entity/book_entity.dart';
import '../../../home/presentation/viewmodel/home_view_model.dart';
import '../../domain/entity/profile_entity.dart';
import '../viewmodel/profile_view_model.dart';

class UserBooksView extends ConsumerStatefulWidget {
  const UserBooksView({Key? key}) : super(key: key);

  @override
  ConsumerState<UserBooksView> createState() => _UserBooksViewState();
}

class _UserBooksViewState extends ConsumerState<UserBooksView> {
  double screenHeight = window.physicalSize.height / window.devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(profileViewModelProvider);
    List<ProfileEntity> userData = userState.usersData;

    var userBooksState = ref.watch(homeViewModelProvider);
    List<BookEntity> userBooks = userBooksState.userBooks;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(homeViewModelProvider.notifier).getUserBooks();
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Stack(children: [
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
                    decoration: BoxDecoration(
                      color: AppColors.tertiaryColor,
                      borderRadius: const BorderRadius.only(
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
                                    fontSize: 22.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '@${userData[0].username}',
                                  style: const TextStyle(
                                    fontSize: 16.0,
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
                          child: Column(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Your Books',
                                    style: TextStyle(
                                      fontSize: 22.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 20.0),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: userBooks.isEmpty
                                        ? 1
                                        : userBooks.length,
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(height: 15.0);
                                    },
                                    itemBuilder: (context, index) {
                                      if (userBooks.isEmpty) {
                                        return const Center(
                                          child: Text(
                                            'You have not uploaded any books yet.',
                                            style: TextStyle(
                                                fontSize: 18.0,
                                                color: Colors.black),
                                          ),
                                        );
                                      }

                                      final book = userBooks[index];
                                      return SizedBox(
                                        width:
                                            200.0, // Adjust the width as needed
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              bottom: 10.0),
                                          padding: const EdgeInsets.all(10.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.5),
                                                spreadRadius: 2.0,
                                                blurRadius: 5.0,
                                                offset: const Offset(0, 3),
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    icon:
                                                        const Icon(Icons.edit),
                                                    color: Colors.blue,
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        AppRoute
                                                            .updateBookRoute,
                                                        arguments: book,
                                                      );
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
                                                    color: Colors.red,
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Delete Book'),
                                                            content: const Text(
                                                                'Are you sure you want to delete this book?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: const Text(
                                                                    'Cancel'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  ref
                                                                      .watch(homeViewModelProvider
                                                                          .notifier)
                                                                      .deleteBook(
                                                                          book.bookId!);

                                                                  ref
                                                                      .watch(homeViewModelProvider
                                                                          .notifier)
                                                                      .getUserBooks();

                                                                  Navigator.pop(
                                                                      context);
                                                                  showSnackBar(
                                                                    context:
                                                                        context,
                                                                    message:
                                                                        'Book deleted successfully!',
                                                                    color: Colors
                                                                        .lightGreen,
                                                                  );
                                                                },
                                                                child: const Text(
                                                                    'Delete'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    child: Image.network(
                                                      // '${ApiEndpoints.baseUrl}uploads/${book.bookCover}' ??
                                                      //     'https://img.freepik.com/premium-photo/picture-image-symbol-blue-background_172429-2022.jpg',
                                                      book.bookCover == ""
                                                          ? 'https://img.freepik.com/premium-photo/picture-image-symbol-blue-background_172429-2022.jpg'
                                                          : '${ApiEndpoints.baseUrl}uploads/${book.bookCover}',
                                                      width: 80.0,
                                                      height: 120.0,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10.0),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          book.title,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 17.0,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            height: 5.0),
                                                        Text(
                                                          'By ${book.author}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      16.0),
                                                        ),
                                                        const SizedBox(
                                                            height: 5.0),
                                                        Text(
                                                          book.genre,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize:
                                                                      16.0),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(height: 10.0),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
