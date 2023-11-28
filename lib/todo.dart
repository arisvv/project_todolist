class Todo {
  int? id;
  String nama;
  String deskripsi;
  bool done;

  Todo(this.nama, this.deskripsi, {this.done = false, this.id});

  static List<Todo> dummyData = [
    Todo("Latihan Menggambar", "Latihan Perlombaan Menggambar"),
    Todo("Makan Malam", "Makan Malam Bersama Camer", done: true),
    Todo("Bernyayi Bersama", "Nyanyi Bersama Teman-Teman"),
  ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nama': nama,
      'deskripsi': deskripsi,
      'done': done
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(map['nama'] as String, map['nama'] as String,
        done: map['done'] == 0 ? false : true, id: map['id']);
  }
}
