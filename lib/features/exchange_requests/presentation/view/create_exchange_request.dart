import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swapreads/config/constants/api_endpoint.dart';
import 'package:swapreads/core/common/snackbar/my_snackbar.dart';
import 'package:swapreads/features/exchange_requests/domain/entity/exchange_request_entity.dart';
import 'package:swapreads/features/exchange_requests/presentation/viewmodel/exchange_request_view_model.dart';
import 'package:swapreads/features/home/presentation/viewmodel/home_view_model.dart';

import '../../../home/domain/entity/book_entity.dart';

class CreateExchangeRequestView extends ConsumerStatefulWidget {
  final String bookId;
  final List<BookEntity>? requestedBook;
  const CreateExchangeRequestView(
      {super.key, this.bookId = '', this.requestedBook});

  @override
  ConsumerState<CreateExchangeRequestView> createState() =>
      _CreateExchangeRequestViewState();
}

class _CreateExchangeRequestViewState
    extends ConsumerState<CreateExchangeRequestView> {
  @override
  void initState() {
    super.initState();
    _loadUserBooks();
  }

  List<BookEntity> userBooks = [];

  final _messageController = TextEditingController();

  String _selectedBook = ''; // Initially no book selected

  Future<void> _loadUserBooks() async {
    var userBooksState = ref.read(homeViewModelProvider);
    userBooks = userBooksState.userBooks;

    _selectedBook = '';
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final bookId = widget.bookId;
    final requestedBook = widget.requestedBook;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create Exchange Request',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 180,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: NetworkImage(
                                "${ApiEndpoints.baseUrl}/uploads/${requestedBook![0].bookCover}",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.book,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    requestedBook[0].title,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    requestedBook[0].author,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.category,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    requestedBook[0].genre,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.language,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    requestedBook[0].language,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: DropdownButtonFormField<String>(
                      value: _selectedBook.isNotEmpty ? _selectedBook : null,
                      hint: const Text('Select book for proposal'),
                      icon: const Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      items: userBooks.map((item) {
                        return DropdownMenuItem<String>(
                          value: item.bookId,
                          child: Text(item.title),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedBook = value ??
                              ''; // Set the selected book or empty if null
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a book for proposal';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        border: InputBorder.none,
                      ),
                      maxLines: 5,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a message';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ExchangeRequestEntity exchangeRequest =
                          ExchangeRequestEntity(
                        proposalBook: _selectedBook,
                        message: _messageController.text,
                      );

                      ref
                          .read(exchangeRequestViewModelProvider.notifier)
                          .createExchangeRequest(
                            exchangeRequest,
                            bookId,
                          );

                      if (ref
                          .read(exchangeRequestViewModelProvider)
                          .isLoading) {
                        showSnackBar(
                          message: 'Exchange request created successfully',
                          context: context,
                          color: Colors.green,
                        );

                        Navigator.pop(context);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Create Request',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
