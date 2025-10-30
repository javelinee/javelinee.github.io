import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/skill.dart';
import '../data/skills_data.dart';
import 'skill_card.dart';

class SkillsSection extends StatefulWidget {
  final bool showCategories;
  final bool showProgressBars;
  final int? maxSkillsToShow;
  final bool showOnlyFeatured;
  final VoidCallback? onViewAllPressed;

  const SkillsSection({
    super.key,
    this.showCategories = false,
    this.showProgressBars = false,
    this.maxSkillsToShow,
    this.showOnlyFeatured = false,
    this.onViewAllPressed,
  });

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    List<Skill> skillsToShow;
    if (widget.showOnlyFeatured) {
      skillsToShow = SkillsData.getFeaturedSkills();
    } else {
      skillsToShow = SkillsData.skills;
    }

    if (widget.maxSkillsToShow != null) {
      skillsToShow = skillsToShow.take(widget.maxSkillsToShow!).toList();
    }

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Skills',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    TextSpan(
                      text: '  &  ',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: colorScheme.primary,
                      ),
                    ),
                    TextSpan(
                      text: 'Technologies',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.onViewAllPressed != null)
                TextButton.icon(
                  onPressed: widget.onViewAllPressed,
                  icon: Icon(Icons.arrow_forward, size: 16),
                  label: Text('View All'),
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.primary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 24),

          // Skills Content
          if (widget.showCategories)
            _buildCategorizedSkills(skillsToShow, colorScheme)
          else
            _buildSkillsGrid(skillsToShow, colorScheme),
        ],
      ),
    );
  }

  Widget _buildCategorizedSkills(List<Skill> skills, ColorScheme colorScheme) {
    final categorizedSkills = <SkillCategory, List<Skill>>{};

    for (final skill in skills) {
      categorizedSkills.putIfAbsent(skill.category, () => []).add(skill);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: categorizedSkills.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Category Header
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 24,
                    decoration: BoxDecoration(
                      color: entry.key.color,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    entry.key.displayName,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '${entry.value.length}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: entry.key.color,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Skills in this category
              Wrap(
                spacing: 24,
                runSpacing: 24,
                children: entry.value.map((skill) {
                  return SizedBox(
                    width: 250,
                    height: 250,
                    child: _buildSkillChip(
                      skill,
                      colorScheme,
                      BoxConstraints(maxWidth: 250),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillsGrid(List<Skill> skills, ColorScheme colorScheme) {
    return Wrap(
      spacing: 24,
      runSpacing: 24,
      children: skills.map((skill) {
        return SizedBox(
          width: 250,
          height: 250,
          child: _buildSkillChip(
            skill,
            colorScheme,
            BoxConstraints(maxWidth: 250),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSkillChip(
    Skill skill,
    ColorScheme colorScheme,
    BoxConstraints constraints,
  ) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + (skill.id.hashCode % 400)),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: SkillCard(
            skill: skill,
            showProgressBar: widget.showProgressBars,
            onTap: () => _showSkillDetails(skill),
            width: 250,
            height: 250,
          ),
        );
      },
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
                child: _buildStatCard(
                  context,
                  'Level',
                  skill.level.displayName,
                  skill.level.color,
                  Icons.trending_up,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildStatCard(
                  context,
                  'Experience',
                  '${skill.yearsOfExperience} year${skill.yearsOfExperience != 1 ? 's' : ''}',
                  skill.category.color,
                  Icons.schedule,
                ),
              ),
            ],
          ),

          // Related Projects
          if (skill.relatedProjects.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text(
              'Related Projects',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: skill.relatedProjects.map((projectId) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: colorScheme.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: colorScheme.primary.withOpacity(0.3),
                    ),
                  ),
                  child: Text(
                    'Project #$projectId',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    Color color,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: color),
              const SizedBox(width: 6),
              Text(
                label,
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
            value,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
