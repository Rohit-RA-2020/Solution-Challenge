class OnboardingContents {
  final String title;
  final String image;
  final String desc;

  OnboardingContents(
      {required this.title, required this.image, required this.desc});
}

List<OnboardingContents> contents = [
  OnboardingContents(
    title: "Take care of your nature",
    image: "assets/lottie/love.json",
    desc:
        "Get aware about your lifestyle and help your environment grow better",
  ),
  OnboardingContents(
    title: "Track your progress",
    image: "assets/lottie/grow.json",
    desc:
        "Get a better understanding of your progress and move towards goals of being carbon neutral",
  ),
  OnboardingContents(
    title: "Let's get started",
    image: "assets/lottie/cycle.json",
    desc:
        "Get onboard with our app and start tracking your footprint, so you can make your life more sustainable",
  ),
];
