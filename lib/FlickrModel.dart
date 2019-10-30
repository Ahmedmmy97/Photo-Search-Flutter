class FlickrData {
  Photos photos;
  String stat;

  FlickrData({this.photos, this.stat});

  FlickrData.fromJson(Map<String, dynamic> json) {
    photos =
        json['photos'] != null ? new Photos.fromJson(json['photos']) : null;
    stat = json['stat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.photos != null) {
      data['photos'] = this.photos.toJson();
    }
    data['stat'] = this.stat;
    return data;
  }
}

class Photos {
  int page;
  int pages;
  int perpage;
  String total;
  List<Photo> photo;

  Photos({this.page, this.pages, this.perpage, this.total, this.photo});

  Photos.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    pages = json['pages'];
    perpage = json['perpage'];
    total = json['total'];
    if (json['photo'] != null) {
      photo = new List<Photo>();
      json['photo'].forEach((v) {
        photo.add(new Photo.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['pages'] = this.pages;
    data['perpage'] = this.perpage;
    data['total'] = this.total;
    if (this.photo != null) {
      data['photo'] = this.photo.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Photo {
  String id;
  String owner;
  String secret;
  String server;
  int farm;
  String title;
  int ispublic;
  int isfriend;
  int isfamily;

  Photo(
      {this.id,
      this.owner,
      this.secret,
      this.server,
      this.farm,
      this.title,
      this.ispublic,
      this.isfriend,
      this.isfamily});

  Photo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    owner = json['owner'];
    secret = json['secret'];
    server = json['server'];
    farm = json['farm'];
    title = json['title'];
    ispublic = json['ispublic'];
    isfriend = json['isfriend'];
    isfamily = json['isfamily'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['owner'] = this.owner;
    data['secret'] = this.secret;
    data['server'] = this.server;
    data['farm'] = this.farm;
    data['title'] = this.title;
    data['ispublic'] = this.ispublic;
    data['isfriend'] = this.isfriend;
    data['isfamily'] = this.isfamily;
    return data;
  }
}