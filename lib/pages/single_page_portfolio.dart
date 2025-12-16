import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_info.dart';
import '../data/work_experience_data.dart';
import '../data/dummy_projects.dart';
import '../models/project.dart';

class SinglePagePortfolio extends StatefulWidget {
  const SinglePagePortfolio({super.key});

  @override
  State<SinglePagePortfolio> createState() => SinglePagePortfolioState();
}

class SinglePagePortfolioState extends State<SinglePagePortfolio> {
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  void scrollToExperience() {
    _scrollToSection(experienceKey);
  }

  void scrollToProjects() {
    _scrollToSection(projectsKey);
  }

  void scrollToContact() {
    _scrollToSection(contactKey);
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark
          ? const Color(0xFF0a1628)
          : const Color(0xFFF5F5F7),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Hero Section
            _buildHeroSection(context),

            // Work Experience Section
            Container(
              key: experienceKey,
              child: _buildWorkExperienceSection(context),
            ),

            // Projects Section
            Container(key: projectsKey, child: _buildProjectsSection(context)),

            // Contact Section
            Container(key: contactKey, child: _buildContactSection(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: isDesktop ? 80 : 24,
        right: isDesktop ? 80 : 24,
        top: isDesktop ? 50 : 40,
        bottom: isDesktop ? 30 : 24,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile Picture
                Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 3,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/me.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF1b263b),
                          child: const Icon(
                            Icons.person,
                            size: 90,
                            color: Color(0xFF4a5568),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 60),

                // Text Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ContactInfo.personal.name,
                        style: GoogleFonts.inter(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: theme.colorScheme.onSurface,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        ContactInfo.personal.title,
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF06b6d4),
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        ContactInfo.personal.shortBio ??
                            ContactInfo.personal.bio,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: isDark
                              ? const Color(0xFFa0aec0)
                              : const Color(0xFF64748b),
                          height: 1.6,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Action Buttons
                      Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          _buildPrimaryButton(
                            label: 'Get in touch',
                            icon: Icons.email_outlined,
                            onPressed: () => _launchUrl(
                              'mailto:${ContactInfo.personal.email}',
                            ),
                          ),
                          _buildSecondaryButton(
                            label: 'LinkedIn',
                            icon: Icons.work_outline,
                            onPressed: () => _launchUrl(
                              ContactInfo.personal.linkedinUrl ?? '',
                            ),
                          ),
                          _buildSecondaryButton(
                            label: 'GitHub',
                            icon: Icons.code,
                            onPressed: () => _launchUrl(
                              ContactInfo.personal.githubUrl ?? '',
                            ),
                          ),
                          _buildSecondaryButton(
                            label: 'Medium',
                            icon: Icons.article_outlined,
                            onPressed: () => _launchUrl(
                              ContactInfo.personal.mediumUrl ?? '',
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          : Column(
              children: [
                // Profile Picture
                Container(
                  width: 140,
                  height: 140,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.1),
                      width: 3,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/me.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xFF1b263b),
                          child: const Icon(
                            Icons.person,
                            size: 70,
                            color: Color(0xFF4a5568),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Text Content
                Text(
                  ContactInfo.personal.name,
                  style: GoogleFonts.inter(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                    height: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Text(
                  ContactInfo.personal.title,
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF06b6d4),
                    height: 1.4,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  ContactInfo.personal.shortBio ?? ContactInfo.personal.bio,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? const Color(0xFFa0aec0)
                        : const Color(0xFF64748b),
                    height: 1.6,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),

                // Action Buttons (Stacked on mobile)
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: _buildPrimaryButton(
                        label: 'Get in touch',
                        icon: Icons.email_outlined,
                        onPressed: () =>
                            _launchUrl('mailto:${ContactInfo.personal.email}'),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildSecondaryButton(
                            label: 'LinkedIn',
                            icon: Icons.work_outline,
                            onPressed: () => _launchUrl(
                              ContactInfo.personal.linkedinUrl ?? '',
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildSecondaryButton(
                            label: 'GitHub',
                            icon: Icons.code,
                            onPressed: () => _launchUrl(
                              ContactInfo.personal.githubUrl ?? '',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: _buildSecondaryButton(
                        label: 'Medium',
                        icon: Icons.article_outlined,
                        onPressed: () =>
                            _launchUrl(ContactInfo.personal.mediumUrl ?? ''),
                      ),
                    ),
                  ],
                ),
              ],
            ),
    );
  }

  Widget _buildWorkExperienceSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final experiences = WorkExperienceData.getExperiences();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: isDesktop ? 80 : 24,
        right: isDesktop ? 80 : 24,
        top: 40,
        bottom: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Work Experience',
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 36 : 28,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 40),

          // Timeline
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: experiences.length,
            itemBuilder: (context, index) {
              final experience = experiences[index];
              final isLast = index == experiences.length - 1;

              return _buildExperienceItem(
                context: context,
                experience: experience,
                isLast: isLast,
                isDesktop: isDesktop,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProjectsSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = MediaQuery.of(context).size.width > 900;
    final projects = DummyProjects.projects;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: isDesktop ? 80 : 24,
        right: isDesktop ? 80 : 24,
        bottom: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Featured Projects',
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 36 : 28,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 40),

          // Projects Grid
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = constraints.maxWidth > 1200
                  ? (constraints.maxWidth - 48) / 3
                  : constraints.maxWidth > 600
                  ? (constraints.maxWidth - 24) / 2
                  : constraints.maxWidth;

              return Wrap(
                spacing: 24,
                runSpacing: 24,
                children: projects
                    .map(
                      (project) => SizedBox(
                        width: cardWidth,
                        child: _buildProjectCard(context, project),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = MediaQuery.of(context).size.width > 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(
        left: isDesktop ? 80 : 24,
        right: isDesktop ? 80 : 24,
        top: 40,
        bottom: 40,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Large Contact Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF14b8a6), Color(0xFF0891b2)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF06b6d4).withOpacity(0.3),
                  blurRadius: 30,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Get in Touch',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'I\'m always interested in hearing about new projects and opportunities.',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Contact Icons
                Row(
                  children: [
                    _buildContactIconButton(
                      icon: Icons.email,
                      tooltip: 'Email',
                      onTap: () =>
                          _launchUrl('mailto:${ContactInfo.personal.email}'),
                    ),
                    const SizedBox(width: 16),
                    if (ContactInfo.personal.linkedinUrl != null)
                      _buildContactImageButton(
                        imagePath: 'assets/linkedin_icon.png',
                        tooltip: 'LinkedIn',
                        onTap: () =>
                            _launchUrl(ContactInfo.personal.linkedinUrl!),
                      ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 60),

          // Footer
          Center(
            child: Text(
              '© ${DateTime.now().year} All rights reserved.',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: isDark
                    ? const Color(0xFF718096)
                    : const Color(0xFF94a3b8),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildExperienceItem({
    required BuildContext context,
    required experience,
    required bool isLast,
    required bool isDesktop,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: EdgeInsets.only(bottom: isDesktop ? 48 : 20),
      padding: EdgeInsets.all(isDesktop ? 18 : 10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1b263b) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : const Color(0xFFe2e8f0),
          width: 1,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Responsive header layout
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            experience.position,
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            experience.company,
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: isDark
                                  ? const Color(0xFF718096)
                                  : const Color(0xFF64748b),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : const Color(0xFFf1f5f9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 14,
                            color: isDark
                                ? const Color(0xFF718096)
                                : const Color(0xFF64748b),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${experience.startDate} - ${experience.endDate}',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? const Color(0xFF718096)
                                  : const Color(0xFF64748b),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.position,
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      experience.company,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: isDark
                            ? const Color(0xFF718096)
                            : const Color(0xFF64748b),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.white.withOpacity(0.05)
                            : const Color(0xFFf1f5f9),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 10,
                            color: isDark
                                ? const Color(0xFF718096)
                                : const Color(0xFF64748b),
                          ),
                          const SizedBox(width: 3),
                          Text(
                            '${experience.startDate} - ${experience.endDate}',
                            style: GoogleFonts.inter(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: isDark
                                  ? const Color(0xFF718096)
                                  : const Color(0xFF64748b),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          SizedBox(height: isDesktop ? 12 : 6),
          Text(
            experience.description,
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 14 : 11,
              fontWeight: FontWeight.w400,
              color: isDark ? const Color(0xFFa0aec0) : const Color(0xFF64748b),
              height: isDesktop ? 1.5 : 1.3,
            ),
          ),
          SizedBox(height: isDesktop ? 12 : 6),

          // Achievements
          ...experience.achievements.map(
            (achievement) => Padding(
              padding: EdgeInsets.only(bottom: isDesktop ? 6 : 3),
              child: Text(
                achievement,
                style: GoogleFonts.inter(
                  fontSize: isDesktop ? 13 : 10,
                  fontWeight: FontWeight.w400,
                  color: isDark
                      ? const Color(0xFFa0aec0)
                      : const Color(0xFF64748b),
                  height: isDesktop ? 1.4 : 1.25,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(BuildContext context, Project project) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1a1f29) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.05)
              : const Color(0xFFe2e8f0),
          width: 1,
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Project Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            child: Container(
              width: double.infinity,
              height: 180,
              color: const Color(0xFF2d3748),
              child: project.imageUrl != null
                  ? Image.asset(
                      project.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Icon(
                            Icons.image_outlined,
                            size: 64,
                            color: Color(0xFF4a5568),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Icon(
                        Icons.code,
                        size: 64,
                        color: Color(0xFF4a5568),
                      ),
                    ),
            ),
          ),

          // Project Info
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(Icons.code, size: 16, color: Color(0xFF06b6d4)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        project.title,
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  project.description,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? const Color(0xFFa0aec0)
                        : const Color(0xFF64748b),
                    height: 1.4,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: project.technologies.take(3).map((tech) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFF06b6d4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        tech,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF06b6d4),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                // Testing and Play Store buttons
                if (project.testingGroupUrl != null ||
                    project.playStoreUrl != null) ...[
                  const SizedBox(height: 12),
                  // Note for closed testing
                  if (project.testingGroupUrl != null &&
                      project.playStoreUrl != null)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF06b6d4).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: const Color(0xFF06b6d4).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 12,
                            color: const Color(0xFF06b6d4),
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              'To install this game, make sure you already join the Group Test',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: isDark
                                    ? const Color(0xFF06b6d4)
                                    : const Color(0xFF0891b2),
                                height: 1.3,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  Row(
                    children: [
                      if (project.testingGroupUrl != null)
                        Expanded(
                          child: _buildProjectButton(
                            label: 'Join Test',
                            icon: Icons.group_add,
                            onPressed: () =>
                                _launchUrl(project.testingGroupUrl!),
                            isDark: isDark,
                          ),
                        ),
                      if (project.testingGroupUrl != null &&
                          project.playStoreUrl != null)
                        const SizedBox(width: 8),
                      if (project.playStoreUrl != null)
                        Expanded(
                          child: _buildProjectButton(
                            label: 'Play Store',
                            icon: Icons.android,
                            onPressed: () => _launchUrl(project.playStoreUrl!),
                            isDark: isDark,
                          ),
                        ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactIconButton({
    required IconData icon,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildContactImageButton({
    required String imagePath,
    required String tooltip,
    required VoidCallback onTap,
  }) {
    return Tooltip(
      message: tooltip,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            padding: const EdgeInsets.all(10),
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.link, color: Colors.white, size: 28);
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPrimaryButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF06b6d4),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        elevation: 0,
        textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildSecondaryButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 18),
      label: Text(label),
      style: OutlinedButton.styleFrom(
        foregroundColor: const Color(0xFFa0aec0),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(color: Colors.white.withOpacity(0.2), width: 1),
        textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildProjectButton({
    required String label,
    required IconData icon,
    required VoidCallback onPressed,
    required bool isDark,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 12),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF06b6d4),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        elevation: 0,
        textStyle: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }
}
