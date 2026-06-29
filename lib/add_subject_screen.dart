import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'subject.dart';
import 'subject_provider.dart';

class AddSubjectScreen extends StatefulWidget {
  const AddSubjectScreen({super.key});

  @override
  State<AddSubjectScreen> createState() => _AddSubjectScreenState();
}

class _AddSubjectScreenState extends State<AddSubjectScreen> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _markController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _markController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      final mark = double.parse(_markController.text.trim());

      Provider.of<SubjectProvider>(context, listen: false)
          .addSubject(Subject(name: name, mark: mark));

      _nameController.clear();
      _markController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Subject Added Successfully!'), backgroundColor: Color(0xFF6E4BFF)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _animation,
      child: ScaleTransition(
        scale: _animation,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                Icon(Icons.school_rounded, size: 80, color: theme.primaryColor.withOpacity(0.8)),
                const SizedBox(height: 10),
                Text("Add New Subject",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: theme.textTheme.bodyMedium?.color)),

                const SizedBox(height: 40),

                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: theme.cardColor.withOpacity(theme.brightness == Brightness.dark ? 0.6 : 0.85),
                    borderRadius: BorderRadius.circular(28),
                    border: Border.all(color: Colors.white.withOpacity(0.15)),
                    boxShadow: [
                      BoxShadow(
                        color: theme.primaryColor.withOpacity(0.15),
                        blurRadius: 25,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                            labelText: 'Subject Name',
                            prefixIcon: const Icon(Icons.book),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          validator: (v) => v?.trim().isEmpty ?? true ? 'Subject name required' : null,
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _markController,
                          decoration: InputDecoration(
                            labelText: 'Mark (0-100)',
                            prefixIcon: const Icon(Icons.grade),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          keyboardType: TextInputType.number,
                          validator: (v) {
                            final m = double.tryParse(v ?? '');
                            return (m == null || m < 0 || m > 100) ? 'Mark must be 0-100' : null;
                          },
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.primaryColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      elevation: 8,
                    ),
                    child: const Text("Add Subject", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}