import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/constants/api_endpoint.dart';
import '../../../../core/common/provider/network_connection.dart';
import '../../../../core/common/snackbar/my_snackbar.dart';
import '../viewmodel/exchange_request_view_model.dart';

enum RequestStatus { pending, accepted, all }

class ExchangeRequestsView extends ConsumerStatefulWidget {
  const ExchangeRequestsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ExchangeRequestsView> createState() =>
      _ExchangeRequestsViewState();
}

class _ExchangeRequestsViewState extends ConsumerState<ExchangeRequestsView> {
  RequestStatus selectedStatus = RequestStatus.all;

  // Function to open Gmail
  void _sendEmail(String gmailAccount) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: gmailAccount,
      queryParameters: {
        'subject': 'SwapReads',
      },
    );
    launchUrl(emailLaunchUri);
  }

  @override
  Widget build(BuildContext context) {
    var exchangeRequestsState = ref.watch(exchangeRequestViewModelProvider);
    var exchangeRequestsData = exchangeRequestsState.exchangeRequests;

    var filteredRequests = exchangeRequestsData.where((request) {
      if (selectedStatus == RequestStatus.pending) {
        return request.status == 'pending';
      } else if (selectedStatus == RequestStatus.accepted) {
        return request.status == 'accepted';
      } else if (selectedStatus == RequestStatus.all) {
        return true;
      }
      return false;
    }).toList();

    bool hasPendingRequests = filteredRequests.any(
      (exchangeRequest) => exchangeRequest.status == 'pending',
    );

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Exchange Requests'),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(15),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(exchangeRequestViewModelProvider.notifier)
                .getExchangeRequests();
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
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child:
                                CupertinoSlidingSegmentedControl<RequestStatus>(
                              groupValue: selectedStatus,
                              onValueChanged: (value) {
                                setState(() {
                                  selectedStatus = value!;
                                });
                              },
                              children: const {
                                RequestStatus.pending: Text('Pending'),
                                RequestStatus.accepted: Text('Accepted'),
                                RequestStatus.all: Text('All'),
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          Expanded(
                            child: exchangeRequestsState.isLoading
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : filteredRequests.isEmpty
                                    ? const Center(
                                        child: Column(
                                          children: [
                                            SizedBox(height: 50),
                                            Text('No requests found')
                                          ],
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: filteredRequests.length,
                                        itemBuilder: (context, index) {
                                          var exchangeRequest =
                                              filteredRequests[index];
                                          print(exchangeRequest.toJson());

                                          return Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 1,
                                                  blurRadius: 2,
                                                  offset: const Offset(0, 1),
                                                ),
                                              ],
                                            ),
                                            padding:
                                                const EdgeInsets.all(8.0),
                                            margin: const EdgeInsets.only(
                                                bottom: 15.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .center,
                                                  children: [
                                                    Container(
                                                      height: 80,
                                                      width: 60,
                                                      decoration:
                                                          BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    8.0),
                                                        image:
                                                            DecorationImage(
                                                          image: NetworkImage(
                                                              exchangeRequest
                                                                          .proposalBookCover ==
                                                                      ""
                                                                  ? 'https://img.freepik.com/premium-photo/picture-image-symbol-blue-background_172429-2022.jpg'
                                                                  : '${ApiEndpoints.baseUrl}/uploads/${exchangeRequest.proposalBookCover}'),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            exchangeRequest
                                                                .proposalBookTitle!,
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 2),
                                                          Text(
                                                            '@${exchangeRequest.proposalBookAuthor!}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        14),
                                                          ),
                                                          const SizedBox(
                                                              height: 3),
                                                          Text(
                                                            '${exchangeRequest.formattedCreatedAt}',
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(width: 10),
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      child: exchangeRequest
                                                                  .status ==
                                                              'accepted'
                                                          ? Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .message),
                                                                  color: Colors
                                                                      .blue,
                                                                  onPressed:
                                                                      () async {
                                                                    _sendEmail(
                                                                        exchangeRequest
                                                                            .requester!['email']);
                                                                  },
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .delete),
                                                                  color: Colors
                                                                      .red,
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text('Remove Request'),
                                                                          content:
                                                                              const Text('Are you sure you want to remove this request?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                ref.read(exchangeRequestViewModelProvider.notifier).declineExchangeRequest(exchangeRequest.exchangeRequestId!);

                                                                                ref.read(exchangeRequestViewModelProvider.notifier).getExchangeRequests();

                                                                                Navigator.pop(context);
                                                                                showSnackBar(
                                                                                  context: context,
                                                                                  message: 'Request removed successfully',
                                                                                  color: Colors.green,
                                                                                );
                                                                              },
                                                                              child: const Text('Remove'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            )
                                                          : Row(
                                                              mainAxisSize:
                                                                  MainAxisSize
                                                                      .min,
                                                              children: [
                                                                // IconButton(
                                                                //   icon: const Icon(Icons.message),
                                                                //   color: Colors.blue,
                                                                //   onPressed: () {},
                                                                // ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .check),
                                                                  color: Colors
                                                                      .green,
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text('Accept Request'),
                                                                          content:
                                                                              const Text('Are you sure you want to accept this request?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                ref.read(exchangeRequestViewModelProvider.notifier).acceptExchangeRequest(exchangeRequest.exchangeRequestId!);

                                                                                ref.read(exchangeRequestViewModelProvider.notifier).getExchangeRequests();

                                                                                Navigator.pop(context);
                                                                                showSnackBar(
                                                                                  context: context,
                                                                                  message: 'Request accepted',
                                                                                  color: Colors.green,
                                                                                );
                                                                              },
                                                                              child: const Text('Accept'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                                IconButton(
                                                                  icon: const Icon(
                                                                      Icons
                                                                          .close),
                                                                  color: Colors
                                                                      .red,
                                                                  onPressed:
                                                                      () {
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text('Decline Request'),
                                                                          content:
                                                                              const Text('Are you sure you want to decline this request?'),
                                                                          actions: [
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: const Text('Cancel'),
                                                                            ),
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                ref.read(exchangeRequestViewModelProvider.notifier).declineExchangeRequest(exchangeRequest.exchangeRequestId!);

                                                                                ref.read(exchangeRequestViewModelProvider.notifier).getExchangeRequests();

                                                                                Navigator.pop(context);
                                                                                showSnackBar(
                                                                                  context: context,
                                                                                  message: 'Request declined',
                                                                                  color: Colors.green,
                                                                                );
                                                                              },
                                                                              child: const Text('Decline'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );
                                                                  },
                                                                ),
                                                              ],
                                                            ),
                                                    ),
                                                  ],
                                                ),
                                                const Divider(),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Requested Book : ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      exchangeRequest
                                                              .requestedBook![
                                                          'title'],
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Wrap(
                                                  alignment:
                                                      WrapAlignment.center,
                                                  children: [
                                                    const Text(
                                                      "Message : ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      exchangeRequest.message,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    const Text(
                                                      "Status : ",
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                    Text(
                                                      exchangeRequest.status!,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                          ),
                        ],
                      ),
                    );
                  }
                }
              }),
        ));
  }
}
