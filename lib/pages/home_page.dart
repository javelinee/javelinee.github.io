import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/skills_section.dart';
import '../models/contact_info.dart';
import 'skills_page.dart';

class HomePage extends StatefulWidget {
  final VoidCallback? onNavigateToProjects;
  final VoidCallback? onNavigateToContact;

  const HomePage({
    super.key,
    this.onNavigateToProjects,
    this.onNavigateToContact,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _pulseController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _slideController, curve: Curves.easeOut));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _pulseController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Enhanced Hero Section
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.primary.withOpacity(0.08),
                    colorScheme.secondary.withOpacity(0.05),
                    colorScheme.tertiary.withOpacity(0.03),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24.0,
                    vertical: 40.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Enhanced Profile Image with Animation
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (context, child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: Container(
                                width: 160,
                                height: 160,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      colorScheme.primary,
                                      colorScheme.secondary,
                                      colorScheme.tertiary,
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: colorScheme.primary.withOpacity(
                                        0.3,
                                      ),
                                      blurRadius: 30,
                                      offset: const Offset(0, 15),
                                      spreadRadius: 5,
                                    ),
                                    BoxShadow(
                                      color: colorScheme.secondary.withOpacity(
                                        0.2,
                                      ),
                                      blurRadius: 20,
                                      offset: const Offset(0, 5),
                                    ),
                                  ],
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(4),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: colorScheme.surface,
                                  ),
                                  child: Icon(
                                    Icons.code_rounded,
                                    size: 70,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 40),

                      // Enhanced Name with Gradient Text
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [
                                colorScheme.primary,
                                colorScheme.secondary,
                                colorScheme.tertiary,
                              ],
                            ).createShader(bounds),
                            child: Text(
                              ContactInfo.personal.name,
                              style: GoogleFonts.poppins(
                                fontSize: 42,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 1.1,
                                letterSpacing: -0.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Enhanced Title Badge
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 12,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  colorScheme.primary.withOpacity(0.15),
                                  colorScheme.secondary.withOpacity(0.10),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(
                                color: colorScheme.primary.withOpacity(0.3),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.primary.withOpacity(0.1),
                                  blurRadius: 10,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.flutter_dash,
                                  color: colorScheme.primary,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  ContactInfo.personal.title,
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Enhanced Location
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: colorScheme.surface,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: colorScheme.outline.withOpacity(0.2),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: colorScheme.shadow.withOpacity(0.05),
                                  blurRadius: 10,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.location_on_rounded,
                                  color: colorScheme.primary,
                                  size: 16,
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  ContactInfo.personal.location ?? '',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: colorScheme.onSurface.withOpacity(
                                      0.8,
                                    ),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Enhanced Description
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 400),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              'Crafting exceptional mobile experiences with Flutter and building scalable full-stack solutions for the digital world.',
                              style: GoogleFonts.poppins(
                                fontSize: 17,
                                color: colorScheme.onSurface.withOpacity(0.8),
                                height: 1.6,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 48),

                      // Enhanced Action Buttons
                      SlideTransition(
                        position: _slideAnimation,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: MediaQuery.of(context).size.width < 400
                                ? Column(
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        child: _EnhancedButton(
                                          onPressed:
                                              widget.onNavigateToProjects,
                                          icon: Icons.work_outline_rounded,
                                          label: 'View Projects',
                                          isPrimary: true,
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      SizedBox(
                                        width: double.infinity,
                                        child: _EnhancedButton(
                                          onPressed: widget.onNavigateToContact,
                                          icon: Icons.message_outlined,
                                          label: 'Contact Me',
                                          isPrimary: false,
                                        ),
                                      ),
                                    ],
                                  )
                                : Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Flexible(
                                        child: _EnhancedButton(
                                          onPressed:
                                              widget.onNavigateToProjects,
                                          icon: Icons.work_outline_rounded,
                                          label: 'View Projects',
                                          isPrimary: true,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Flexible(
                                        child: _EnhancedButton(
                                          onPressed: widget.onNavigateToContact,
                                          icon: Icons.message_outlined,
                                          label: 'Contact Me',
                                          isPrimary: false,
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Enhanced About Me Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(32),
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    colorScheme.surface,
                    colorScheme.primaryContainer.withOpacity(0.08),
                    colorScheme.secondaryContainer.withOpacity(0.05),
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: colorScheme.outline.withOpacity(0.15),
                  width: 1,
                ),
                boxShadow: [
                  BoxShadow(
                    color: colorScheme.shadow.withOpacity(0.08),
                    blurRadius: 32,
                    offset: const Offset(0, 16),
                    spreadRadius: 0,
                  ),
                  BoxShadow(
                    color: colorScheme.primary.withOpacity(0.05),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                    spreadRadius: -4,
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
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              colorScheme.primary.withOpacity(0.15),
                              colorScheme.secondary.withOpacity(0.10),
                              colorScheme.tertiary.withOpacity(0.05),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: colorScheme.primary.withOpacity(0.2),
                            width: 1,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: colorScheme.primary.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person_outline_rounded,
                          color: colorScheme.primary,
                          size: 28,
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'About Me',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: colorScheme.onSurface,
                                height: 1.2,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              height: 3,
                              width: 60,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    colorScheme.primary,
                                    colorScheme.secondary,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    ContactInfo.personal.bio,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: colorScheme.onSurface.withOpacity(0.8),
                      height: 1.6,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 16),
                  if (ContactInfo.personal.location != null) ...[
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 18,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          ContactInfo.personal.location!,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: colorScheme.onSurface.withOpacity(0.7),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),

            // Skills Section
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width < 600 ? 16 : 24,
                vertical: 16,
              ),
              child: SkillsSection(
                showOnlyFeatured: true,
                maxSkillsToShow: 12,
                onViewAllPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const SkillsPage()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnhancedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  final String label;
  final bool isPrimary;

  const _EnhancedButton({
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.isPrimary,
  });

  @override
  State<_EnhancedButton> createState() => _EnhancedButtonState();
}

class _EnhancedButtonState extends State<_EnhancedButton>
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
      end: 0.98,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) => _controller.reverse(),
        onTapCancel: () => _controller.reverse(),
        onTap: widget.onPressed,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  gradient: widget.isPrimary
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colorScheme.primary,
                            colorScheme.secondary,
                            colorScheme.tertiary,
                          ],
                          stops: const [0.0, 0.6, 1.0],
                        )
                      : null,
                  color: widget.isPrimary ? null : colorScheme.surface,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: widget.isPrimary
                        ? Colors.transparent
                        : colorScheme.primary.withOpacity(0.5),
                    width: widget.isPrimary ? 0 : 2,
                  ),
                  boxShadow: [
                    if (widget.isPrimary) ...[
                      BoxShadow(
                        color: colorScheme.primary.withOpacity(0.4),
                        blurRadius: _isHovered ? 20 : 12,
                        offset: Offset(0, _isHovered ? 8 : 4),
                        spreadRadius: _isHovered ? 2 : 0,
                      ),
                    ] else ...[
                      BoxShadow(
                        color: colorScheme.shadow.withOpacity(0.1),
                        blurRadius: _isHovered ? 15 : 8,
                        offset: Offset(0, _isHovered ? 6 : 2),
                      ),
                    ],
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.icon,
                      color: widget.isPrimary
                          ? colorScheme.onPrimary
                          : colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      widget.label,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: widget.isPrimary
                            ? colorScheme.onPrimary
                            : colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
  }
}
