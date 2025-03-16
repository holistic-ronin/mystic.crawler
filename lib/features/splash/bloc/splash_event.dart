import 'package:equatable/equatable.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class PageChanged extends SplashEvent {
  final int pageIndex;

  const PageChanged(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}

class NavigateToLogin extends SplashEvent {} 