class OnBoardModel{
  String image;
  String text;
  String description;

  OnBoardModel({
    required this.image,
    required this.text,
    required this.description,
  });
}

List<OnBoardModel> screens = <OnBoardModel>[
  OnBoardModel(image: 'assets/images/onboard1.png', text: 'Welcome to BANKSY', description: 'Discover a new level of financial management and fun with our app!'),
  OnBoardModel(image: 'assets/images/onboard2.png', text: 'Your cash flow is under control', description: 'Keep track of your income with our convenient tools. Receive notifications when money arrives and plan your finances easily'),
  OnBoardModel(image: 'assets/images/onboard3.png', text: 'Stay informed and enjoy', description: 'Read the latest news and articles about finance. Enjoy videos and mini-games to brighten your day'),
  OnBoardModel(image: 'assets/images/onboard4.png', text: 'Let\'s go!', description: 'Now you have everything you need in one place. Let\'s start managing your finances and enjoy a variety of opportunities together')
];