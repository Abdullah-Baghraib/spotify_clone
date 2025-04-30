import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Genre extends Equatable {
  final String id;
  final String name;
  final Color backgroundColor;
  final String? iconPath;

  const Genre({
    required this.id,
    required this.name,
    required this.backgroundColor,
    this.iconPath,
  });

  @override
  List<Object?> get props => [id, name, backgroundColor, iconPath];
} 