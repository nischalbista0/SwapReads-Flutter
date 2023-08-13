import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/mockito.dart';
import 'package:swapreads/config/router/app_route.dart';
import 'package:swapreads/features/auth/domain/entity/auth_entity.dart';
import 'package:swapreads/features/auth/presentation/viewmodel/auth_view_model.dart';

import '../test/unit_test/auth_test.mocks.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthUseCase mockAuthUseCase;
  late AuthEntity authEntity;

  setUp(() {
    mockAuthUseCase = MockAuthUseCase();
    authEntity = const AuthEntity(
      // id: '1',
      fullname: 'Nischal Bista',
      username: 'nischal123',
      email: 'nischal123@gmail.com',
      password: 'nischal123',
    );
  });

  testWidgets('register view', (tester) async {
    when(mockAuthUseCase.registerUser(authEntity))
        .thenAnswer((_) async => const Right(true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authViewModelProvider.overrideWith(
            (ref) => AuthViewModel(mockAuthUseCase),
          ),
        ],
        child: MaterialApp(
          initialRoute: AppRoute.registerRoute,
          routes: AppRoute.getApplicationRoute(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField).at(0), 'Nischal Bista');

    await tester.enterText(find.byType(TextFormField).at(1), 'nischal123');

    await tester.enterText(
        find.byType(TextFormField).at(2), 'nischal123@gmail.com');

    await tester.enterText(find.byType(TextFormField).at(3), 'nischal123');

    // await tester.tap(find.widgetWithText(ElevatedButton, 'Register'));

    //=========================== Find the register button===========================
    final registerButtonFinder =
        find.widgetWithText(ElevatedButton, 'Register');

    await tester.dragUntilVisible(
      registerButtonFinder, // what you want to find
      find.byType(SingleChildScrollView), // widget you want to scroll
      const Offset(196.4, 709.9), // delta to move
    );

    await tester.tap(registerButtonFinder);

    await tester.pumpAndSettle();

    expect(find.widgetWithText(SnackBar, 'Registered successfully'),
        findsOneWidget);
  });
}
