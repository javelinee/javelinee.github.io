import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../pages/home_page.dart';
import '../pages/projects_page.dart';
import '../pages/skills_page.dart';
import '../pages/contact_page.dart';
import '../providers/theme_provider.dart';

class ModernNavigation extends StatefulWidget {
  const ModernNavigation({super.key});

  @override
  State<ModernNavigation> createState() => _ModernNavigationState();
}

class _ModernNavigationState extends State<ModernNavigation> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isWeb = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      body: Column(
        children: [
          // Enhanced Modern Top Navigation Bar
          Container(
            height: 84,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  colorScheme.surface,
                  colorScheme.surface.withOpacity(0.95),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: colorScheme.outline.withOpacity(0.1),
                  width: 1,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.shadow.withOpacity(0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: colorScheme.primary.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                  spreadRadius: -2,
                ),
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isWeb ? 48 : 24),
                child: Row(
                  children: [
                    // Enhanced Logo/Brand
                    Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                colorScheme.primary,
                                colorScheme.secondary,
                                colorScheme.tertiary,
                              ],
                              stops: const [0.0, 0.6, 1.0],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: colorScheme.primary.withOpacity(0.25),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.flutter_dash_rounded,
                            color: colorScheme.onPrimary,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 16),
                        if (isWeb) ...[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Jesselyn',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                      color: colorScheme.onSurface,
                                      height: 1.0,
                                    ),
                                  ),
                                  Text(
                                    ' Hartandi',
                                    style: GoogleFonts.poppins(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: colorScheme.primary,
                                      height: 1.0,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                'Flutter Developer',
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: colorScheme.onSurface.withOpacity(0.6),
                                  height: 1.0,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),

                    const Spacer(),

                    // Navigation Items
                    if (isWeb) ...[
                      // Web Navigation
                      Row(
                        children: [
                          _buildNavItem(
                            context,
                            'Home',
                            0,
                            Icons.home_outlined,
                            Icons.home,
                          ),
                          const SizedBox(width: 32),
                          _buildNavItem(
                            context,
                            'Skills',
                            1,
                            Icons.code_outlined,
                            Icons.code,
                          ),
                          const SizedBox(width: 32),
                          _buildNavItem(
                            context,
                            'Projects',
                            2,
                            Icons.work_outline,
                            Icons.work,
                          ),
                          const SizedBox(width: 32),
                          _buildNavItem(
                            context,
                            'Contact',
                            3,
                            Icons.contact_mail_outlined,
                            Icons.contact_mail,
                          ),
                          const SizedBox(width: 24),
                          _buildThemeToggle(context),
                        ],
                      ),
                    ] else ...[
                      // Mobile Navigation
                      Row(
                        children: [
                          _buildThemeToggle(context),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () => _showMobileMenu(context),
                            icon: Icon(
                              Icons.menu,
                              color: colorScheme.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          // Page Content
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              children: [
                HomePage(
                  onNavigateToProjects: () => _navigateToPage(2),
                  onNavigateToContact: () => _navigateToPage(3),
                ),
                const SkillsPage(),
                const ProjectsPage(),
                const ContactPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    int index,
    IconData icon,
    IconData selectedIcon,
  ) {
    final isSelected = _currentIndex == index;

    return _EnhancedNavItem(
      label: label,
      icon: icon,
      selectedIcon: selectedIcon,
      isSelected: isSelected,
      onTap: () => _navigateToPage(index),
    );
  }

  void _showMobileMenu(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: colorScheme.outline.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),

            // Menu Items
            _buildMobileMenuItem(context, 'Home', Icons.home, 0),
            _buildMobileMenuItem(context, 'Skills', Icons.code, 1),
            _buildMobileMenuItem(context, 'Projects', Icons.work, 2),
            _buildMobileMenuItem(context, 'Contact', Icons.contact_mail, 3),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(
    BuildContext context,
    String label,
    IconData icon,
    int index,
  ) {
    final colorScheme = Theme.of(context).colorScheme;
    final isSelected = _currentIndex == index;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? colorScheme.primary : colorScheme.onSurface,
      ),
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          color: isSelected ? colorScheme.primary : colorScheme.onSurface,
        ),
      ),
      onTap: () {
        Navigator.pop(context);
        _navigateToPage(index);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: isSelected ? colorScheme.primary.withOpacity(0.1) : null,
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.3),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Light Mode Button
              GestureDetector(
                onTap: () => themeProvider.setTheme(false),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: !themeProvider.isDarkMode
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    borderRadius: const BorderRadius.horizontal(
                      left: Radius.circular(18),
                    ),
                  ),
                  child: Icon(
                    Icons.light_mode,
                    size: 18,
                    color: !themeProvider.isDarkMode
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
              // Dark Mode Button
              GestureDetector(
                onTap: () => themeProvider.setTheme(true),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(18),
                    ),
                  ),
                  child: Icon(
                    Icons.dark_mode,
                    size: 18,
                    color: themeProvider.isDarkMode
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(
                            context,
                          ).colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _EnhancedNavItem extends StatefulWidget {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final bool isSelected;
  final VoidCallback onTap;

  const _EnhancedNavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<_EnhancedNavItem> createState() => _EnhancedNavItemState();
}

class _EnhancedNavItemState extends State<_EnhancedNavItem>
    with SingleTickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

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

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return MouseRegion(
      onEnter: (_) => _onHover(true),
      onExit: (_) => _onHover(false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  gradient: widget.isSelected
                      ? LinearGradient(
                          colors: [
                            colorScheme.primary.withOpacity(0.15),
                            colorScheme.secondary.withOpacity(0.08),
                          ],
                        )
                      : _isHovered
                      ? LinearGradient(
                          colors: [
                            colorScheme.primary.withOpacity(0.08),
                            colorScheme.secondary.withOpacity(0.04),
                          ],
                        )
                      : null,
                  borderRadius: BorderRadius.circular(16),
                  border: widget.isSelected
                      ? Border.all(
                          color: colorScheme.primary.withOpacity(0.3),
                          width: 1,
                        )
                      : _isHovered
                      ? Border.all(
                          color: colorScheme.primary.withOpacity(0.2),
                          width: 1,
                        )
                      : null,
                  boxShadow: widget.isSelected
                      ? [
                          BoxShadow(
                            color: colorScheme.primary.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : _isHovered
                      ? [
                          BoxShadow(
                            color: colorScheme.primary.withOpacity(0.1),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      widget.isSelected ? widget.selectedIcon : widget.icon,
                      size: 20,
                      color: widget.isSelected
                          ? colorScheme.primary
                          : _isHovered
                          ? colorScheme.primary.withOpacity(0.8)
                          : colorScheme.onSurface.withOpacity(0.7),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      widget.label,
                      style: GoogleFonts.poppins(
                        fontSize: 15,
                        fontWeight: widget.isSelected
                            ? FontWeight.w600
                            : _isHovered
                            ? FontWeight.w500
                            : FontWeight.w400,
                        color: widget.isSelected
                            ? colorScheme.primary
                            : _isHovered
                            ? colorScheme.primary.withOpacity(0.8)
                            : colorScheme.onSurface.withOpacity(0.7),
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
    if (isHovered) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }
}
