import 'package:flutter/material.dart';
import 'subject.dart';

class SubjectProvider extends ChangeNotifier {
  final List<Subject> _subjects = [];

  List<Subject> get subjects => _subjects;

  void addSubject(Subject subject) {
    _subjects.add(subject);
    notifyListeners();
  }

  void removeSubject(int index) {
    if (index >= 0 && index < _subjects.length) {
      _subjects.removeAt(index);
      notifyListeners();
    }
  }

  double get averageMark {
    if (_subjects.isEmpty) return 0.0;
    final sum = _subjects.fold(0.0, (sum, s) => sum + s.mark);
    return sum / _subjects.length;
  }

  String get overallGrade {
    final avg = averageMark;

    if (avg >= 80) {
      return 'A+';
    } else if (avg >= 70) {
      return 'A';
    } else if (avg >= 60) {
      return 'A-';
    } else if (avg >= 50) {
      return 'B';
    } else if (avg >= 40) {
      return 'C';
    } else if (avg >= 33) {
      return 'D';
    } else {
      return 'F';
    }
  }

  int get passingSubjects => _subjects.where((s) => s.mark >= 50).length;
}