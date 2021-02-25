abstract class Account {
  String _name;
  String _email;
  String _password;
  String _imageUrl;

  Account({String name, String email, String password,String imageUrl}) {
    this._email = email;
    this._password = password;
    this._name = name;
    this._imageUrl = imageUrl;
  }
  Future<void> login();
  Future<void> logout();
  Future<void> register();

  String getName() => _name ?? '';
  String getEmail() => _email ?? '';
  String getPassword() => _password ?? '';
  String getImage() => _imageUrl ?? 'https://firebasestorage.googleapis.com/v0/b/mynotes-4f9bd.appspot.com/o/download.png?alt=media&token=adcfd5e0-0c33-4bf8-9834-8afff36679a0';

  void setName(String value) {
    this._name = value;
  }
  void setEmail(String value) {
    this._email = value;
  }
  void setPassword(String value) {
    this._password = value;
  }
  void setImageUrl(String value){
    this._imageUrl=value;
  }
}
