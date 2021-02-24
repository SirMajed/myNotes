import 'package:intl/intl.dart';

class Note{
  String _title;
  String _description;
  String _date;
  String _userID;

  Note({String title, String description, String date, String userID}) {
    this._title = title;
    this._description = description;
    this._date = date;
    this._userID = userID;
  }

  Map<String,dynamic> toJson(){
    return {
      'title': getTitle(),
      'description': getDescription(),
      'date': getDate(),
      'id': getUserID(),
    };
  }
  Note fromJson(Map json){
    return new Note(
      title: json['title'],
      description: json['description'],
      date: json['date'],
      userID: json['id']
    );
  }
  String getReadableDate() {
    DateTime formattedDate = DateTime.parse(getDate());
    return DateFormat('dd-MM-yyyy h:mm a').format(formattedDate);
  }

  String getTitle() => _title ?? '';
  String getDescription() => _description ?? '';
  String getDate() => _date ?? '';
  String getUserID() => _userID ?? '';

  void setTitle(String value) {
    _title = value;
  }
  void setDescription(String value) => _description = value;
  void setDate(String value) => _date = value;
  void setUserID(String value) => _userID = value;
}
