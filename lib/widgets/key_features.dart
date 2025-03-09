import 'package:flutter/material.dart';

class KeyFeaturesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SlideInWidget(
          beginOffset: Offset(-1, 0), // Slide from left
          child: FeatureTile(
            icon: Icons.security,
            title: "Secure & Reliable",
            description: "Our platform ensures top security and reliability.",
          ),
        ),
        SizedBox(height: 20),
        SlideInWidget(
          beginOffset: Offset(1, 0), // Slide from right
          child: FeatureTile(
            icon: Icons.speed,
            title: "Fast Performance",
            description: "Optimized for high-speed interactions.",
          ),
        ),
        SizedBox(height: 20),
        SlideInWidget(
          beginOffset: Offset(0, 1), // Slide from bottom
          child: FeatureTile(
            icon: Icons.design_services,
            title: "Modern Design",
            description: "Aesthetic and user-friendly design.",
          ),
        ),
      ],
    );
  }
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  FeatureTile({required this.icon, required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 40, color: Colors.blue),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(description, style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }
}

// SlideInWidget Implementation
class SlideInWidget extends StatefulWidget {
  final Widget child;
  final Offset beginOffset;
  final Duration duration;

  SlideInWidget({
    required this.child,
    required this.beginOffset,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  _SlideInWidgetState createState() => _SlideInWidgetState();
}

class _SlideInWidgetState extends State<SlideInWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<Offset>(
      begin: widget.beginOffset,
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
