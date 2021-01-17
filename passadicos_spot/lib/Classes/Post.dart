

class Post {
  String id;
  String description;
  String especialista;
  String photoURL;
  String username;
  List<String> animaisIdentificados;
  String location;
  DateTime date;

  Post(String id, String desc, String esp, String purl, String user, List<String> an, String location, DateTime date){
    this.id = id;
    this.description = desc;
    this.especialista = esp;
    this.photoURL = purl;
    this.username = user;
    this.animaisIdentificados = an;
    this.location = location;
    this.date = date;
  }


  Map<String, dynamic> toJson() {
    return {

    };
  }
}

