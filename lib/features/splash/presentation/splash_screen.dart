import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';
import '../models/onboarding_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc(),
      child: const SplashScreenView(),
    );
  }
}

class SplashScreenView extends StatefulWidget {
  const SplashScreenView({super.key});

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  final PageController _pageController = PageController();

  void _nextPage() {
    if (_pageController.page! < onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    if (_pageController.page! > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToLogin(BuildContext context) {
    context.read<SplashBloc>().add(NavigateToLogin());
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isWeb = MediaQuery.of(context).size.width > 600;

    return BlocConsumer<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.shouldNavigateToLogin) {
          context.go('/login');
        }
      },
      builder: (context, state) {
        final isLastPage = state.currentPage == onboardingPages.length - 1;

        return Scaffold(
          body: Stack(
            children: [
              if (isWeb) ...[
                Positioned.fill(
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: state.currentPage > 0 ? _previousPage : null,
                        icon: const Icon(Icons.chevron_left),
                        iconSize: 40,
                        color: state.currentPage > 0 ? Theme.of(context).primaryColor : Colors.grey.withOpacity(0.3),
                      ),
                      Expanded(
                        child: PageView.builder(
                          controller: _pageController,
                          itemCount: onboardingPages.length,
                          onPageChanged: (index) {
                            context.read<SplashBloc>().add(PageChanged(index));
                          },
                          itemBuilder: (context, index) {
                            final page = onboardingPages[index];
                            return OnboardingPageView(page: page);
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: isLastPage 
                            ? () => _navigateToLogin(context)
                            : _nextPage,
                        icon: Icon(isLastPage ? Icons.login : Icons.chevron_right),
                        iconSize: 40,
                        color: Theme.of(context).primaryColor,
                      ),
                    ],
                  ),
                ),
              ] else ...[
                PageView.builder(
                  controller: _pageController,
                  itemCount: onboardingPages.length,
                  onPageChanged: (index) {
                    context.read<SplashBloc>().add(PageChanged(index));
                  },
                  itemBuilder: (context, index) {
                    final page = onboardingPages[index];
                    return OnboardingPageView(page: page);
                  },
                ),
              ],
              Positioned(
                bottom: 50,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        onboardingPages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          height: 8,
                          width: state.currentPage == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: state.currentPage == index
                                ? Theme.of(context).primaryColor
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (!isWeb) ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (state.currentPage > 0)
                            TextButton.icon(
                              onPressed: _previousPage,
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('Previous'),
                            ),
                          const SizedBox(width: 16),
                          if (!isLastPage)
                            TextButton.icon(
                              onPressed: _nextPage,
                              label: const Text('Next'),
                              icon: const Icon(Icons.arrow_forward),
                            ),
                        ],
                      ),
                      if (isLastPage)
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: ElevatedButton(
                            onPressed: () => _navigateToLogin(context),
                            child: const Text('Get Started'),
                          ),
                        ),
                    ] else if (isLastPage) ...[
                      ElevatedButton(
                        onPressed: () => _navigateToLogin(context),
                        child: const Text('Get Started'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class OnboardingPageView extends StatelessWidget {
  final OnboardingPage page;

  const OnboardingPageView({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            page.svgAsset,
            height: 200,
          ),
          const SizedBox(height: 32),
          Text(
            page.title,
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
} 