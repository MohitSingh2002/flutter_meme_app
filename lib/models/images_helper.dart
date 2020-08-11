import 'dart:convert';

class ImagesHelper {
  String name;
  String url;
  ImagesHelper({
    this.name,
    this.url,
  });

  ImagesHelper copyWith({
    String name,
    String url,
  }) {
    return ImagesHelper(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  factory ImagesHelper.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return ImagesHelper(
      name: map['name'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ImagesHelper.fromJson(String source) => ImagesHelper.fromMap(json.decode(source));

  @override
  String toString() => 'ImagesHelper(name: $name, url: $url)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is ImagesHelper &&
      o.name == name &&
      o.url == url;
  }

  @override
  int get hashCode => name.hashCode ^ url.hashCode;
}
