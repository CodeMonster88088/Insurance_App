// screens/vaccination_info_page.dart
import 'package:flutter/material.dart';

class VaccinationFAQs extends StatelessWidget {
  final List<Map<String, String>> faqs = [
    {
      'question': 'What are the common side effects of vaccines?',
      'answer': 'Common side effects include soreness at the injection site, mild fever, and fatigue.',
    },
    {
      'question': 'How often should I get vaccinated?',
      'answer': 'It depends on the vaccine. Some require annual doses, while others provide long-term protection.',
    },
    {
      'question': 'Are vaccines safe for children?',
      'answer': 'Yes, vaccines are rigorously tested and safe for children.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQs'),
      ),
      body: ListView.builder(
        itemCount: faqs.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(faqs[index]['question']!),
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(faqs[index]['answer']!),
              ),
            ],
          );
        },
      ),
    );
  }
}