import 'package:flutter/material.dart';
import '../models/project.dart';

class DummyProjects {
  static final List<Project> projects = [
    Project(
      id: '1',
      title: 'Uri Book',
      description:
          'An online learning service providing educational materials for the public.',
      technologies: ["Flutter", "Firebase"],
      category: ProjectCategory.mobile,
      completedDate: DateTime(2020, 7, 31),
      driveUrl:
          'https://drive.google.com/file/d/17tjtSxIS4cYTudIm2Hq-fLv9FgjVBx2e/view?usp=drive_link',
      imageUrl: 'assets/uri_book.png',
      backgroundColor: const Color(0xFFF97316),
    ),
    Project(
      id: '2',
      title: 'Tournal',
      description:
          'A simple journal trip app for planning activities and traveling with your buddy.',
      technologies: ["Java", "Firebase"],
      category: ProjectCategory.mobile,
      completedDate: DateTime(2020, 6, 30),
      driveUrl: 'https://drive.google.com/file/d/1def456ghi789/view',
      imageUrl: 'assets/tournal.png',
      backgroundColor: const Color(0xFF0EA5E9),
    ),
    Project(
      id: '3',
      title: 'Password Manager',
      description:
          'A password manager app that allows you to store and manage your passwords securely.',
      technologies: ['Flutter', 'Dart', 'Firebase', 'Python'],
      category: ProjectCategory.mobile,
      completedDate: DateTime(2022, 1, 30),
      githubUrl: 'https://github.com/jesselynhartandi/password-manager',
      imageUrl: 'assets/password_manager.png',
      backgroundColor: const Color(0xFF6366F1),
    ),
    Project(
      id: '4',
      title: 'Luma Blocks',
      description:
          'A Tetris-inspired block game with four buttons that delivers a satisfying mini-console feeling.',
      technologies: ['Flutter', 'Dart'],
      category: ProjectCategory.game,
      completedDate: DateTime(2025, 12, 10),
      imageUrl: 'assets/luma_new_app_logo.png',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.javes.block_app',
      backgroundColor: const Color(0xFF1A1A2E),
    ),
  ];

  static List<Project> getProjectsByCategory(ProjectCategory category) {
    return projects.where((project) => project.category == category).toList();
  }

  static List<Project> getFeaturedProjects() {
    return projects.take(3).toList();
  }

  static List<String> getAllTechnologies() {
    final Set<String> techSet = {};
    for (final project in projects) {
      techSet.addAll(project.technologies);
    }
    return techSet.toList()..sort();
  }
}
