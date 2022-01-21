import 'package:equatable/equatable.dart';

class Item extends Equatable {
  final int id;
  final String name;
  final bool deleting;

  const Item({required this.id, required this.name,this.deleting = false});

  Item copyWith({int? id, String? name,bool? deleting}) {
    return Item(id: id ?? this.id, name: name ?? this.name,deleting: deleting ?? this.deleting);
  }

  @override
  List<Object?> get props => [id, name,deleting];
}
