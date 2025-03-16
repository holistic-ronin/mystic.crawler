import 'package:equatable/equatable.dart';

class SplashState extends Equatable {
  final int currentPage;
  final bool shouldNavigateToLogin;

  const SplashState({
    this.currentPage = 0,
    this.shouldNavigateToLogin = false,
  });

  SplashState copyWith({
    int? currentPage,
    bool? shouldNavigateToLogin,
  }) {
    return SplashState(
      currentPage: currentPage ?? this.currentPage,
      shouldNavigateToLogin: shouldNavigateToLogin ?? this.shouldNavigateToLogin,
    );
  }

  @override
  List<Object> get props => [currentPage, shouldNavigateToLogin];
} 