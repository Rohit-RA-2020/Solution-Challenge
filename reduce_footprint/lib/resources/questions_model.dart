class Question {
  final int id;
  final String question;
  final List<String> options;

  Question({
    required this.id,
    required this.question,
    required this.options,
  });
}

const List questionsList = [
  {
    "id": 1,
    "question": "How often do you travel by air in a year ?",
    "options": ['I fly rarely', 'Occasionally', 'Regularly', 'Never'],
    "icon" : "assets/lottie/plane.json",
  },
  {
    "id": 2,
    "question": "What describes your diet ?",
    "options": [
      'Vegan',
      'Vegetarian',
      'Pescetarian',
      'Ocassionaly eat meat',
      'Regularly eat meat'
    ],
    "icon" : "assets/lottie/food.json",
  },
  {
    "id": 3,
    "question": "How much do you travel by car ?",
    "options": [
      'I don\'t drive',
      '~5000 km',
      '~ 5,000 - 10000 km',
      '~ 10,000 - 15,000 km',
      '>15,000 km'
    ],
    "icon" : "assets/lottie/car.json",
  },
  {
    "id": 4,
    "question": "Which kind of fuel do you use ?",
    "options": ['Electric', 'Natural gas', 'Petrol, Diesel'],
    "icon" : "assets/lottie/fuel.json",
  },
  {
    "id": 5,
    "question": "Tell us something about your shopping habits ?",
    "options": ['Rarely', 'Average', 'Shopper', 'Luxary Shopper'],
    "icon" : "assets/lottie/shopping.json",
  },
  {
    "id": 6,
    "question": "How big is your home ?",
    "options": [
      'Sharing',
      'One-Bedroom',
      'Two-bedroom',
      'Three-bedroom',
      'Bunglow'
    ],
    "icon" : "assets/lottie/house.json",
  },
  {
    "id": 7,
    "question": "How many people live in your home ?",
    "options": ['Just me', '2 people', '3 people', '4-6 people', ' > 7 people'],
    "icon" : "assets/lottie/people.json",
  },
  {
    "id": 8,
    "question": "Which pet do you own ?",
    "options": ['None', 'Cat', 'Dog', 'Other'],
    "icon" : "assets/lottie/pets.json",
  },
  {
    "id": 9,
    "question": "Do you use renewable energy sources at your home ?",
    "options": ['Yes', 'Not Yet', 'Not Sure'],
    "icon" : "assets/lottie/energy.json",
  },
];
