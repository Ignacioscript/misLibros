// ignore_for_file: public_member_api_docs, sort_constructors_first, unnecessary_getters_setters, prefer_typing_uninitialized_variables, non_constant_identifier_names


class User {
  var _uid;
  var _name;
  var _email;
  var _password;
  var _genre;
  var _favoritesGenres;
  var _bornDate;

get uid => _uid;
set uid(var value) => _uid = value;

get name => _name;
set name(var value) => _name = value;

get email => _email;
set email( value) => _email = value;

get password => _password;
set password( value) => _password = value;

get genre => _genre;
set genre( value) => _genre = value;

get favoritesGenres => _favoritesGenres;
set favoritesGenres( value) => _favoritesGenres = value;

get bornDate => _bornDate;
set bornDate( value) => _bornDate = value;

  User(
    this._uid,
    this._name,
    this._email,
    this._password,
    this._genre,
    this._favoritesGenres,
    this._bornDate,

  );

  User.Empty();  //FIREBASE NOS EXIGE SIEMPRE UN CONSTRUCTOR VACIO

User.fromJson(Map<String, dynamic> json)
    : _uid = json['uid'],
      _name = json['name'],
      _email = json['email'],
      _password = json['password'],
      _genre = json['genre'],
      _favoritesGenres = json['favoritesGenres'],
      _bornDate = json['bornDate'];
  
  Map<String, dynamic> ToJson() =>{
    'uid' : _uid,
    'name' : _name,
    'email' : _email,
    'password' : _password,
    'genre' : _genre,
    'favoritesGenres' : _favoritesGenres,
    'bornDate' : _bornDate};
  }


