import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:swapreads/features/home/domain/entity/book_entity.dart';
import 'package:swapreads/features/home/domain/use_case/home_use_case.dart';
import 'package:swapreads/features/home/presentation/view/homepage_view.dart';
import 'package:swapreads/features/home/presentation/viewmodel/home_view_model.dart';
import 'package:swapreads/features/user_profile/domain/entity/profile_entity.dart';
import 'package:swapreads/features/user_profile/domain/use_case/profile_use_case.dart';
import 'package:swapreads/features/user_profile/presentation/viewmodel/profile_view_model.dart';

import '../build/unit_test_assets/test_data/profile_entity_test.dart';
import '../test/unit_test/home_test.mocks.dart';
import '../test_data/book_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late HomeUseCase homeUseCase;
  late ProfileUseCase mockProfileUseCase;
  late List<BookEntity> bookEntity;
  late List<ProfileEntity> profileEntity;
  late List<BookEntity> bookmarkedBooks;
  late List<BookEntity> userBooks;

  setUpAll(() async {
    homeUseCase = MockHomeUseCase();
    mockProfileUseCase = MockProfileUseCase();
    bookEntity = await getAllBooks();
    userBooks = await getUserBooks();
    profileEntity = await getProfileTest();
    bookmarkedBooks = await getBookmarkedBooks();
  });

  testWidgets('Homepage View', (tester) async {
    when(homeUseCase.getAllBooks()).thenAnswer((_) async => Right(bookEntity));
    when(homeUseCase.getBookmarkedBooks())
        .thenAnswer((_) async => Right(bookmarkedBooks));
    when(homeUseCase.getUserBooks()).thenAnswer((_) async => Right(userBooks));
    when(mockProfileUseCase.getUserInfo())
        .thenAnswer((_) async => Right(profileEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          homeViewModelProvider
              .overrideWith((ref) => HomeViewModel(homeUseCase)),
          profileViewModelProvider
              .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
        ],
        child: const MaterialApp(
          home: HomepageView(), // Use the HomepageView directly
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.byType(ListView), findsWidgets);
    final listViewWidgets = tester.widgetList<ListView>(find.byType(ListView));

    final itemCounts = listViewWidgets
        .map((listView) => listView.childrenDelegate.estimatedChildCount ?? 0)
        .toList();

    expect(itemCounts.length, 2);
    expect(itemCounts[0], 1);
  });
}
