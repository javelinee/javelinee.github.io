import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/contact_info.dart';
import '../data/work_experience_data.dart';
import '../data/dummy_projects.dart';
import '../models/project.dart';
import '../utils/responsive_breakpoints.dart';

class SinglePagePortfolio extends StatefulWidget {
  const SinglePagePortfolio({super.key});

  @override
  State<SinglePagePortfolio> createState() => SinglePagePortfolioState();
}

class SinglePagePortfolioState extends State<SinglePagePortfolio> {
  final GlobalKey experienceKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  double _contentMaxWidth(BuildContext context) {
    if (!ResponsiveBreakpoints.isDesktopUp(context)) return double.infinity;
    return ResponsiveBreakpoints.isWideUp(context) ? 1200.0 : 1100.0;
  }

  EdgeInsets _sectionPadding(
    BuildContext context, {
    double top = 26,
    double bottom = 26,
  }) {
    final isDesktop = ResponsiveBreakpoints.isDesktopUp(context);
    final horizontal = isDesktop ? 56.0 : 20.0;
    return EdgeInsets.only(
      left: horizontal,
      right: horizontal,
      top: top,
      bottom: bottom,
    );
  }

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
          : const Color(0xFFF6F8FC),
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
    final isDesktop = ResponsiveBreakpoints.isDesktopUp(context);

    final maxWidth = _contentMaxWidth(context);

    return Container(
      width: double.infinity,
      padding: _sectionPadding(context, top: isDesktop ? 28 : 20, bottom: 12),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(flex: 3, child: _buildProfileHeroCard(context)),
                      const SizedBox(width: 24),
                      Expanded(flex: 2, child: _buildAvailabilityCard(context)),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _buildProfileHeroCard(context),
                    const SizedBox(height: 16),
                    _buildAvailabilityCard(context),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildProfileHeroCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF101a2c) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : const Color(0xFFE6ECF5),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Stack(
        children: [
          // Faint watermark icon
          Positioned(
            right: -10,
            top: -10,
            child: Icon(
              Icons.data_usage_outlined,
              size: 110,
              color: isDark
                  ? Colors.white.withOpacity(0.035)
                  : const Color(0xFF2563EB).withOpacity(0.05),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isDark
                            ? Colors.white.withOpacity(0.08)
                            : const Color(0xFFE6ECF5),
                      ),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/me.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: isDark
                                ? const Color(0xFF1b263b)
                                : const Color(0xFFF1F5F9),
                            child: Icon(
                              Icons.person,
                              size: 28,
                              color: theme.colorScheme.onSurface.withOpacity(0.45),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ContactInfo.personal.name,
                          style: GoogleFonts.inter(
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            color: theme.colorScheme.onSurface,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          ContactInfo.personal.title,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? const Color(0xFF93C5FD)
                                : const Color(0xFF2563EB),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Text(
                ContactInfo.personal.shortBio ?? ContactInfo.personal.bio,
                style: GoogleFonts.inter(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w400,
                  color: isDark ? const Color(0xFFa0aec0) : const Color(0xFF64748b),
                  height: 1.6,
                ),
              ),
              const Spacer(),
              _buildPrimaryButton(
                label: 'View Projects',
                icon: Icons.rocket_launch_outlined,
                onPressed: scrollToProjects,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvailabilityCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Widget chip(String label) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : const Color(0xFFF1F5FF),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : const Color(0xFFE6ECF5),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface.withOpacity(0.75),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF101a2c) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : const Color(0xFFE6ECF5),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
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
                width: 34,
                height: 34,
                decoration: BoxDecoration(
                  color: isDark
                      ? Colors.white.withOpacity(0.06)
                      : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.hub_outlined,
                  size: 18,
                  color: isDark
                      ? const Color(0xFF93C5FD)
                      : const Color(0xFF2563EB),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1d4ed8).withOpacity(0.25)
                      : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF2563EB).withOpacity(0.4)
                        : const Color(0xFFBFDBFE),
                  ),
                ),
                child: Text(
                  'SOFTWARE ENGINEER',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: isDark
                        ? const Color(0xFF93C5FD)
                        : const Color(0xFF2563EB),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'Professional Networking',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Building connections and sharing insights in the mobile development ecosystem.',
            style: GoogleFonts.inter(
              fontSize: 12.5,
              fontWeight: FontWeight.w400,
              color: isDark
                  ? const Color(0xFFa0aec0)
                  : const Color(0xFF64748b),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'CORE EXPERTISE',
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
              color: theme.colorScheme.onSurface.withOpacity(0.55),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              chip('Flutter'),
              chip('Dart'),
              chip('Firebase'),
              chip('REST APIs'),
              chip('Node.js'),
              chip('State Management'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWorkExperienceSection(BuildContext context) {
    final experiences = WorkExperienceData.getExperiences();
    final maxWidth = _contentMaxWidth(context);

    return Container(
      width: double.infinity,
      padding: _sectionPadding(context, top: 26, bottom: 26),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(
                context,
                icon: Icons.work_outline,
                title: 'Professional Experience',
              ),
              const SizedBox(height: 16),
              _buildExperienceCard(context, experiences: experiences),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required IconData icon,
    required String title,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: isDark
                ? Colors.white.withOpacity(0.06)
                : const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(
            icon,
            size: 16,
            color: isDark ? const Color(0xFF93C5FD) : const Color(0xFF2563EB),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildExperienceCard(
    BuildContext context, {
    required List experiences,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = ResponsiveBreakpoints.isDesktopUp(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 18 : 14,
        vertical: isDesktop ? 14 : 12,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF101a2c) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : const Color(0xFFE6ECF5),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
      ),
      child: Column(
        children: [
          for (int i = 0; i < experiences.length; i++) ...[
            _buildExperienceRow(context, experience: experiences[i]),
            if (i != experiences.length - 1) ...[
              const SizedBox(height: 10),
              Divider(
                height: 1,
                color: isDark
                    ? Colors.white.withOpacity(0.06)
                    : const Color(0xFFE6ECF5),
              ),
              const SizedBox(height: 10),
            ],
          ],
        ],
      ),
    );
  }

  Widget _buildExperienceRow(
    BuildContext context, {
    required dynamic experience,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = ResponsiveBreakpoints.isDesktopUp(context);

    final dateText = experience.isPresent == true
        ? '${experience.startDate} — Present'
        : '${experience.startDate} — ${experience.endDate}';

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: isDesktop ? 170 : 120,
          child: Text(
            dateText,
            style: GoogleFonts.inter(
              fontSize: isDesktop ? 12.5 : 11.5,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onSurface.withOpacity(0.55),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      experience.company,
                      style: GoogleFonts.inter(
                        fontSize: isDesktop ? 15 : 14,
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              Text(
                experience.position,
                style: GoogleFonts.inter(
                  fontSize: isDesktop ? 13.5 : 12.5,
                  fontWeight: FontWeight.w700,
                  color: isDark
                      ? const Color(0xFF93C5FD)
                      : const Color(0xFF2563EB),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                experience.description,
                style: GoogleFonts.inter(
                  fontSize: isDesktop ? 12.8 : 12.2,
                  fontWeight: FontWeight.w500,
                  color: isDark
                      ? const Color(0xFFa0aec0)
                      : const Color(0xFF64748b),
                  height: 1.35,
                ),
              ),
              const SizedBox(height: 10),
              ...experience.achievements
                  .take(isDesktop ? 3 : 2)
                  .map<Widget>(
                    (a) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Container(
                              width: 5,
                              height: 5,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onSurface.withOpacity(
                                  0.35,
                                ),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              a,
                              style: GoogleFonts.inter(
                                fontSize: isDesktop ? 12.5 : 12,
                                fontWeight: FontWeight.w400,
                                color: isDark
                                    ? const Color(0xFFa0aec0)
                                    : const Color(0xFF64748b),
                                height: 1.45,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ],
    );
  }

  // ── bento card helpers ───────────────────────────────────────────────────

  BoxDecoration _cardDeco(bool isDark) => BoxDecoration(
        color: isDark ? const Color(0xFF101a2c) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.06)
              : const Color(0xFFE6ECF5),
        ),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
      );

  /// Hero card — stretches to fill parent height, image covers background,
  /// project info as a gradient overlay pinned to the bottom.
  Widget _projectHeroCard(BuildContext context, Project p) {
    final bg = p.backgroundColor ?? const Color(0xFF1A1A2E);
    final url = p.playStoreUrl ?? p.driveUrl ?? p.githubUrl ?? p.liveUrl;

    Widget chip(String label) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: Colors.white,
            ),
          ),
        );

    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Container(
        color: bg,
        child: Stack(
          fit: StackFit.expand,
          children: [
            if (p.imageUrl != null)
              Image.asset(
                p.imageUrl!,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => const SizedBox(),
              ),
            // Gradient overlay for text legibility
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: const [0.45, 1.0],
                    colors: [
                      Colors.transparent,
                      Colors.black.withOpacity(0.80),
                    ],
                  ),
                ),
              ),
            ),
            // Text pinned to bottom
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      p.title,
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      p.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white.withOpacity(0.82),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: p.technologies.map(chip).toList(),
                    ),
                  ],
                ),
              ),
            ),
            // Link icon top-right
            if (url != null)
              Positioned(
                top: 14,
                right: 14,
                child: MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: () => _launchUrl(url),
                    child: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(Icons.open_in_new,
                          size: 15,
                          color: Colors.white.withOpacity(0.9)),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  /// Combined card — coloured image on top, title + description + tags below,
  /// all inside one rounded card container.
  Widget _projectCombinedCard(BuildContext context, Project p,
      {double imageHeight = 170}) {
    final bg = p.backgroundColor ?? const Color(0xFF4F46E5);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final url = p.driveUrl ?? p.githubUrl ?? p.playStoreUrl ?? p.liveUrl;

    Widget chip(String label) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: isDark
                  ? Colors.white.withOpacity(0.12)
                  : const Color(0xFFCBD5E1),
            ),
          ),
          child: Text(
            label.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.5,
              color: isDark
                  ? Colors.white.withOpacity(0.55)
                  : const Color(0xFF64748b),
            ),
          ),
        );

    return Container(
      decoration: _cardDeco(isDark),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: imageHeight,
            width: double.infinity,
            color: bg,
            child: p.imageUrl != null
                ? Image.asset(
                    p.imageUrl!,
                    fit: BoxFit.contain,
                    errorBuilder: (_, __, ___) => Center(
                          child: Icon(Icons.image_outlined,
                              size: 40, color: Colors.white.withOpacity(0.4)),
                        ))
                : Center(
                    child: Icon(Icons.code,
                        size: 40, color: Colors.white.withOpacity(0.4))),
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        p.title,
                        style: GoogleFonts.inter(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: theme.colorScheme.onSurface,
                          height: 1.2,
                        ),
                      ),
                    ),
                    if (url != null)
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: () => _launchUrl(url),
                          child: Icon(Icons.open_in_new,
                              size: 17,
                              color: theme.colorScheme.onSurface
                                  .withOpacity(0.35)),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  p.description,
                  style: GoogleFonts.inter(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                    color: isDark
                        ? const Color(0xFFa0aec0)
                        : const Color(0xFF64748b),
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: p.technologies.map(chip).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Small card — icon tile, title, description, category + arrow.
  Widget _projectMiniCard(BuildContext context, Project p) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bg = p.backgroundColor ?? const Color(0xFF4F46E5);
    final url = p.driveUrl ?? p.githubUrl ?? p.liveUrl ?? p.playStoreUrl;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardDeco(isDark),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: bg.withOpacity(isDark ? 0.28 : 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: p.imageUrl != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.asset(p.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) =>
                            Icon(Icons.code, size: 20, color: bg)),
                  )
                : Icon(Icons.code, size: 20, color: bg),
          ),
          const SizedBox(height: 14),
          Text(p.title,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: theme.colorScheme.onSurface,
              )),
          const SizedBox(height: 6),
          Text(p.description,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: isDark
                    ? const Color(0xFFa0aec0)
                    : const Color(0xFF64748b),
                height: 1.5,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis),
          const Spacer(),
          const SizedBox(height: 14),
          Row(children: [
            Text(p.category.displayName.toUpperCase(),
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 0.6,
                  color: theme.colorScheme.onSurface.withOpacity(0.4),
                )),
            const Spacer(),
            GestureDetector(
              onTap: url != null ? () => _launchUrl(url) : null,
              child: MouseRegion(
                cursor: url != null
                    ? SystemMouseCursors.click
                    : SystemMouseCursors.basic,
                child: Icon(Icons.arrow_forward,
                    size: 16,
                    color: theme.colorScheme.onSurface
                        .withOpacity(url != null ? 0.45 : 0.18)),
              ),
            ),
          ]),
        ],
      ),
    );
  }

  // ── projects section ──────────────────────────────────────────────────────

  Widget _buildProjectsSection(BuildContext context) {
    final projects = DummyProjects.projects;
    final maxWidth = _contentMaxWidth(context);
    final isDesktop = ResponsiveBreakpoints.isDesktopUp(context);
    final isTablet = ResponsiveBreakpoints.isTabletUp(context);
    const gap = 16.0;

    // Desktop bento (Luma Blocks is the hero):
    //  [Luma hero card TALL      ]  [UriBook combined (image+text)  ]
    //  [   (spans both rows)     ]  [Tournal combined  ] [PwdMgr mini]
    final luma = projects[3];
    final uriBook = projects[0];
    final tournal = projects[1];
    final pwdMgr = projects[2];

    Widget desktopBento() => IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left: Luma Blocks — tall hero with gradient text overlay
              Expanded(child: _projectHeroCard(context, luma)),
              const SizedBox(width: gap),
              // Right 2/3: 2-row grid
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Row 1: UriBook as a single combined card (image + text)
                    _projectCombinedCard(context, uriBook, imageHeight: 190),
                    const SizedBox(height: gap),
                    // Row 2: Tournal mini + PwdMgr mini
                    IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                              child: _projectMiniCard(context, tournal)),
                          const SizedBox(width: gap),
                          Expanded(
                              child: _projectMiniCard(context, pwdMgr)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );

    // Tablet (2-col): each project gets its own combined card
    Widget tabletGrid() => Column(
          children: [
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                      child: _projectCombinedCard(context, luma,
                          imageHeight: 160)),
                  const SizedBox(width: gap),
                  Expanded(
                      child: _projectCombinedCard(context, uriBook,
                          imageHeight: 160)),
                ],
              ),
            ),
            const SizedBox(height: gap),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(child: _projectMiniCard(context, tournal)),
                  const SizedBox(width: gap),
                  Expanded(child: _projectMiniCard(context, pwdMgr)),
                ],
              ),
            ),
          ],
        );

    // Mobile — stacked (Luma first), each as combined card
    Widget mobileList() => Column(
          children: [
            for (final p in [luma, uriBook]) ...[
              _projectCombinedCard(context, p, imageHeight: 180),
              const SizedBox(height: gap),
            ],
            for (final p in [tournal, pwdMgr]) ...[
              _projectMiniCard(context, p),
              if (p != pwdMgr) const SizedBox(height: gap),
            ],
          ],
        );

    return Container(
      width: double.infinity,
      padding: _sectionPadding(context, top: 26, bottom: 26),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionHeader(context,
                  icon: Icons.folder_outlined, title: 'Featured Projects'),
              const SizedBox(height: 16),
              if (isDesktop)
                desktopBento()
              else if (isTablet)
                tabletGrid()
              else
                mobileList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final maxWidth = _contentMaxWidth(context);

    return Container(
      width: double.infinity,
      padding: _sectionPadding(context, top: 26, bottom: 40),
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildGetInTouchCard(context),

              const SizedBox(height: 60),

              // Footer
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '© ${DateTime.now().year} All rights reserved.',
                      style: GoogleFonts.inter(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w500,
                        color: isDark
                            ? const Color(0xFF718096)
                            : const Color(0xFF94a3b8),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGetInTouchCard(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isDesktop = ResponsiveBreakpoints.isDesktopUp(context);

    final cardColor = isDark ? const Color(0xFF101a2c) : Colors.white;
    final cardBorder = isDark
        ? Colors.white.withOpacity(0.06)
        : const Color(0xFFE6ECF5);
    final primary = isDark ? const Color(0xFF1D4ED8) : const Color(0xFF1E3A8A);
    final subtitleColor = isDark
        ? const Color(0xFFa0aec0)
        : const Color(0xFF64748b);

    Widget sayHelloButton({required bool expanded}) {
      final child = ElevatedButton(
        onPressed: () => _launchUrl(
          'mailto:${ContactInfo.personal.email}?subject=Hello%20👋',
        ),
        style:
            ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: expanded ? 22 : 28,
                vertical: 18,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(999),
              ),
              elevation: 0,
              textStyle: GoogleFonts.inter(
                fontSize: 15.5,
                fontWeight: FontWeight.w700,
              ),
            ).copyWith(
              shadowColor: MaterialStatePropertyAll(
                isDark ? Colors.transparent : primary.withOpacity(0.35),
              ),
            ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Say Hello'),
            const SizedBox(width: 8),
            Text('👋', style: GoogleFonts.inter(fontSize: 16)),
          ],
        ),
      );

      if (!expanded) return SizedBox(height: 52, child: child);
      return SizedBox(width: double.infinity, height: 52, child: child);
    }

    Widget circleIconButton({
      required Widget icon,
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
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: isDark
                    ? Colors.white.withOpacity(0.06)
                    : const Color(0xFFF8FAFF),
                shape: BoxShape.circle,
                border: Border.all(color: cardBorder),
                boxShadow: isDark
                    ? null
                    : [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 14,
                          offset: const Offset(0, 8),
                        ),
                      ],
              ),
              child: Center(child: icon),
            ),
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 44 : 22,
        vertical: isDesktop ? 34 : 22,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: cardBorder),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 26,
                  offset: const Offset(0, 14),
                ),
              ],
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Get in Touch',
                        style: GoogleFonts.inter(
                          fontSize: 42,
                          fontWeight: FontWeight.w900,
                          color: theme.colorScheme.onSurface,
                          height: 1.05,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "Have a project in mind? Let's discuss how we\ncan build something amazing together.",
                        style: GoogleFonts.inter(
                          fontSize: 14.5,
                          fontWeight: FontWeight.w500,
                          color: subtitleColor,
                          height: 1.55,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          circleIconButton(
                            icon: Icon(
                              Icons.mail_outline,
                              size: 18,
                              color: theme.colorScheme.onSurface.withOpacity(
                                isDark ? 0.75 : 0.65,
                              ),
                            ),
                            tooltip: 'Email',
                            onTap: () => _launchUrl(
                              'mailto:${ContactInfo.personal.email}',
                            ),
                          ),
                          const SizedBox(width: 12),
                          if ((ContactInfo.personal.linkedinUrl ?? '')
                              .trim()
                              .isNotEmpty)
                            circleIconButton(
                              icon: Icon(
                                Icons.link,
                                size: 18,
                                color: theme.colorScheme.onSurface.withOpacity(
                                  isDark ? 0.75 : 0.65,
                                ),
                              ),
                              tooltip: 'LinkedIn',
                              onTap: () =>
                                  _launchUrl(ContactInfo.personal.linkedinUrl!),
                            ),
                          const SizedBox(width: 12),
                          if ((ContactInfo.personal.githubUrl ?? '')
                              .trim()
                              .isNotEmpty)
                            circleIconButton(
                              icon: Icon(
                                Icons.people,
                                size: 18,
                                color: theme.colorScheme.onSurface.withOpacity(
                                  isDark ? 0.75 : 0.65,
                                ),
                              ),
                              tooltip: 'GitHub',
                              onTap: () =>
                                  _launchUrl(ContactInfo.personal.githubUrl!),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 28),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: isDark
                        ? null
                        : [
                            BoxShadow(
                              color: primary.withOpacity(0.32),
                              blurRadius: 28,
                              offset: const Offset(0, 18),
                            ),
                          ],
                  ),
                  child: sayHelloButton(expanded: false),
                ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Get in Touch',
                  style: GoogleFonts.inter(
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    color: theme.colorScheme.onSurface,
                    height: 1.05,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Have a project in mind? Let's discuss how we can build something amazing together.",
                  style: GoogleFonts.inter(
                    fontSize: 14.5,
                    fontWeight: FontWeight.w500,
                    color: subtitleColor,
                    height: 1.55,
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    circleIconButton(
                      icon: Icon(
                        Icons.mail_outline,
                        size: 18,
                        color: theme.colorScheme.onSurface.withOpacity(
                          isDark ? 0.75 : 0.65,
                        ),
                      ),
                      tooltip: 'Email',
                      onTap: () =>
                          _launchUrl('mailto:${ContactInfo.personal.email}'),
                    ),
                    const SizedBox(width: 12),
                    if ((ContactInfo.personal.linkedinUrl ?? '')
                        .trim()
                        .isNotEmpty)
                      circleIconButton(
                        icon: Icon(
                          Icons.link,
                          size: 18,
                          color: theme.colorScheme.onSurface.withOpacity(
                            isDark ? 0.75 : 0.65,
                          ),
                        ),
                        tooltip: 'LinkedIn',
                        onTap: () =>
                            _launchUrl(ContactInfo.personal.linkedinUrl!),
                      ),
                    const SizedBox(width: 12),
                    if ((ContactInfo.personal.githubUrl ?? '')
                        .trim()
                        .isNotEmpty)
                      circleIconButton(
                        icon: Icon(
                          Icons.people,
                          size: 18,
                          color: theme.colorScheme.onSurface.withOpacity(
                            isDark ? 0.75 : 0.65,
                          ),
                        ),
                        tooltip: 'GitHub',
                        onTap: () =>
                            _launchUrl(ContactInfo.personal.githubUrl!),
                      ),
                  ],
                ),
                const SizedBox(height: 18),
                DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    boxShadow: isDark
                        ? null
                        : [
                            BoxShadow(
                              color: primary.withOpacity(0.32),
                              blurRadius: 28,
                              offset: const Offset(0, 18),
                            ),
                          ],
                  ),
                  child: sayHelloButton(expanded: true),
                ),
              ],
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
        backgroundColor: const Color(0xFF1d4ed8),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        textStyle: GoogleFonts.inter(fontSize: 15, fontWeight: FontWeight.w600),
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
