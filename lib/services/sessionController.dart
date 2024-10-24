class Sessioncontroller {

  static final Sessioncontroller _session = Sessioncontroller._internal();
  static  String? userid;

  factory Sessioncontroller(){
    return _session;
  }
  Sessioncontroller._internal();
}