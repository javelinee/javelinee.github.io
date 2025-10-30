import '../models/project.dart';

class DummyProjects {
  static final List<Project> projects = [
    Project(
      id: '1',
      title: 'Cliché',
      description: 'An application providing online consultation services.',
      technologies: ["Figma"],
      category: ProjectCategory.mobile,
      completedDate: DateTime(2020, 12, 31),
      driveUrl:
          'https://drive.google.com/drive/folders/1zaI-6G1PebzGGND9XWWOHFwVCrnoauUp?usp=drive_link',
      imageUrl: 'assets/cliche.png',
    ),
    Project(
      id: '2',
      title: 'Money Man (iOS)',
      description: 'Money management made easy.',
      technologies: ["Swift", "Ruby"],
      category: ProjectCategory.mobile,
      completedDate: DateTime(2020, 9, 30),
      githubUrl:
          'https://github.com/Mobile-Community-Solution-Team/Tournal/tree/master',
      imageUrl: 'assets/money_man.png',
    ),
    Project(
      id: '3',
      title: 'Uri Book',
      description:
          'An online learning service providing educational materials for the public.',
      technologies: ["Flutter", "Firebase"],
      category: ProjectCategory.mobile,
      completedDate: DateTime(2020, 7, 31),
      driveUrl:
          'https://drive.google.com/file/d/17tjtSxIS4cYTudIm2Hq-fLv9FgjVBx2e/view?usp=drive_link',
      imageUrl: 'assets/uri_book.png',
    ),

    Project(
      id: '4',
      title: 'Tournal',
      description:
          'A simple journal trip app for planning activities and traveling with your buddy.',
      technologies: ["Java", "Firebase"],
      category: ProjectCategory.mobile,
      completedDate: DateTime(2020, 6, 30),
      driveUrl: 'https://drive.google.com/file/d/1def456ghi789/view',
      imageUrl: 'assets/tournal.png',
    ),
    Project(
      id: '5',
      title: 'Labyrinth Rush',
      description:
          'A game built using Construct 2 software, inspired by the Flappy Bird game.',
      technologies: ['Construct 2'],
      category: ProjectCategory.game,
      completedDate: DateTime(2019, 12, 31),
      driveUrl:
          'https://docs.google.com/presentation/d/1r07VwaTWHqtR5zx6Zl4u8O3uivuoxCLa/edit?usp=sharing&ouid=101983018582344292369&rtpof=true&sd=true',
      imageUrl: 'assets/labyrinth_rush.png',
    ),
    Project(
      id: '6',
      title: 'Password Manager',
      description:
          'A password manager app that allows you to store and manage your passwords securely.',
      technologies: ['Flutter', 'Dart', 'Firebase', 'Python'],
      category: ProjectCategory.mobile,
      completedDate: DateTime(2022, 1, 30),
      githubUrl: 'https://github.com/jesselynhartandi/password-manager',
      liveUrl:
          'https://drive.google.com/file/d/1EwNQWaRC1mop8BmGgjYBkWAq55_mG7Uq/view?usp=drive_link',
      imageUrl: 'assets/password_manager.png',
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
