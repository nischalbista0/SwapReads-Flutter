import 'package:flutter/material.dart';
import 'package:swapreads/features/exchange_requests/presentation/view/exchange_requests_view.dart';
import 'package:swapreads/features/home/presentation/view/update_book_view.dart';
import 'package:swapreads/features/user_profile/presentation/view/more_view.dart';

import '../../features/auth/presentation/view/login_view.dart';
import '../../features/auth/presentation/view/signup_view.dart';
import '../../features/exchange_requests/presentation/view/create_exchange_request.dart';
import '../../features/home/domain/entity/book_entity.dart';
import '../../features/home/presentation/view/add_book_view.dart';
import '../../features/home/presentation/view/book_details_view.dart';
import '../../features/home/presentation/view/dashboard_view.dart';
import '../../features/home/presentation/view/homepage_view.dart';
import '../../features/splash/presentation/view/splash_view.dart';
import '../../features/user_profile/presentation/view/bookmarked_books_view.dart';
import '../../features/user_profile/presentation/view/change_password_view.dart';
import '../../features/user_profile/presentation/view/edit_profile_view.dart';
import '../../features/user_profile/presentation/view/user_books_view.dart';

class AppRoute {
  AppRoute._();

  static const String homeRoute = '/home';
  static const String bookScreen = '/book';
  static const String bookDetails = '/bookDetails';
  static const String loginRoute = '/login';
  static const String registerRoute = '/register';
  static const String messagesRoute = '/messages';
  static const String chatRoute = '/chat';
  static const String splashRoute = '/splash';
  static const String userBooksRoute = '/userBooks';
  static const String bookmarkedBooksRoute = '/bookmarkedBooks';
  static const String changePasswordRoute = '/changePassword';
  static const String editProfileRoute = '/editProfile';
  static const String addBookRoute = '/addBook';
  static const String updateBookRoute = '/updateBook';
  static const String createExchangeRequestView = '/createExchangeRequest';
  static const String exchangeRequestView = '/exchangeRequest';
  static const String moreBooksRoute = '/moreBooks';

  static getApplicationRoute() {
    return {
      loginRoute: (context) => const LoginView(),
      homeRoute: (context) => const DashboardView(),
      bookScreen: (context) => const HomepageView(),
      bookDetails: (context) => const BookDetailsView(
            book: null,
          ),
      registerRoute: (context) => const SignupView(),
      splashRoute: (context) => const SplashView(),
      moreBooksRoute: (context) => const MoreView(),
      userBooksRoute: (context) => const UserBooksView(),
      bookmarkedBooksRoute: (context) => const BookmarkedBooksView(),
      changePasswordRoute: (context) => const ChangePasswordView(),
      editProfileRoute: (context) => const EditProfileView(),
      addBookRoute: (context) => const AddBookView(),
      updateBookRoute: (context) {
        final book = ModalRoute.of(context)!.settings.arguments as BookEntity;
        return UpdateBookView(book: book);
      },
      createExchangeRequestView: (context) => const CreateExchangeRequestView(),
      exchangeRequestView: (context) => const ExchangeRequestsView(),
    };
  }
}
