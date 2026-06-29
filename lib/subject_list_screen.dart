import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'subject_provider.dart';

class SubjectListScreen extends StatelessWidget {
  const SubjectListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<SubjectProvider>(context);
    final subjects = provider.subjects;
    final theme = Theme.of(context);

    if (subjects.isEmpty) {
      return Center(
        child: Text(
          'No subjects yet\nTap + to add',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6)),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: subjects.length,
      itemBuilder: (context, index) {
        final subject = subjects[index];
        return AnimatedOpacity(
          duration: Duration(milliseconds: 400 + (index * 100)),
          opacity: 1.0,
          child: TweenAnimationBuilder(
            tween: Tween<double>(begin: 0, end: 1),
            duration: Duration(milliseconds: 500 + (index * 80)),
            builder: (context, value, child) {
              return Transform.translate(
                offset: Offset(0, 30 * (1 - value)),
                child: Opacity(opacity: value, child: child),
              );
            },
            child: Dismissible(
              key: Key(subject.name + index.toString()),
              background: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(16),
                ),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (_) => provider.removeSubject(index),
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 6),
                decoration: BoxDecoration(
                  color: theme.cardColor.withOpacity(0.85),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white.withOpacity(0.15)),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15)],
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  title: Text(subject.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  subtitle: Text('Mark: ${subject.mark.toStringAsFixed(1)}'),
                  trailing: Chip(
                    label: Text(subject.grade, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    backgroundColor: _getGradeColor(subject.grade),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color _getGradeColor(String grade) {
    switch (grade) {
      case 'A': return Colors.green;
      case 'B': return Colors.blue;
      case 'C': return Colors.orange;
      default: return Colors.red;
    }
  }
}