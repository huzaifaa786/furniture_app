class Company {
  final String name;
  final String imageUrl;
  final double starRating;

  Company(
      {required this.name, required this.imageUrl, required this.starRating});
}

List<Company> companies = [
  Company(name: "Company 1", imageUrl: "assets/company1.png", starRating: 4.5),
  Company(name: "Company 2", imageUrl: "assets/company2.png", starRating: 3.8),
  Company(name: "Company 1", imageUrl: "assets/company1.png", starRating: 4.5),
  Company(name: "Company 2", imageUrl: "assets/company2.png", starRating: 3.8),
  Company(name: "Company 1", imageUrl: "assets/company1.png", starRating: 4.5),
  Company(name: "Company 2", imageUrl: "assets/company2.png", starRating: 3.8),
  // Add more company instances as needed
];
