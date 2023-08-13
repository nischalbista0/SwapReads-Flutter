import 'package:flutter/material.dart';
import 'package:swapreads/features/home/presentation/viewmodel/home_view_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/app_color_theme.dart';
import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';

Widget buildBookCard({
  required String bookId,
  required String title,
  required String author,
  required String description,
  required String genre,
  required String language,
  required String bookCover,
  required String date,
  required String formattedCreatedAt,
  required bool isBookmarked,
  required HomeViewModel homeViewModel,
  required BuildContext context,
  required Map<String, dynamic> user,
  required VoidCallback onPressed,
  required ConnectivityStatus internetState,
}) {
  return Column(
    children: [
      Container(
        height: 300,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            FutureBuilder<bool>(
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

                    return Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      bottom: 100,
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          image: DecorationImage(
                            image:
                                // check for internet connection
                                isNetworkConnected
                                    // ignore: unnecessary_cast
                                    ? NetworkImage(
                                            '${ApiEndpoints.baseUrl}/uploads/$bookCover')
                                        as ImageProvider<Object>
                                    : const AssetImage(
                                        'assets/images/no_internet.jpg'), // Specify the type of AssetImage

                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  }
                }),
            // const Positioned(
            //   top: 10,
            //   left: 10,
            //   child: CircleAvatar(
            //     radius: 20,
            //     backgroundImage: NetworkImage(
            //         'https://media.licdn.com/dms/image/C4E03AQFzMbkgAPQ5WA/profile-displayphoto-shrink_800_800/0/1626746224502?e=2147483647&v=beta&t=i0FMB8pQsIFJRqx4jagP_NjmwCI2tVK-bEXoUFGO2vg'),
            //   ),
            // ),
            Positioned.fill(
              top: 0,
              left: 0,
              right: 0,
              bottom: 100,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 10,
              left: 10,
              child: Text(
                '@${user['username']}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(
              top: 10,
              right: 10,
              child: IconButton(
                icon: isBookmarked
                    ? const Icon(Icons.bookmark)
                    : const Icon(Icons.bookmark_border_rounded),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {
                  if (isBookmarked) {
                    homeViewModel.unbookmarkBook(bookId);
                    showSnackBar(
                      context: context,
                      message: 'Book unbookmarked',
                      color: Colors.lightGreen,
                    );
                  } else {
                    homeViewModel.bookmarkBook(bookId);
                    showSnackBar(
                      context: context,
                      message: 'Book bookmarked',
                      color: Colors.green,
                    );
                  }

                  homeViewModel.getAllBooks();

                  homeViewModel.getBookmarkedBooks();
                },
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(height: 130, color: AppColors.tertiaryColor),
            ),
            Positioned(
              top: 110,
              left: 10,
              width: 80,
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
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
                      final imageWidget = isNetworkConnected
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  '${ApiEndpoints.baseUrl}/uploads/$bookCover',
                                  fit: BoxFit.cover),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset(
                                'assets/images/no_internet.jpg',
                                fit: BoxFit.cover,
                              ),
                            );
                      return imageWidget;
                    }
                  },
                ),
              ),
            ),
            Positioned(
              top: 175,
              left: 100,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    author,
                    style: const TextStyle(
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 250,
              left: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.calendar_view_day_rounded, size: 20),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Posted $formattedCreatedAt',
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox(height: 2),
                          // Text(
                          //   '1.4km away',
                          //   style: TextStyle(
                          //     fontSize: 12,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              top: 238,
              right: 10,
              child: ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 8,
                  ),
                  child: Text(
                    'Exchange',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
    ],
  );
}
