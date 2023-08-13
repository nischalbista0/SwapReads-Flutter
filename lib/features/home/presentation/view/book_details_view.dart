import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swapreads/features/home/presentation/viewmodel/home_view_model.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../config/constants/app_color_theme.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../../../exchange_requests/presentation/view/create_exchange_request.dart';
import '../../../exchange_requests/presentation/viewmodel/exchange_request_view_model.dart';
import '../../../home/domain/entity/book_entity.dart';

class BookDetailsView extends ConsumerStatefulWidget {
  final BookEntity? book;
  const BookDetailsView({super.key, this.book});

  @override
  ConsumerState<BookDetailsView> createState() => _BookDetailsViewState();
}

class _BookDetailsViewState extends ConsumerState<BookDetailsView> {
  // ignore: deprecated_member_use
  double screenHeight = window.physicalSize.height / window.devicePixelRatio;

  @override
  Widget build(BuildContext context) {
    final book = widget.book;

    final homeViewModel = ref.watch(homeViewModelProvider.notifier);

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
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
                    Positioned(
                      top: 10,
                      right: 5,
                      child: IconButton(
                        icon: book?.isBookmarked == true
                            ? const Icon(Icons.bookmark)
                            : const Icon(Icons.bookmark_border_rounded),
                        color: Colors.white,
                        iconSize: 30,
                        onPressed: () async {
                          if (book?.isBookmarked == true) {
                            ref
                                .watch(homeViewModelProvider.notifier)
                                .unbookmarkBook(book!.bookId!);
                          } else {
                            ref
                                .watch(homeViewModelProvider.notifier)
                                .bookmarkBook(book!.bookId!);
                          }

                          ref
                              .watch(homeViewModelProvider.notifier)
                              .getAllBooks();

                          ref
                              .watch(homeViewModelProvider.notifier)
                              .getBookmarkedBooks();

                          showSnackBar(
                            message: book.isBookmarked == true
                                ? 'Book unbookmarked'
                                : 'Book bookmarked',
                            context: context,
                            color: Colors.green,
                          );
                        },
                      ),
                    ),
                    Positioned(
                        width: MediaQuery.of(context).size.width,
                        top: 70,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "@${book!.user!['username']}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Posted ${book.formattedCreatedAt}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Container(
                                    height: 180,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: const Offset(0, 3),
                                        ),
                                      ],
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          '${ApiEndpoints.baseUrl}/uploads/${book.bookCover}',
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            book.title,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            book.author,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              color: Colors.white,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.my_library_books,
                                                color: Colors.greenAccent,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                book.genre,
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.language,
                                                color: Colors.greenAccent,
                                                size: 20,
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                book.language,
                                                style: const TextStyle(
                                                  fontSize: 15.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ]),
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                    Container(
                      margin: const EdgeInsets.only(top: 350.0),
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                      constraints: BoxConstraints(
                        minHeight: screenHeight - 345,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Description:",
                                style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                book.description,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          ElevatedButton(
                            onPressed: () async {
                              await ref
                                  .watch(homeViewModelProvider.notifier)
                                  .getBookById(book.bookId!);

                              await ref
                                  .watch(
                                      exchangeRequestViewModelProvider.notifier)
                                  .getExchangeRequests();

                              final exchangeRequests = ref
                                  .read(exchangeRequestViewModelProvider)
                                  .exchangeRequests;
                              print(exchangeRequests);

                              final requestedBook =
                                  ref.read(homeViewModelProvider).bookById;

                              if (!context.mounted) return;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CreateExchangeRequestView(
                                          bookId: book.bookId!,
                                          requestedBook: requestedBook),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                                vertical: 15.0,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            child: const Text(
                              'Request Book',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
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
