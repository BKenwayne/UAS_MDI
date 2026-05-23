import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final String badgeName;
  final bool isUnlocked;
  final double size;

  const BadgeWidget({
    super.key,
    required this.badgeName,
    required this.isUnlocked,
    this.size = 80,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Choose icon & color based on badge type
    IconData iconData = Icons.emoji_events_rounded;
    Color badgeColor = Colors.amber;

    if (badgeName.contains('Mamalia')) {
      iconData = Icons.pets_rounded;
      badgeColor = Colors.orange;
    } else if (badgeName.contains('Burung')) {
      iconData = Icons.flutter_dash_rounded;
      badgeColor = Colors.blue;
    } else if (badgeName.contains('Reptil')) {
      iconData = Icons.coronavirus_rounded; // reptile-like scales icon representation
      badgeColor = Colors.teal;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isUnlocked
                ? badgeColor.withValues(alpha: 0.15)
                : theme.colorScheme.surfaceContainerHighest,
            border: Border.all(
              color: isUnlocked ? badgeColor : theme.colorScheme.outline.withValues(alpha: 0.3),
              width: 3,
            ),
            boxShadow: isUnlocked
                ? [
                    BoxShadow(
                      color: badgeColor.withValues(alpha: 0.2),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]
                : null,
          ),
          child: Center(
            child: Icon(
              isUnlocked ? iconData : Icons.lock_outline_rounded,
              size: size * 0.45,
              color: isUnlocked ? badgeColor : theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          badgeName,
          style: theme.textTheme.labelMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isUnlocked
                ? theme.colorScheme.onSurface
                : theme.colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          isUnlocked ? 'Tercapai' : 'Terkunci',
          style: theme.textTheme.labelSmall?.copyWith(
            color: isUnlocked
                ? Colors.green.shade700
                : theme.colorScheme.onSurface.withValues(alpha: 0.35),
            fontSize: 9,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
