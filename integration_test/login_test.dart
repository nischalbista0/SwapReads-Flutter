import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import "package:integration_test/integration_test.dart";
import 'package:mockito/mockito.dart';
import 'package:swapreads/config/router/app_route.dart';
import 'package:swapreads/features/auth/domain/use_case/auth_usecase.dart';
import 'package:swapreads/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:swapreads/features/exchange_requests/domain/entity/exchange_request_entity.dart';
import 'package:swapreads/features/exchange_requests/domain/use_case/exchange_request_use_case.dart';
import 'package:swapreads/features/home/domain/entity/book_entity.dart';
import 'package:swapreads/features/home/domain/use_case/home_use_case.dart';
import 'package:swapreads/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:swapreads/features/user_profile/domain/entity/profile_entity.dart';
import 'package:swapreads/features/user_profile/domain/use_case/profile_use_case.dart';
import 'package:swapreads/features/user_profile/presentation/viewmodel/profile_view_model.dart';

import '../test/unit_test/auth_test.mocks.dart';
import '../test/unit_test/home_test.mocks.dart';
import '../test_data/book_entity_test.dart';
import '../test_data/exchange_entity_test.dart';
import '../test_data/profile_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late AuthUseCase mockAuthUsecase;
  late HomeUseCase mockHomeUseCase;
  late ExchangeRequestUseCase mockExchangeRequestUseCase;
  late List<BookEntity> allBooks;
  late List<BookEntity> userBooks;
  late List<BookEntity> bookmarkedBooks;
  late List<ProfileEntity> profileEntity;
  late List<ExchangeRequestEntity> exchangeRequestEntity;
  late ProfileUseCase mockProfileUseCase;
  late bool isLogin;

  setUpAll(() async {
    mockAuthUsecase = MockAuthUseCase();
    mockHomeUseCase = MockHomeUseCase();
    mockExchangeRequestUseCase = MockExchangeRequestUseCase();
    mockProfileUseCase = MockProfileUseCase();
    allBooks = await getAllBooks();
    userBooks = await getUserBooks();
    bookmarkedBooks = await getBookmarkedBooks();
    profileEntity = await getProfileTest();
    exchangeRequestEntity = await getExchangeRequestsList();
    isLogin = true;
  });

  testWidgets('login test with username and password and open dashboard',
      (tester) async {
    when(mockAuthUsecase.loginUser('nischal', 'nischal'))
        .thenAnswer((_) async => Right(isLogin));
    when(mockHomeUseCase.getAllBooks())
        .thenAnswer((_) async => Right(allBooks));
    when(mockHomeUseCase.getUserBooks())
        .thenAnswer((_) async => Right(userBooks));
    when(mockHomeUseCase.getBookmarkedBooks())
        .thenAnswer((_) async => Right(bookmarkedBooks));
    when(mockProfileUseCase.getUserInfo())
        .thenAnswer((_) async => Right(profileEntity));
    when(mockExchangeRequestUseCase.getExchangeRequests())
        .thenAnswer((_) async => Right(exchangeRequestEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider
              .overrideWith((ref) => AuthViewModel(mockAuthUsecase)),
          homeViewModelProvider
              .overrideWith((ref) => HomeViewModel(mockHomeUseCase)),
          profileViewModelProvider
              .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.loginRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'nischal');
    await tester.enterText(find.byType(TextFormField).at(1), 'nischal');

    final loginbuttonFinder = find.widgetWithText(ElevatedButton, 'Login');

    await tester.dragUntilVisible(
      loginbuttonFinder,
      find.byType(SingleChildScrollView),
      const Offset(201.4, 574.7),
    );

    await tester.tap(loginbuttonFinder);

    await tester.pumpAndSettle();

    expect(find.text('SwapReads'), findsOneWidget);
  });
}
