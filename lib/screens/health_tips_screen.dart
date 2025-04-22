import 'package:flutter/material.dart';

class HealthTipsScreen extends StatelessWidget {
  const HealthTipsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health Tips'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildHeader(context),
          const SizedBox(height: 24),
          _buildCategorySection(context, 'Nutrition'),
          const SizedBox(height: 16),
          _buildCategorySection(context, 'Exercise'),
          const SizedBox(height: 16),
          _buildCategorySection(context, 'Mental Health'),
          const SizedBox(height: 16),
          _buildCategorySection(context, 'Preventive Care'),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Health & Wellness',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          'Expert advice to help you stay healthy',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildCategorySection(BuildContext context, String category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 180,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildHealthTipCard(
                context,
                title: category == 'Nutrition' ? 'Balanced Diet' : 
                      category == 'Exercise' ? 'Daily Workout' :
                      category == 'Mental Health' ? 'Stress Relief' : 'Annual Checkups',
                image: category == 'Nutrition' ? 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80' : 
                      category == 'Exercise' ? 'https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80' :
                      category == 'Mental Health' ? 'https://images.unsplash.com/photo-1494412651409-8963ce7935a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80' : 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
              ),
              const SizedBox(width: 12),
              _buildHealthTipCard(
                context,
                title: category == 'Nutrition' ? 'Hydration Tips' : 
                      category == 'Exercise' ? 'Cardio Benefits' :
                      category == 'Mental Health' ? 'Mindfulness' : 'Vaccinations',
                image: category == 'Nutrition' ? 'https://images.unsplash.com/photo-1550583724-b2692b85b150?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80' : 
                      category == 'Exercise' ? 'https://images.unsplash.com/photo-1538805060514-97d9cc17730c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80' :
                      category == 'Mental Health' ? 'https://images.unsplash.com/photo-1494412651409-8963ce7935a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80' : 'https://images.unsplash.com/photo-1588776814546-1ffcf47267a5?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
              ),
              const SizedBox(width: 12),
              _buildHealthTipCard(
                context,
                title: category == 'Nutrition' ? 'Superfoods' : 
                      category == 'Exercise' ? 'Strength Training' :
                      category == 'Mental Health' ? 'Sleep Quality' : 'Screenings',
                image: category == 'Nutrition' ? 'https://images.unsplash.com/photo-1490645935967-10de6ba17061?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80' : 
                      category == 'Exercise' ? 'https://images.unsplash.com/photo-1538805060514-97d9cc17730c?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80' :
                      category == 'Mental Health' ? 'https://images.unsplash.com/photo-1494412651409-8963ce7935a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80' : 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHealthTipCard(BuildContext context, {required String title, required String image}) {
    return GestureDetector(
      onTap: () => _showTipDetails(context, title),
      child: Container(
        width: 280,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
            image: NetworkImage(image),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black.withOpacity(0.7),
                Colors.transparent,
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.timer, color: Colors.white70, size: 14),
                    SizedBox(width: 4),
                    Text(
                      '5 min read',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showTipDetails(BuildContext context, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    'https://images.unsplash.com/photo-1494412651409-8963ce7935a7?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Icon(Icons.person, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      'By Dr. Sarah Johnson',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                    SizedBox(width: 4),
                    Text(
                      'Oct 15, 2023',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  style: TextStyle(
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                  style: TextStyle(
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Key Takeaways:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                _buildBulletPoint('Lorem ipsum dolor sit amet'),
                _buildBulletPoint('Consectetur adipiscing elit'),
                _buildBulletPoint('Sed do eiusmod tempor incididunt'),
                _buildBulletPoint('Ut labore et dolore magna aliqua'),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('Save to Favorites'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 4.0, right: 8.0),
            child: Icon(Icons.circle, size: 8),
          ),
          Expanded(
            child: Text(text),
          ),
        ],
      ),
    );
  }
}