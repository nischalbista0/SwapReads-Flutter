import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:swapreads/config/router/app_route.dart';
import 'package:swapreads/features/user_profile/domain/entity/profile_entity.dart';
import 'package:swapreads/features/user_profile/domain/use_case/profile_use_case.dart';
import 'package:swapreads/features/user_profile/presentation/viewmodel/profile_view_model.dart';

import '../test/unit_test/home_test.mocks.dart';
import '../test_data/profile_entity_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();
  late ProfileUseCase mockProfileUseCase;
  late List<ProfileEntity> profileEntity;

  setUpAll(() async {
    mockProfileUseCase = MockProfileUseCase();
    profileEntity = await getProfileTest();
  });

  testWidgets('Profile View', (tester) async {
    when(mockProfileUseCase.getUserInfo())
        .thenAnswer((_) async => Right(profileEntity));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          profileViewModelProvider
              .overrideWith((ref) => ProfileViewModel(mockProfileUseCase)),
        ],
        child: MaterialApp(
          routes: AppRoute.getApplicationRoute(),
          initialRoute: AppRoute.moreBooksRoute,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Your Total Books'), findsOneWidget);
  });
}
