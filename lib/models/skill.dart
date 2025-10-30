import 'package:flutter/material.dart';

enum SkillCategory {
  mobile,
  frontend,
  backend,
  database,
  tools,
  other;

  String get displayName {
    switch (this) {
      case SkillCategory.mobile:
        return 'Mobile Development';
      case SkillCategory.frontend:
        return 'Frontend Development';
      case SkillCategory.backend:
        return 'Backend Development';
      case SkillCategory.database:
        return 'Database & Storage';
      case SkillCategory.tools:
        return 'Tools & DevOps';
      case SkillCategory.other:
        return 'Other';
    }
  }

  Color get color {
    switch (this) {
      case SkillCategory.mobile:
        return const Color(0xFF6366F1); // Indigo
      case SkillCategory.frontend:
        return const Color(0xFF10B981); // Emerald
      case SkillCategory.backend:
        return const Color(0xFFF59E0B); // Amber
      case SkillCategory.database:
        return const Color(0xFF8B5CF6); // Violet
      case SkillCategory.tools:
        return const Color(0xFFEF4444); // Red
      case SkillCategory.other:
        return const Color(0xFF6B7280); // Gray
    }
  }
}

enum SkillLevel {
  beginner,
  intermediate,
  advanced,
  expert;

  String get displayName {
    switch (this) {
      case SkillLevel.beginner:
        return 'Beginner';
      case SkillLevel.intermediate:
        return 'Intermediate';
      case SkillLevel.advanced:
        return 'Advanced';
      case SkillLevel.expert:
        return 'Expert';
    }
  }

  double get progressValue {
    switch (this) {
      case SkillLevel.beginner:
        return 0.25;
      case SkillLevel.intermediate:
        return 0.5;
      case SkillLevel.advanced:
        return 0.75;
      case SkillLevel.expert:
        return 1.0;
    }
  }

  Color get color {
    switch (this) {
      case SkillLevel.beginner:
        return const Color(0xFFEF4444); // Red
      case SkillLevel.intermediate:
        return const Color(0xFFF59E0B); // Amber
      case SkillLevel.advanced:
        return const Color(0xFF10B981); // Emerald
      case SkillLevel.expert:
        return const Color(0xFF6366F1); // Indigo
    }
  }
}

class Skill {
  final String id;
  final String name;
  final SkillCategory category;
  final SkillLevel level;
  final IconData icon;
  final String description;
  final int yearsOfExperience;
  final List<String> relatedProjects;
  final bool isFeatured;

  const Skill({
    required this.id,
    required this.name,
    required this.category,
    required this.level,
    required this.icon,
    required this.description,
    required this.yearsOfExperience,
    this.relatedProjects = const [],
    this.isFeatured = false,
  });

  Skill copyWith({
    String? id,
    String? name,
    SkillCategory? category,
    SkillLevel? level,
    IconData? icon,
    String? description,
    int? yearsOfExperience,
    List<String>? relatedProjects,
    bool? isFeatured,
  }) {
    return Skill(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      level: level ?? this.level,
      icon: icon ?? this.icon,
      description: description ?? this.description,
      yearsOfExperience: yearsOfExperience ?? this.yearsOfExperience,
      relatedProjects: relatedProjects ?? this.relatedProjects,
      isFeatured: isFeatured ?? this.isFeatured,
    );
  }
}
