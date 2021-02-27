import 'dart:math';

import 'package:my_notes/Services/AvatarGenerator.dart';
abstract class Account {
  String _name;
  String _email;
  String _password;
  String _imageUrl;
  String accessories = AvatarGenerator.accessories();
  String top = AvatarGenerator.top();
  String hairColor = AvatarGenerator.hairColor();
  String facialHair = AvatarGenerator.facialHair();
  String facialColor = AvatarGenerator.facialHairColor();
  String eyeType = AvatarGenerator.eyeType();
  String eyeBrowType = AvatarGenerator.eyebrowType();
  String mouth = AvatarGenerator.mouth();
  String clothes = AvatarGenerator.clothes();
  String clotheColor = AvatarGenerator.clothesColor();

  Account({String name, String email, String password, String imageUrl}) {
    this._email = email;
    this._password = password;
    this._name = name;
    this._imageUrl = imageUrl;
  }
  Future<void> login();
  Future<void> logout();
  Future<void> register();

  // int getRan() {
  //   int max = 112;
  //   int randomNumber = Random().nextInt(max) + 1;
  //   return randomNumber;
  // }


  String getName() => _name ?? '';
  String getEmail() => _email ?? '';
  String getPassword() => _password ?? '';
  String getImage() =>
      _imageUrl ?? 'https://avataaars.io/?accessoriesType=$accessories&avatarStyle=Circle&clotheColor=$clotheColor&clotheType=$clothes&eyeType=$eyeType&eyebrowType=$eyeBrowType&facialHairColor=$facialColor&facialHairType=$facialHair&hairColor=$hairColor&mouthType=$mouth&skinColor=Light&topType=$top';
      // default img > 'https://raw.githubusercontent.com/Ashwinvalento/cartoon-avatar/master/lib/images/male/${getRan()}.png'
  void setName(String value) {
    this._name = value;
  }

  void setEmail(String value) {
    this._email = value;
  }

  void setPassword(String value) {
    this._password = value;
  }

  void setImageUrl(String value) {
    this._imageUrl = value;
  }
}
