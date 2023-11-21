// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TaskCard {
    String? nom;
    String? description;
    String? type;
    String? pregress;
  TaskCard({
    this.nom,
    this.description,
    this.type,
    this.pregress,
  });

  TaskCard copyWith({
    String? nom,
    String? description,
    String? type,
    String? pregress,
  }) {
    return TaskCard(
      nom: nom ?? this.nom,
      description: description ?? this.description,
      type: type ?? this.type,
      pregress: pregress ?? this.pregress,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom': nom,
      'description': description,
      'type': type,
      'pregress': pregress,
    };
  }

  factory TaskCard.fromMap(Map<String, dynamic> map) {
    return TaskCard(
      nom: map['nom'] != null ? map['nom'] as String : null,
      description: map['description'] != null ? map['description'] as String : null,
      type: map['type'] != null ? map['type'] as String : null,
      pregress: map['pregress'] != null ? map['pregress'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskCard.fromJson(String source) => TaskCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskCard(nom: $nom, description: $description, type: $type, pregress: $pregress)';
  }

  @override
  bool operator ==(covariant TaskCard other) {
    if (identical(this, other)) return true;
  
    return 
      other.nom == nom &&
      other.description == description &&
      other.type == type &&
      other.pregress == pregress;
  }

  @override
  int get hashCode {
    return nom.hashCode ^
      description.hashCode ^
      type.hashCode ^
      pregress.hashCode;
  }
  }
