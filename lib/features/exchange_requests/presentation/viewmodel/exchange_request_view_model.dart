import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entity/exchange_request_entity.dart';
import '../../domain/use_case/exchange_request_use_case.dart';
import '../state/exchange_request_state.dart';

final exchangeRequestViewModelProvider =
    StateNotifierProvider<ExchangeRequestViewModel, ExchangeRequestState>(
  (ref) => ExchangeRequestViewModel(ref.read(exchangeRequestUsecaseProvider)),
);

class ExchangeRequestViewModel extends StateNotifier<ExchangeRequestState> {
  final ExchangeRequestUseCase exchangeRequestUseCase;

  ExchangeRequestViewModel(this.exchangeRequestUseCase)
      : super(ExchangeRequestState.initial()) {
    getExchangeRequests();
  }

  getExchangeRequests() async {
    state = state.copyWith(isLoading: true);
    var data = await exchangeRequestUseCase.getExchangeRequests();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state =
          state.copyWith(isLoading: false, exchangeRequests: r, error: null),
    );
  }

  createExchangeRequest(
      ExchangeRequestEntity exchangeRequest, String requestedBook) async {
    state = state.copyWith(isLoading: true);
    var data = await exchangeRequestUseCase.createExchangeRequest(
        exchangeRequest, requestedBook);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  acceptExchangeRequest(String requestId) async {
    state = state.copyWith(isLoading: true);
    var data = await exchangeRequestUseCase.acceptExchangeRequest(requestId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  declineExchangeRequest(String requestId) async {
    state = state.copyWith(isLoading: true);
    var data = await exchangeRequestUseCase.declineExchangeRequest(requestId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }
}
