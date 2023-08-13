import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:swapreads/core/failure/failure.dart';
import 'package:swapreads/features/exchange_requests/domain/entity/exchange_request_entity.dart';
import 'package:swapreads/features/exchange_requests/domain/use_case/exchange_request_use_case.dart';
import 'package:swapreads/features/exchange_requests/presentation/viewmodel/exchange_request_view_model.dart';

import '../../test_data/exchange_entity_test.dart';
import 'home_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProviderContainer container;
  late ExchangeRequestUseCase mockExchangeRequestUseCase;
  late List<ExchangeRequestEntity> exchangeRequestEntity;

  setUpAll(() async {
    mockExchangeRequestUseCase = MockExchangeRequestUseCase();
    exchangeRequestEntity = await getExchangeRequestsList();
    when(mockExchangeRequestUseCase.getExchangeRequests())
        .thenAnswer((_) async => Right(exchangeRequestEntity));

    container = ProviderContainer(
      overrides: [
        exchangeRequestViewModelProvider.overrideWith(
          (ref) => ExchangeRequestViewModel(mockExchangeRequestUseCase),
        )
      ],
    );
  });

  test('check exchange initial state', () async {
    await container.read(exchangeRequestViewModelProvider.notifier).getExchangeRequests();

    final exchangeState = container.read(exchangeRequestViewModelProvider);
    expect(exchangeState.isLoading, false);
    expect(exchangeState.exchangeRequests, isNotEmpty);
  });

  test('should get exchange request', () async {
    when(mockExchangeRequestUseCase.getExchangeRequests())
        .thenAnswer((_) => Future.value(Right(exchangeRequestEntity)));

    await container.read(exchangeRequestViewModelProvider.notifier).getExchangeRequests();

    final exchangeState = container.read(exchangeRequestViewModelProvider);

    expect(exchangeState.isLoading, false);
    expect(exchangeState.exchangeRequests.length, 1);
  });

    test('should not get exchange request', () async {
    when(mockExchangeRequestUseCase.getExchangeRequests())
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container.read(exchangeRequestViewModelProvider.notifier).getExchangeRequests();

    final watchListState = container.read(exchangeRequestViewModelProvider);

    expect(watchListState.isLoading, false);
    expect(watchListState.error, isNotNull);
  });

  tearDownAll(() {
    container.dispose();
  });
}