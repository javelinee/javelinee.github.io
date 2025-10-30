import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project.dart';
import '../data/dummy_projects.dart';

class ProjectsPage extends StatefulWidget {
  const ProjectsPage({super.key});

  @override
  State<ProjectsPage> createState() => _ProjectsPageState();
}

class _ProjectsPageState extends State<ProjectsPage> {
  ProjectCategory? selectedCategory;
  List<Project> filteredProjects = DummyProjects.projects;

  void _filterProjects(ProjectCategory? category) {
    setState(() {
      selectedCategory = category;
      if (category == null) {
        filteredProjects = DummyProjects.projects;
      } else {
        filteredProjects = DummyProjects.getProjectsByCategory(category);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final screenWidth = MediaQuery.of(context).size.width;
    final isWeb = screenWidth > 768;

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
                    'My Projects',
                    style: GoogleFonts.poppins(
                      fontSize: isWeb ? 48 : 32,
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: isWeb ? 24 : 16),
                  Text(
                    'Explore the projects I\'ve worked on and the technologies I\'ve used',
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
                          selectedCategory == null,
                          () => _filterProjects(null),
                        ),
                        const SizedBox(width: 12),
                        ...ProjectCategory.values
                            .where(
                              (category) => DummyProjects.projects.any(
                                (project) => project.category == category,
                              ),
                            )
                            .map(
                              (category) => Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: _buildCategoryChip(
                                  context,
                                  category.displayName,
                                  selectedCategory == category,
                                  () => _filterProjects(category),
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

          // Projects Wrap
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: isWeb ? 24 : 12),
              child: Wrap(
                spacing: 24,
                runSpacing: 24,
                children: filteredProjects.asMap().entries.map((entry) {
                  final index = entry.key;
                  final project = entry.value;

                  return TweenAnimationBuilder<double>(
                    duration: Duration(milliseconds: 300 + (index * 100)),
                    tween: Tween(begin: 0.0, end: 1.0),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 * (1 - value)),
                        child: Opacity(
                          opacity: value,
                          child: SizedBox(
                            width: 240,
                            height: 280,
                            child: _buildProjectCard(context, project, isWeb),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
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

  Widget _buildProjectCard(BuildContext context, Project project, bool isWeb) {
    final colorScheme = Theme.of(context).colorScheme;

    return _ProjectCardWidget(
      project: project,
      isWeb: isWeb,
      colorScheme: colorScheme,
      onTap: () => _showProjectDetails(context, project),
    );
  }

  void _showProjectDetails(BuildContext context, Project project) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      project.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              if (project.imageUrl != null) ...[
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    project.imageUrl!,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 200,
                      color: Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        _getCategoryIcon(project.category),
                        size: 64,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
              Text(
                project.description,
                style: GoogleFonts.poppins(fontSize: 14, height: 1.5),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: project.technologies
                    .map(
                      (tech) => Chip(
                        label: Text(
                          tech,
                          style: GoogleFonts.poppins(fontSize: 12),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  if (project.githubUrl != null)
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => _launchUrl(project.githubUrl!),
                        icon: const Icon(Icons.code),
                        label: const Text('View Code'),
                      ),
                    ),
                  if (project.githubUrl != null && project.liveUrl != null)
                    const SizedBox(width: 12),
                  if (project.liveUrl != null)
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _launchUrl(project.liveUrl!),
                        icon: const Icon(Icons.launch),
                        label: const Text('Live Demo'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
  }

  IconData _getCategoryIcon(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.web:
        return Icons.web;
      case ProjectCategory.mobile:
        return Icons.phone_android;
      case ProjectCategory.desktop:
        return Icons.computer;
      case ProjectCategory.backend:
        return Icons.dns;
      case ProjectCategory.game:
        return Icons.games;
      case ProjectCategory.other:
        return Icons.code;
    }
  }
}

class _ProjectCardWidget extends StatefulWidget {
  final Project project;
  final bool isWeb;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _ProjectCardWidget({
    required this.project,
    required this.isWeb,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  State<_ProjectCardWidget> createState() => _ProjectCardWidgetState();
}

class _ProjectCardWidgetState extends State<_ProjectCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.05,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter(PointerEvent details) {
    setState(() {
      _isHovered = true;
    });
    _controller.forward();
  }

  void _onExit(PointerEvent details) {
    setState(() {
      _isHovered = false;
    });
    _controller.reverse();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Could not launch $url')));
      }
    }
  }

  IconData _getCategoryIcon(ProjectCategory category) {
    switch (category) {
      case ProjectCategory.web:
        return Icons.web;
      case ProjectCategory.mobile:
        return Icons.phone_android;
      case ProjectCategory.desktop:
        return Icons.computer;
      case ProjectCategory.backend:
        return Icons.dns;
      case ProjectCategory.game:
        return Icons.games;
      case ProjectCategory.other:
        return Icons.code;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: _onEnter,
      onExit: _onExit,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Card(
              elevation: _isHovered
                  ? (widget.isWeb ? 12 : 6)
                  : (widget.isWeb ? 8 : 4),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.isWeb ? 16 : 12),
              ),
              child: InkWell(
                onTap: widget.onTap,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Project Image
                    widget.project.imageUrl != null
                        ? ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                            child: Container(
                              width: 240,
                              height: 110,
                              alignment: Alignment.center,
                              child: Image.asset(
                                widget.project.imageUrl!,
                                width: 240,
                                height: 110,
                                fit: BoxFit.cover,
                                alignment: Alignment.center,
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                    height: 110,
                                    width: 240,
                                    decoration: BoxDecoration(
                                      color:
                                          widget.colorScheme.primaryContainer,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16),
                                      ),
                                    ),
                                    child: Center(
                                      child: Icon(
                                        _getCategoryIcon(
                                          widget.project.category,
                                        ),
                                        size: 40,
                                        color: widget
                                            .colorScheme
                                            .onPrimaryContainer,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : Container(
                            height: 100,
                            width: 240,
                            decoration: BoxDecoration(
                              color: widget.colorScheme.primaryContainer,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            child: Center(
                              child: Icon(
                                _getCategoryIcon(widget.project.category),
                                size: 40,
                                color: widget.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ),

                    // Project Content
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Main Content Group
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category Badge
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color:
                                        widget.colorScheme.secondaryContainer,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Text(
                                    widget.project.category.displayName,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                      color: widget
                                          .colorScheme
                                          .onSecondaryContainer,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 6),

                                // Project Title
                                Text(
                                  widget.project.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: widget.colorScheme.onSurface,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),

                                // Project Description
                                Text(
                                  widget.project.description,
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: widget.colorScheme.onSurface
                                        .withOpacity(0.7),
                                    height: 1.3,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),

                                // Technologies
                                Wrap(
                                  spacing: 4,
                                  runSpacing: 4,
                                  children: widget.project.technologies
                                      .take(
                                        3,
                                      ) // Limit to 3 technologies to save space
                                      .map(
                                        (tech) => Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 2,
                                          ),
                                          decoration: BoxDecoration(
                                            color: widget.colorScheme.primary
                                                .withOpacity(0.1),
                                            borderRadius: BorderRadius.circular(
                                              6,
                                            ),
                                          ),
                                          child: Text(
                                            tech,
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              color: widget.colorScheme.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ],
                            ),

                            // Action Buttons (at bottom)
                            _buildActionButtons(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActionButtons() {
    final buttons = <Widget>[];

    // GitHub button
    if (widget.project.githubUrl != null) {
      buttons.add(
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _launchUrl(widget.project.githubUrl!),
            icon: const Icon(Icons.code, size: 14),
            label: const Text('Code'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 4),
              textStyle: GoogleFonts.poppins(fontSize: 11),
            ),
          ),
        ),
      );
    }

    // Drive button
    if (widget.project.driveUrl != null) {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 4));
      buttons.add(
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () => _launchUrl(widget.project.driveUrl!),
            icon: const Icon(Icons.folder, size: 14),
            label: const Text('Drive'),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 4),
              textStyle: GoogleFonts.poppins(fontSize: 11),
            ),
          ),
        ),
      );
    }

    // Live/Demo button
    if (widget.project.liveUrl != null) {
      if (buttons.isNotEmpty) buttons.add(const SizedBox(width: 4));
      buttons.add(
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () => _launchUrl(widget.project.liveUrl!),
            icon: const Icon(Icons.launch, size: 14),
            label: const Text('Demo'),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 4),
              textStyle: GoogleFonts.poppins(fontSize: 11),
            ),
          ),
        ),
      );
    }

    return buttons.isNotEmpty
        ? Row(children: buttons)
        : const SizedBox.shrink();
  }
}
