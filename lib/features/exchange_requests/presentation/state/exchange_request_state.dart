import '../../domain/entity/exchange_request_entity.dart';

class ExchangeRequestState {
  final bool isLoading;
  final List<ExchangeRequestEntity> exchangeRequests;
  final String? error;

  ExchangeRequestState({
    required this.isLoading,
    required this.exchangeRequests,
    this.error,
  });

  factory ExchangeRequestState.initial() {
    return ExchangeRequestState(isLoading: false, exchangeRequests: []);
  }

  ExchangeRequestState copyWith({
    bool? isLoading,
    List<ExchangeRequestEntity>? exchangeRequests,
    String? error,
  }) {
    return ExchangeRequestState(
      isLoading: isLoading ?? this.isLoading,
      exchangeRequests: exchangeRequests ?? this.exchangeRequests,
      error: error ?? this.error,
    );
  }
}
