import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/skills_section.dart';
import '../widgets/skill_card.dart';
import '../models/skill.dart';
import '../data/skills_data.dart';

class SkillsPage extends StatefulWidget {
  const SkillsPage({super.key});

  @override
  State<SkillsPage> createState() => _SkillsPageState();
}

class _SkillsPageState extends State<SkillsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late List<SkillCategory> _categories;

  @override
  void initState() {
    super.initState();
    // Filter categories to only show those that have skills
    _categories = SkillCategory.values
        .where(
          (category) =>
              SkillsData.skills.any((skill) => skill.category == category),
        )
        .toList();
    _tabController = TabController(length: _categories.length + 1, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild when tab changes
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isWeb = MediaQuery.of(context).size.width > 600;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverToBoxAdapter(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: isWeb ? 32 : 16,
                vertical: isWeb ? 32 : 24,
              ),
              child: Column(
                children: [
                  Text(
                    'Technical Expertise',
                    style: GoogleFonts.poppins(
                      fontSize: isWeb ? 48 : 32,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isWeb ? 24 : 16),
                  Text(
                    'Explore my technical skills and expertise across different technologies and frameworks',
                    style: GoogleFonts.poppins(
                      fontSize: isWeb ? 18 : 16,
                      color: colorScheme.onSurface.withOpacity(0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isWeb ? 32 : 24),

                  // Category Filter
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildCategoryChip(
                          context,
                          'All',
                          _tabController.index == 0,
                          () => _tabController.animateTo(0),
                        ),
                        const SizedBox(width: 12),
                        ..._categories.asMap().entries.map(
                          (entry) => Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: _buildCategoryChip(
                              context,
                              entry.value.displayName,
                              _tabController.index == entry.key + 1,
                              () => _tabController.animateTo(entry.key + 1),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: isWeb ? 24 : 16),
                ],
              ),
            ),
          ),

          // Tab Content
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAllSkillsView(),
                ..._categories.map((category) => _buildCategoryView(category)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryChip(
    BuildContext context,
    String label,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? colorScheme.primary : colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isSelected
                  ? colorScheme.primary
                  : colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: isSelected ? colorScheme.onPrimary : colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAllSkillsView() {
    return const SingleChildScrollView(
      padding: EdgeInsets.all(24),
      child: SkillsSection(showCategories: true, showProgressBars: true),
    );
  }

  Widget _buildCategoryView(SkillCategory category) {
    final categorySkills = SkillsData.getSkillsByCategory(category);
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: category.color.withOpacity(0.2)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: category.color.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        _getCategoryIcon(category),
                        color: category.color,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            category.displayName,
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: colorScheme.onSurface,
                            ),
                          ),
                          Text(
                            '${categorySkills.length} skill${categorySkills.length != 1 ? 's' : ''}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: category.color,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  _getCategoryDescription(category),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: colorScheme.onSurface.withOpacity(0.7),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Skills Wrap
          Wrap(
            spacing: 24,
            runSpacing: 24,
            children: categorySkills.map((skill) {
              return SkillCard(
                skill: skill,
                showProgressBar: true,
                width: 250,
                height: 250,
                onTap: () => _showSkillDetails(skill),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  void _showSkillDetails(Skill skill) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).colorScheme.surface,
      builder: (context) => _SkillDetailsSheet(skill: skill),
    );
  }

  IconData _getCategoryIcon(SkillCategory category) {
    switch (category) {
      case SkillCategory.mobile:
        return Icons.phone_android;
      case SkillCategory.frontend:
        return Icons.web;
      case SkillCategory.backend:
        return Icons.dns;
      case SkillCategory.database:
        return Icons.storage;
      case SkillCategory.tools:
        return Icons.build;
      case SkillCategory.other:
        return Icons.more_horiz;
    }
  }

  String _getCategoryDescription(SkillCategory category) {
    switch (category) {
      case SkillCategory.mobile:
        return 'Native and cross-platform mobile application development technologies including Flutter, React Native, and native iOS/Android development.';
      case SkillCategory.frontend:
        return 'Modern frontend technologies for building responsive and interactive user interfaces including React, TypeScript, and CSS frameworks.';
      case SkillCategory.backend:
        return 'Server-side technologies and frameworks for building scalable APIs and web services including Node.js, Go, Python, and Laravel.';
      case SkillCategory.database:
        return 'Database technologies and cloud services for data storage, management, and real-time synchronization including SQL and NoSQL databases.';
      case SkillCategory.tools:
        return 'Development tools, version control systems, and DevOps technologies for efficient software development and deployment workflows.';
      case SkillCategory.other:
        return 'Additional technologies and skills that complement the core development stack.';
    }
  }
}

class _SkillDetailsSheet extends StatelessWidget {
  final Skill skill;

  const _SkillDetailsSheet({required this.skill});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: skill.category.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: skill.category.color.withOpacity(0.3),
                  ),
                ),
                child: Icon(skill.icon, size: 28, color: skill.category.color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      skill.name,
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: skill.category.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        skill.category.displayName,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: skill.category.color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Description
          Text(
            skill.description,
            style: GoogleFonts.poppins(
              fontSize: 16,
              color: colorScheme.onSurface.withOpacity(0.8),
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),

          // Stats Row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: skill.level.color.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: skill.level.color.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.trending_up,
                            size: 16,
                            color: skill.level.color,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Level',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        skill.level.displayName,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: skill.level.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: skill.category.color.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: skill.category.color.withOpacity(0.2),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.schedule,
                            size: 16,
                            color: skill.category.color,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Experience',
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${skill.yearsOfExperience} year${skill.yearsOfExperience != 1 ? 's' : ''}',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: skill.category.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
