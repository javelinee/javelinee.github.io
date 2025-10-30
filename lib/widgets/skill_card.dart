import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/skill.dart';

class SkillCard extends StatefulWidget {
  final Skill skill;
  final bool showProgressBar;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const SkillCard({
    super.key,
    required this.skill,
    this.showProgressBar = false,
    this.onTap,
    this.width = 250,
    this.height = 250,
  });

  @override
  State<SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _elevationAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 1.02,
    ).animate(CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));
    _elevationAnimation = Tween<double>(
      begin: 4,
      end: 12,
    ).animate(CurvedAnimation(parent: _hoverController, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _hoverController.forward();
    } else {
      _hoverController.reverse();
    }
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
          animation: _hoverController,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: widget.width,
                height: widget.height,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: _isHovered
                      ? LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colorScheme.surface,
                            widget.skill.category.color.withOpacity(0.05),
                          ],
                        )
                      : null,
                  color: _isHovered ? null : colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: _isHovered
                        ? widget.skill.category.color.withOpacity(0.3)
                        : colorScheme.outline.withOpacity(0.2),
                    width: _isHovered ? 1.5 : 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: widget.skill.category.color.withOpacity(
                        _isHovered ? 0.15 : 0.05,
                      ),
                      blurRadius: _elevationAnimation.value,
                      offset: Offset(0, _elevationAnimation.value / 2),
                      spreadRadius: _isHovered ? 1 : 0,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Row: Icon and Featured Star
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                widget.skill.category.color.withOpacity(0.15),
                                widget.skill.category.color.withOpacity(0.05),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: widget.skill.category.color.withOpacity(
                                0.2,
                              ),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: widget.skill.category.color.withOpacity(
                                  0.1,
                                ),
                                blurRadius: 6,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Icon(
                            widget.skill.icon,
                            size: 20,
                            color: widget.skill.category.color,
                          ),
                        ),
                        const Spacer(),
                        if (widget.skill.isFeatured)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.amber.shade300,
                                  Colors.amber.shade600,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.amber.withOpacity(0.3),
                                  blurRadius: 3,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.star,
                              size: 12,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    // Skill Name
                    Text(
                      widget.skill.name,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                        height: 1.2,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 6),

                    // Category Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: widget.skill.category.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.skill.category.displayName,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          color: widget.skill.category.color,
                        ),
                      ),
                    ),

                    const SizedBox(height: 8),

                    // Skill Level Badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            widget.skill.level.color.withOpacity(0.2),
                            widget.skill.level.color.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: widget.skill.level.color.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Text(
                        widget.skill.level.displayName,
                        style: GoogleFonts.poppins(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: widget.skill.level.color,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Experience Section
                    if (widget.showProgressBar) ...[
                      // Progress Bar Version
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Experience',
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: colorScheme.onSurface.withOpacity(0.8),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: widget.skill.level.color.withOpacity(
                                    0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${widget.skill.yearsOfExperience}yr${widget.skill.yearsOfExperience != 1 ? 's' : ''}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 9,
                                    fontWeight: FontWeight.w700,
                                    color: widget.skill.level.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          TweenAnimationBuilder<double>(
                            duration: Duration(
                              milliseconds:
                                  800 + (widget.skill.id.hashCode % 400),
                            ),
                            tween: Tween(
                              begin: 0.0,
                              end: widget.skill.level.progressValue,
                            ),
                            builder: (context, value, child) {
                              return Container(
                                height: 4,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  color: colorScheme.outline.withOpacity(0.2),
                                ),
                                child: FractionallySizedBox(
                                  alignment: Alignment.centerLeft,
                                  widthFactor: value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(2),
                                      gradient: LinearGradient(
                                        colors: [
                                          widget.skill.level.color,
                                          widget.skill.level.color.withOpacity(
                                            0.8,
                                          ),
                                        ],
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: widget.skill.level.color
                                              .withOpacity(0.3),
                                          blurRadius: 2,
                                          offset: const Offset(0, 1),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ] else ...[
                      // Simple Experience Display
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: colorScheme.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Icon(
                              Icons.schedule_outlined,
                              size: 12,
                              color: colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '${widget.skill.yearsOfExperience} year${widget.skill.yearsOfExperience != 1 ? 's' : ''}',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: colorScheme.onSurface.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
