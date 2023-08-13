import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swapreads/config/constants/api_endpoint.dart';

import '../../../home/presentation/view/book_details_view.dart';
import '../viewmodel/search_view_model.dart';

class SearchView extends ConsumerStatefulWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends ConsumerState<SearchView> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    final searchState = ref.watch(searchViewModelProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEBEBEB),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(Icons.search),
                          ),
                          Expanded(
                            child: TextFormField(
                              onChanged: (value) {
                                setState(() {
                                  searchText = value;
                                  ref
                                      .watch(searchViewModelProvider.notifier)
                                      .getSearchedBooks(searchText);
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: "Search books for exchange",
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              if (searchText.isEmpty) // When nothing is searched initially
                Center(
                  child: Column(
                    children: [
                      const Text(
                        'Your search results will appear here',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: 300,
                        height: 150,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/images/search.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else if (searchState.isLoading)
                const Center(child: CircularProgressIndicator())
              // else if (searchState.searchedBooks.isEmpty)
              //   const Expanded(
              //     child: Center(
              //       child: Text('No books found'),
              //     ),
              //   )
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: searchState.searchedBooks.length,
                    itemBuilder: (context, index) {
                      final book = searchState.searchedBooks[index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookDetailsView(book: book),
                            ),
                          );
                        },
                        child: BookListItem(
                          bookCover: book.bookCover!,
                          bookTitle: book.title,
                          authorName: book.author,
                          genre: book.genre,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class BookListItem extends StatelessWidget {
  final String bookCover;
  final String bookTitle;
  final String authorName;
  final String genre;

  const BookListItem({
    super.key,
    required this.bookCover,
    required this.bookTitle,
    required this.authorName,
    required this.genre,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Book Cover
          Container(
            width: 80,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(
                image:
                    NetworkImage("${ApiEndpoints.baseUrl}/uploads/$bookCover"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Book Title
                Text(
                  bookTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Genre: $genre",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Author Name
                Text(
                  authorName,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
