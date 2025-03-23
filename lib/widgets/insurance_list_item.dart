import 'package:flutter/material.dart';
import 'package:flutter_app_test/screens/activate_policy_screen.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import '../models/insurance_model.dart';

class InsuranceListItem extends StatelessWidget {
  final InsuranceModel insurance;

  const InsuranceListItem({required this.insurance, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ActivatePolicyScreen(insurance: insurance),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Provider Name (Title)
              Text(
                insurance.provider,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(thickness: 1, height: 12),

              // Row of Details (Duration, Region, Travelers)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildDetail(LucideIcons.calendarDays, '${insurance.duration} days'),
                  _buildDetail(LucideIcons.map, insurance.region),
                  _buildDetail(LucideIcons.users, '${insurance.numberOfTravelers}'),
                ],
              ),

              const SizedBox(height: 10),

              // Price Section (Highlighted)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Price:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  Text(
                    '${insurance.price.toStringAsFixed(2)} BHD',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create a row with an icon and text
  Widget _buildDetail(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.blueGrey),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
