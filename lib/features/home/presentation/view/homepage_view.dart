import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swapreads/features/exchange_requests/presentation/view/create_exchange_request.dart';
import 'package:swapreads/features/exchange_requests/presentation/viewmodel/exchange_request_view_model.dart';

import '../../../../config/constants/app_color_theme.dart';
import '../../../../core/common/provider/internet_connectivity.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../domain/entity/book_entity.dart';
import '../viewmodel/home_view_model.dart';
import '../widget/buildBookCard.dart';
import 'book_details_view.dart';

class HomepageView extends ConsumerStatefulWidget {
  const HomepageView({Key? key}) : super(key: key);

  @override
  ConsumerState<HomepageView> createState() => _HomepageViewState();
}

class _HomepageViewState extends ConsumerState<HomepageView> {
  @override
  Widget build(BuildContext context) {
    var bookState = ref.watch(homeViewModelProvider);
    List<BookEntity> homeList = bookState.books;

    var internetState = ref.watch(connectivityStatusProvider);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('SwapReads'),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
      ),
      backgroundColor: AppColors.secondaryColor,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(homeViewModelProvider.notifier).getAllBooks();
        },
        child: bookState.isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: Column(
                      children: [
                        const SizedBox(height: 10),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: homeList.length,
                          itemBuilder: (context, index) {
                            final book = homeList[index];
                            final homeViewModel =
                                ref.read(homeViewModelProvider.notifier);
                            return FutureBuilder<bool>(
                                future: checkConnectivity(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (snapshot.hasError) {
                                    return Center(
                                      child: Text('Error: ${snapshot.error}'),
                                    );
                                  } else {
                                    final isNetworkConnected =
                                        snapshot.data ?? false;

                                    return GestureDetector(
                                      onTap: () {
                                        if (isNetworkConnected) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  BookDetailsView(book: book),
                                            ),
                                          );
                                        } else {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'No Internet Connection'),
                                                content: const Text(
                                                    'Please check your internet connection and try again.'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child: const Text('OK'),
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        }
                                      },
                                      child: buildBookCard(
                                        bookId: book.bookId!,
                                        title: book.title,
                                        author: book.author,
                                        description: book.description,
                                        genre: book.genre,
                                        language: book.language,
                                        bookCover: book.bookCover!,
                                        date: book.date!,
                                        formattedCreatedAt:
                                            book.formattedCreatedAt!,
                                        isBookmarked: book.isBookmarked!,
                                        homeViewModel: homeViewModel,
                                        context: context,
                                        user: book.user!,
                                        internetState: internetState,
                                        onPressed: () async {
                                          final requestedBook = ref
                                              .read(homeViewModelProvider)
                                              .bookById;

                                          if (!context.mounted) return;
                                          
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateExchangeRequestView(
                                                      bookId: book.bookId!,
                                                      requestedBook:
                                                          requestedBook),
                                            ),
                                          );

                                          await ref
                                              .watch(homeViewModelProvider
                                                  .notifier)
                                              .getBookById(book.bookId!);

                                          await ref
                                              .watch(
                                                  exchangeRequestViewModelProvider
                                                      .notifier)
                                              .getExchangeRequests();

                                          final exchangeRequests = ref
                                              .read(
                                                  exchangeRequestViewModelProvider)
                                              .exchangeRequests;
                                          print(exchangeRequests);

                                          
                                          
                                        },
                                      ),
                                    );
                                  }
                                });
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
