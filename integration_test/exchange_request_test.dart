import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:swapreads/config/router/app_route.dart';
import 'package:swapreads/features/exchange_requests/domain/entity/exchange_request_entity.dart';
import 'package:swapreads/features/exchange_requests/domain/use_case/exchange_request_use_case.dart';
import 'package:swapreads/features/exchange_requests/presentation/viewmodel/exchange_request_view_model.dart';

import '../build/unit_test_assets/test_data/exchange_entity_test.dart';
import '../test/unit_test/home_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late ExchangeRequestUseCase mockExchangeRequestUseCase;
  late List<ExchangeRequestEntity> exchangeRequestEntity;

  setUpAll(() async {
    mockExchangeRequestUseCase = MockExchangeRequestUseCase();
    exchangeRequestEntity = await getExchangeRequestsList();
  });

  testWidgets('Exchange Request View', (tester) async {
    when(mockExchangeRequestUseCase.getExchangeRequests())
        .thenAnswer((_) async => Right(exchangeRequestEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          exchangeRequestViewModelProvider
              .overrideWith((ref) => ExchangeRequestViewModel(mockExchangeRequestUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.exchangeRequestView,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Exchange Requests'), findsOneWidget);
  });
}
