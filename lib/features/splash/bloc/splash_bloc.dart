import 'package:flutter_bloc/flutter_bloc.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(const SplashState()) {
    on<PageChanged>(_onPageChanged);
    on<NavigateToLogin>(_onNavigateToLogin);
  }

  void _onPageChanged(PageChanged event, Emitter<SplashState> emit) {
    emit(state.copyWith(currentPage: event.pageIndex));
  }

  void _onNavigateToLogin(NavigateToLogin event, Emitter<SplashState> emit) {
    emit(state.copyWith(shouldNavigateToLogin: true));
  }
} 