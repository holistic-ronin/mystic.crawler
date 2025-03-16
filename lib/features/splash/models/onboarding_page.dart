class OnboardingPage {
  final String title;
  final String description;
  final String svgAsset;

  const OnboardingPage({
    required this.title,
    required this.description,
    required this.svgAsset,
  });
}

final List<OnboardingPage> onboardingPages = [
  OnboardingPage(
    title: 'Welcome to Mystic Crawler',
    description: 'Embark on a magical journey through our app',
    svgAsset: 'assets/images/welcome.svg',
  ),
  OnboardingPage(
    title: 'Discover',
    description: 'Explore endless possibilities and adventures',
    svgAsset: 'assets/images/discover.svg',
  ),
  OnboardingPage(
    title: 'Connect',
    description: 'Join our community of mystic enthusiasts',
    svgAsset: 'assets/images/connect.svg',
  ),
  OnboardingPage(
    title: 'Get Started',
    description: 'Begin your mystical journey today',
    svgAsset: 'assets/images/start.svg',
  ),
]; 