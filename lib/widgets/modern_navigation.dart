import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../pages/single_page_portfolio.dart';
import '../providers/theme_provider.dart';

class ModernNavigation extends StatefulWidget {
  const ModernNavigation({super.key});

  @override
  State<ModernNavigation> createState() => _ModernNavigationState();
}

class _ModernNavigationState extends State<ModernNavigation> {
  int _currentIndex = 0;
  final GlobalKey<SinglePagePortfolioState> _portfolioKey = GlobalKey();

  void _navigateToSection(int index) {
    setState(() {
      _currentIndex = index;
    });

    final portfolioState = _portfolioKey.currentState;
    if (portfolioState != null) {
      switch (index) {
        case 0:
          portfolioState.scrollToExperience();
          break;
        case 1:
          portfolioState.scrollToProjects();
          break;
        case 2:
          portfolioState.scrollToContact();
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final isWeb = MediaQuery.of(context).size.width > 768;

    return Scaffold(
      body: Column(
        children: [
          // Enhanced Modern Top Navigation Bar
          Container(
            height: 70,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF0d1b2a) : const Color(0xFFFFFFFF),
              border: Border(
                bottom: BorderSide(
                  color: isDark
                      ? Colors.white.withOpacity(0.05)
                      : const Color(0xFFe2e8f0),
                  width: 1,
                ),
              ),
              boxShadow: isDark
                  ? null
                  : [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: isWeb ? 48 : 24),
                child: Row(
                  children: [
                    // Logo on the left
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          'favicon.png',
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.high,
                        ),
                      ),
                    ),
                    
                    const Spacer(),
                    
                    // Navigation Items
                    if (isWeb) ...[
                      // Web Navigation
                      Row(
                        children: [
                          _buildNavItem(context, 'Experience', 0),
                          const SizedBox(width: 32),
                          _buildNavItem(context, 'Projects', 1),
                          const SizedBox(width: 32),
                          _buildNavItem(context, 'Contact', 2),
                        ],
                      ),
                      const Spacer(),
                      _buildThemeToggle(context),
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
          Expanded(child: SinglePagePortfolio(key: _portfolioKey)),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    String label,
    int index,
  ) {
    final isSelected = _currentIndex == index;

    return _EnhancedNavItem(
      label: label,
      icon: Icons.circle,
      selectedIcon: Icons.circle,
      isSelected: isSelected,
      onTap: () => _navigateToSection(index),
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
            _buildMobileMenuItem(context, 'Experience', Icons.work, 0),
            _buildMobileMenuItem(context, 'Projects', Icons.folder, 1),
            _buildMobileMenuItem(context, 'Contact', Icons.contact_mail, 2),

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
        _navigateToSection(index);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      tileColor: isSelected ? colorScheme.primary.withOpacity(0.1) : null,
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return IconButton(
          onPressed: () => themeProvider.toggleTheme(),
          icon: Icon(
            themeProvider.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            size: 22,
          ),
          tooltip: themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
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
                  color: widget.isSelected
                      ? colorScheme.primary.withOpacity(0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  widget.label,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: widget.isSelected
                        ? FontWeight.w600
                        : _isHovered
                        ? FontWeight.w500
                        : FontWeight.w400,
                    color: widget.isSelected
                        ? colorScheme.primary
                        : _isHovered
                        ? colorScheme.onSurface.withOpacity(0.9)
                        : colorScheme.onSurface.withOpacity(0.7),
                  ),
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

