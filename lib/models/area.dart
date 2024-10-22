class Area {
  final int id;
  final String nameArea;
  final String namePlant;
  final String img;

  Area({required this.id, required this.nameArea, required this.namePlant, required this.img});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nameArea': nameArea,
      'namePlant': namePlant,
      'img': img,
    };
  }

  factory Area.fromMap(Map<String, dynamic> map) {
    return Area(
      id: map['id'],
      nameArea: map['nameArea'],
      namePlant: map['namePlant'],
      img: map['img'],
    );
  }
}