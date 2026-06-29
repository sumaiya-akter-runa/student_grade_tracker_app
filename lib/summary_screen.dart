import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'subject_provider.dart';

class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubjectProvider>(context);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [theme.primaryColor.withOpacity(0.9), const Color(0xFF8B6EFF)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(32),
              boxShadow: [
                BoxShadow(color: theme.primaryColor.withOpacity(0.4), blurRadius: 30, spreadRadius: 8),
              ],
            ),
            child: Column(
              children: [
                const Icon(Icons.emoji_events_rounded, size: 60, color: Colors.white),
                const SizedBox(height: 12),
                const Text("Overall Performance",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              ],
            ),
          ),

          const SizedBox(height: 24),

          _buildGlassInfoCard("Total Subjects", provider.subjects.length.toString(), theme, icon: Icons.numbers),
          _buildGlassInfoCard("Average Mark", provider.averageMark.toStringAsFixed(2), theme, icon: Icons.analytics),
          _buildGlassInfoCard("Overall Grade", provider.overallGrade, theme, icon: Icons.grade, isGrade: true),
          _buildGlassInfoCard("Passing Subjects", "${provider.passingSubjects}/${provider.subjects.length}", theme, icon: Icons.check_circle),
        ],
      ),
    );
  }

  Widget _buildGlassInfoCard(String title, String value, ThemeData theme, {required IconData icon, bool isGrade = false}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor.withOpacity(0.75),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 15)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: theme.primaryColor.withOpacity(0.15),
            child: Icon(icon, color: theme.primaryColor, size: 32),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontSize: 16, color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8))),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: isGrade ? 42 : 28,
                    fontWeight: FontWeight.bold,
                    color: isGrade ? _getGradeColor(value) : theme.textTheme.bodyMedium?.color,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A': return const Color(0xFF00C853);
      case 'B': return const Color(0xFF2196F3);
      case 'C': return const Color(0xFFFF9800);
      default: return const Color(0xFFF44336);
    }
  }
}