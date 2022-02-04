class Animal {
  String? animalName;
  String? animalKind;
  String? imagePath;
  bool? isFlying = false;

  Animal(
      {required this.animalName,
      required this.animalKind,
      required this.imagePath,
      this.isFlying});
}
