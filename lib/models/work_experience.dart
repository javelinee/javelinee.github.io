class WorkExperience {
  final String id;
  final String position;
  final String company;
  final String startDate;
  final String endDate;
  final bool isPresent;
  final String description;
  final List<String> achievements;

  const WorkExperience({
    required this.id,
    required this.position,
    required this.company,
    required this.startDate,
    required this.endDate,
    this.isPresent = false,
    required this.description,
    required this.achievements,
  });
}

