import 'package:flutter/material.dart';
import '../models/skill.dart';

class SkillsData {
  static final List<Skill> skills = [
    // Mobile Development
    Skill(
      id: 'flutter',
      name: 'Flutter',
      category: SkillCategory.mobile,
      level: SkillLevel.intermediate,
      icon: Icons.phone_android,
      description:
          'Cross-platform mobile development framework. Primary expertise with 3+ years of professional experience.',
      yearsOfExperience: 2,
      isFeatured: true,
    ),
    Skill(
      id: 'dart',
      name: 'Dart',
      category: SkillCategory.mobile,
      level: SkillLevel.intermediate,
      icon: Icons.code,
      description: 'Primary programming language for Flutter development.',
      yearsOfExperience: 2,
      isFeatured: true,
    ),
    Skill(
      id: 'android_native',
      name: 'Android (Java/Kotlin)',
      category: SkillCategory.mobile,
      level: SkillLevel.expert,
      icon: Icons.android,
      description: 'Native Android development using Java and Kotlin.',
      yearsOfExperience: 2,
      relatedProjects: [],
      isFeatured: false,
    ),
    Skill(
      id: 'ios_native',
      name: 'iOS (Swift/Objective-C)',
      category: SkillCategory.mobile,
      level: SkillLevel.intermediate,
      icon: Icons.phone_iphone,
      description: 'Native iOS development using Swift and Objective-C.',
      yearsOfExperience: 1,
      relatedProjects: [],
      isFeatured: false,
    ),
    Skill(
      id: 'react_native',
      name: 'React Native',
      category: SkillCategory.mobile,
      level: SkillLevel.intermediate,
      icon: Icons.mobile_friendly,
      description: 'Cross-platform mobile development using React Native.',
      yearsOfExperience: 1,
      relatedProjects: [],
      isFeatured: false,
    ),

    // Frontend Development
    Skill(
      id: 'react',
      name: 'React',
      category: SkillCategory.frontend,
      level: SkillLevel.advanced,
      icon: Icons.web,
      description: 'Modern JavaScript library for building user interfaces.',
      yearsOfExperience: 2,
      relatedProjects: [
        '3',
        '5',
        '8',
      ], // Food Delivery Dashboard, Smart Parking, Real Estate
      isFeatured: true,
    ),
    Skill(
      id: 'typescript',
      name: 'TypeScript',
      category: SkillCategory.frontend,
      level: SkillLevel.advanced,
      icon: Icons.code_outlined,
      description:
          'Strongly typed programming language that builds on JavaScript.',
      yearsOfExperience: 2,
      relatedProjects: [''],
      isFeatured: true,
    ),
    Skill(
      id: 'javascript',
      name: 'JavaScript',
      category: SkillCategory.frontend,
      level: SkillLevel.advanced,
      icon: Icons.javascript,
      description:
          'Core web programming language for dynamic and interactive web applications.',
      yearsOfExperience: 3,
      relatedProjects: [''],
      isFeatured: true,
    ),
    Skill(
      id: 'html_css',
      name: 'HTML/CSS',
      category: SkillCategory.frontend,
      level: SkillLevel.advanced,
      icon: Icons.web_asset,
      description: 'Markup and styling languages for web development.',
      yearsOfExperience: 3,
      relatedProjects: [''],
      isFeatured: false,
    ),
    Skill(
      id: 'tailwind',
      name: 'Tailwind CSS',
      category: SkillCategory.frontend,
      level: SkillLevel.intermediate,
      icon: Icons.palette,
      description: 'Utility-first CSS framework for rapid UI development.',
      yearsOfExperience: 1,
      relatedProjects: [''],
      isFeatured: false,
    ),

    // Backend Development
    Skill(
      id: 'nodejs',
      name: 'Node.js',
      category: SkillCategory.backend,
      level: SkillLevel.advanced,
      icon: Icons.dns,
      description:
          'JavaScript runtime for building scalable server-side applications.',
      yearsOfExperience: 2,
      isFeatured: true,
    ),
    Skill(
      id: 'golang',
      name: 'Go',
      category: SkillCategory.backend,
      level: SkillLevel.intermediate,
      icon: Icons.speed,
      description:
          'Efficient programming language for backend services and microservices.',
      yearsOfExperience: 1,
      relatedProjects: [],
      isFeatured: false,
    ),
    Skill(
      id: 'laravel',
      name: 'Laravel',
      category: SkillCategory.backend,
      level: SkillLevel.intermediate,
      icon: Icons.web_outlined,
      description: 'PHP framework for web application development.',
      yearsOfExperience: 1,
      relatedProjects: [],
      isFeatured: false,
    ),
    Skill(
      id: 'python',
      name: 'Python',
      category: SkillCategory.backend,
      level: SkillLevel.intermediate,
      icon: Icons.smart_toy,
      description:
          'Versatile programming language for backend development and automation.',
      yearsOfExperience: 2,
      relatedProjects: [],
      isFeatured: true,
    ),

    // Database & Storage
    Skill(
      id: 'postgresql',
      name: 'PostgreSQL',
      category: SkillCategory.database,
      level: SkillLevel.advanced,
      icon: Icons.storage,
      description: 'Advanced open-source relational database system.',
      yearsOfExperience: 2,
      relatedProjects: [''],
      isFeatured: true,
    ),
    Skill(
      id: 'mongodb',
      name: 'MongoDB',
      category: SkillCategory.database,
      level: SkillLevel.intermediate,
      icon: Icons.storage_outlined,
      description: 'NoSQL document database for modern applications.',
      yearsOfExperience: 1,
      relatedProjects: [''],
      isFeatured: false,
    ),
    Skill(
      id: 'sqlite',
      name: 'SQLite',
      category: SkillCategory.database,
      level: SkillLevel.intermediate,
      icon: Icons.folder,
      description:
          'Lightweight database engine for mobile and desktop applications.',
      yearsOfExperience: 2,
      relatedProjects: [''],
      isFeatured: false,
    ),
    Skill(
      id: 'firebase',
      name: 'Firebase',
      category: SkillCategory.database,
      level: SkillLevel.advanced,
      icon: Icons.cloud,
      description: 'Google\'s mobile and web application development platform.',
      yearsOfExperience: 2,
      relatedProjects: [''],
      isFeatured: true,
    ),
    Skill(
      id: 'redis',
      name: 'Redis',
      category: SkillCategory.database,
      level: SkillLevel.intermediate,
      icon: Icons.memory,
      description:
          'In-memory data structure store for caching and session management.',
      yearsOfExperience: 1,
      relatedProjects: [],
      isFeatured: false,
    ),

    // Tools & DevOps
    Skill(
      id: 'git',
      name: 'Git',
      category: SkillCategory.tools,
      level: SkillLevel.advanced,
      icon: Icons.source,
      description:
          'Version control system for tracking changes in source code.',
      yearsOfExperience: 3,
      relatedProjects: [''],
      isFeatured: true,
    ),
    Skill(
      id: 'docker',
      name: 'Docker',
      category: SkillCategory.tools,
      level: SkillLevel.intermediate,
      icon: Icons.inventory_2,
      description: 'Containerization platform for application deployment.',
      yearsOfExperience: 1,
      relatedProjects: [],
      isFeatured: false,
    ),
    Skill(
      id: 'rest_api',
      name: 'REST API',
      category: SkillCategory.tools,
      level: SkillLevel.advanced,
      icon: Icons.api,
      description: 'RESTful web services design and implementation.',
      yearsOfExperience: 3,
      relatedProjects: [''],
      isFeatured: false,
    ),
    Skill(
      id: 'websocket',
      name: 'WebSocket',
      category: SkillCategory.tools,
      level: SkillLevel.intermediate,
      icon: Icons.swap_horiz,
      description: 'Real-time communication protocol for web applications.',
      yearsOfExperience: 1,
      relatedProjects: [''],
      isFeatured: false,
    ),
    Skill(
      id: 'socketio',
      name: 'Socket.io',
      category: SkillCategory.tools,
      level: SkillLevel.intermediate,
      icon: Icons.hub,
      description: 'Real-time bidirectional event-based communication.',
      yearsOfExperience: 1,
      relatedProjects: [''],
      isFeatured: false,
    ),
  ];

  // Get skills by category
  static List<Skill> getSkillsByCategory(SkillCategory category) {
    return skills.where((skill) => skill.category == category).toList();
  }

  // Get featured skills for homepage display
  static List<Skill> getFeaturedSkills() {
    return skills.where((skill) => skill.isFeatured).toList();
  }

  // Get skills by level
  static List<Skill> getSkillsByLevel(SkillLevel level) {
    return skills.where((skill) => skill.level == level).toList();
  }

  // Get all categories with their skills count
  static Map<SkillCategory, int> getCategoryStats() {
    final Map<SkillCategory, int> stats = {};
    for (final category in SkillCategory.values) {
      stats[category] = getSkillsByCategory(category).length;
    }
    return stats;
  }

  // Search skills by name
  static List<Skill> searchSkills(String query) {
    if (query.isEmpty) return skills;

    return skills
        .where(
          (skill) =>
              skill.name.toLowerCase().contains(query.toLowerCase()) ||
              skill.description.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  // Get skills related to a project
  static List<Skill> getSkillsForProject(String projectId) {
    return skills
        .where((skill) => skill.relatedProjects.contains(projectId))
        .toList();
  }
}
