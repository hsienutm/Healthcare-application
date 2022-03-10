class User {
  final String imagePath;
  final String name;
  final String email;
  final String about;
  final bool isDarkMode;

  const User({
    required this.imagePath,
    required this.name,
    required this.email,
    required this.about,
    required this.isDarkMode,
  });
} 

/*class MyUser {
  final String uid;

  MyUser({required this.uid});
  //session
  //constructor with named parameter, updated when stream changed

}*/
