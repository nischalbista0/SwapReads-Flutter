import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:swapreads/core/failure/failure.dart';
import 'package:swapreads/features/exchange_requests/domain/use_case/exchange_request_use_case.dart';
import 'package:swapreads/features/home/domain/entity/book_entity.dart';
import 'package:swapreads/features/home/domain/use_case/home_use_case.dart';
import 'package:swapreads/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:swapreads/features/user_profile/domain/use_case/profile_use_case.dart';

import '../../test_data/book_entity_test.dart';
import 'home_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<HomeUseCase>(),
  MockSpec<ProfileUseCase>(),
  MockSpec<ExchangeRequestUseCase>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProviderContainer container;
  late HomeUseCase mockHomeUsecase;
  late ProfileUseCase mockProfileUsecase;
  late ExchangeRequestUseCase mockExchangeRequestUsecase;
  late List<BookEntity> homeEntity;

  setUpAll(() async {
    mockHomeUsecase = MockHomeUseCase();
    mockProfileUsecase = MockProfileUseCase();
    mockExchangeRequestUsecase = MockExchangeRequestUseCase();
    homeEntity = await getAllBooks();

    when(mockHomeUsecase.getAllBooks())
        .thenAnswer((_) async => const Right([]));
    when(mockHomeUsecase.getUserBooks())
        .thenAnswer((_) async => const Right([]));
    when(mockHomeUsecase.getBookmarkedBooks())
        .thenAnswer((_) async => const Right([]));
    when(mockProfileUsecase.getUserInfo())
        .thenAnswer((_) async => const Right([]));
    when(mockExchangeRequestUsecase.getExchangeRequests())
        .thenAnswer((_) async => const Right([]));

    container = ProviderContainer(
      overrides: [
        homeViewModelProvider.overrideWith(
          (ref) => HomeViewModel(mockHomeUsecase),
        ),
      ],
    );
  });

  test('check home initial state', () async {
    await container.read(homeViewModelProvider.notifier).getAllBooks();
    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.books, isEmpty);
  });

  test('check for the list of books when calling getAllBooks', () async {
    when(mockHomeUsecase.getAllBooks())
        .thenAnswer((_) => Future.value(Right(homeEntity)));

    await container.read(homeViewModelProvider.notifier).getAllBooks();

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.books, isNotEmpty);
  });

  test('add home entity and return true if sucessfully added', () async {
    when(mockHomeUsecase.addBook(homeEntity[0]))
        .thenAnswer((_) => Future.value(const Right(true)));

    await container.read(homeViewModelProvider.notifier).addBook(homeEntity[0]);

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.error, isNull);
  });

  test('should not get books when added', () async {
    when(mockHomeUsecase.getAllBooks())
        .thenAnswer((_) => Future.value(Left(Failure(error: 'Invalid'))));

    await container.read(homeViewModelProvider.notifier).getAllBooks();

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.error, 'Invalid');
    // to fail the test, we have to write isNull instead of isNotNull
  });

  test('check for the list of books by posted by user', () async {
    when(mockHomeUsecase.getUserBooks())
        .thenAnswer((_) => Future.value(Right(homeEntity)));

    await container.read(homeViewModelProvider.notifier).getUserBooks();

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.userBooks, isNotEmpty);
  });

  test('should get list of books by id', () async {
    when(mockHomeUsecase.getBookById("12"))
        .thenAnswer((_) => Future.value(Right([homeEntity[0]])));

    await container.read(homeViewModelProvider.notifier).getBookById("12");

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.bookById.length, 1);
  });

  test('should get bookmarked books', () async {
    when(mockHomeUsecase.getBookmarkedBooks())
        .thenAnswer((_) => Future.value(Right(homeEntity)));

    await container.read(homeViewModelProvider.notifier).getBookmarkedBooks();

    final homeState = container.read(homeViewModelProvider);

    expect(homeState.isLoading, false);
    expect(homeState.bookmarkedBooks, isNotEmpty);
  });

  tearDownAll(() {
    container.dispose();
  });
}
