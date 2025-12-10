import 'package:flutter/material.dart';

class Project {
  final String id;
  final String title;
  final String description;
  final List<String> technologies;
  final String? imageUrl;
  final String? githubUrl;
  final String? liveUrl;
  final String? driveUrl;
  final String? testingGroupUrl;
  final String? playStoreUrl;
  final ProjectCategory category;
  final DateTime completedDate;
  final Color? backgroundColor;

  const Project({
    required this.id,
    required this.title,
    required this.description,
    required this.technologies,
    this.imageUrl,
    this.githubUrl,
    this.liveUrl,
    this.driveUrl,
    this.testingGroupUrl,
    this.playStoreUrl,
    required this.category,
    required this.completedDate,
    this.backgroundColor,
  });

  Project copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? technologies,
    String? imageUrl,
    String? githubUrl,
    String? liveUrl,
    String? driveUrl,
    String? testingGroupUrl,
    String? playStoreUrl,
    ProjectCategory? category,
    DateTime? completedDate,
    Color? backgroundColor,
  }) {
    return Project(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      technologies: technologies ?? this.technologies,
      imageUrl: imageUrl ?? this.imageUrl,
      githubUrl: githubUrl ?? this.githubUrl,
      liveUrl: liveUrl ?? this.liveUrl,
      driveUrl: driveUrl ?? this.driveUrl,
      testingGroupUrl: testingGroupUrl ?? this.testingGroupUrl,
      playStoreUrl: playStoreUrl ?? this.playStoreUrl,
      category: category ?? this.category,
      completedDate: completedDate ?? this.completedDate,
      backgroundColor: backgroundColor ?? this.backgroundColor,
    );
  }
}

enum ProjectCategory {
  mobile,
  web,
  desktop,
  backend,
  game,
  other;

  String get displayName {
    switch (this) {
      case ProjectCategory.mobile:
        return 'Mobile App';
      case ProjectCategory.web:
        return 'Web Application';
      case ProjectCategory.desktop:
        return 'Desktop Application';
      case ProjectCategory.backend:
        return 'Backend Service';
      case ProjectCategory.game:
        return 'Game';
      case ProjectCategory.other:
        return 'Other';
    }
  }
}
