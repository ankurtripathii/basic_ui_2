import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Basic UI Part 2',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6C63FF),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: Color(0xFFEEEEEE)),
          ),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

// ── Data Model ───────────────────────────────────────────────

class Course {
  final String title;
  final String instructor;
  final String duration;
  final String level;
  final int lessons;
  final double rating;
  final Color color;
  final IconData icon;
  bool isBookmarked;

  Course({
    required this.title,
    required this.instructor,
    required this.duration,
    required this.level,
    required this.lessons,
    required this.rating,
    required this.color,
    required this.icon,
    this.isBookmarked = false,
  });
}

// ── Sample Data ──────────────────────────────────────────────

final List<Course> courses = [
  Course(
    title: 'Flutter Fundamentals',
    instructor: 'Alice Johnson',
    duration: '8h 30m',
    level: 'Beginner',
    lessons: 24,
    rating: 4.8,
    color: const Color(0xFF6C63FF),
    icon: Icons.flutter_dash,
  ),
  Course(
    title: 'Dart Advanced OOP',
    instructor: 'Bob Smith',
    duration: '6h 15m',
    level: 'Intermediate',
    lessons: 18,
    rating: 4.6,
    color: const Color(0xFF00BFA5),
    icon: Icons.code,
    isBookmarked: true,
  ),
  Course(
    title: 'Firebase Integration',
    instructor: 'Carol White',
    duration: '5h 45m',
    level: 'Intermediate',
    lessons: 16,
    rating: 4.7,
    color: const Color(0xFFFF6B6B),
    icon: Icons.local_fire_department,
  ),
  Course(
    title: 'State Management',
    instructor: 'David Lee',
    duration: '7h 00m',
    level: 'Advanced',
    lessons: 20,
    rating: 4.9,
    color: const Color(0xFFFFB347),
    icon: Icons.layers,
  ),
  Course(
    title: 'REST API & Networking',
    instructor: 'Eva Martinez',
    duration: '4h 30m',
    level: 'Intermediate',
    lessons: 14,
    rating: 4.5,
    color: const Color(0xFF4FC3F7),
    icon: Icons.cloud,
  ),
  Course(
    title: 'UI/UX Design in Flutter',
    instructor: 'Frank Chen',
    duration: '9h 00m',
    level: 'Beginner',
    lessons: 28,
    rating: 4.8,
    color: const Color(0xFFCE93D8),
    icon: Icons.palette,
  ),
];

// ── Home Screen ──────────────────────────────────────────────

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FF),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'My Courses',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => _showSnackBar(context, 'Search tapped'),
          ),
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => _showSnackBar(context, 'Notifications tapped'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          tabs: const [
            Tab(icon: Icon(Icons.view_list), text: 'List View'),
            Tab(icon: Icon(Icons.grid_view), text: 'Grid View'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _ListViewScreen(),
          _GridViewScreen(),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}

// ── ListView Screen ──────────────────────────────────────────

class _ListViewScreen extends StatefulWidget {
  @override
  State<_ListViewScreen> createState() => _ListViewScreenState();
}

class _ListViewScreenState extends State<_ListViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: const Color(0xFF6C63FF),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              _StatChip(label: '${courses.length} Courses', icon: Icons.school),
              const SizedBox(width: 8),
              _StatChip(
                label: '${courses.where((c) => c.isBookmarked).length} Saved',
                icon: Icons.bookmark,
              ),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'All Courses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _CourseListTile(
                  course: course,
                  onTap: () => _onCourseTap(context, course),
                  onBookmark: () => setState(() {
                    course.isBookmarked = !course.isBookmarked;
                  }),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onCourseTap(BuildContext context, Course course) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CourseDetailSheet(course: course),
    );
  }
}

// ── Course ListTile Card ─────────────────────────────────────

class _CourseListTile extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final VoidCallback onBookmark;

  const _CourseListTile({
    required this.course,
    required this.onTap,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          leading: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: course.color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(course.icon, color: course.color, size: 28),
          ),
          title: Text(
            course.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Color(0xFF1A1A2E),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 4),
              Text(course.instructor,
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 6),
              Row(
                children: [
                  _Tag(label: course.level, color: course.color),
                  const SizedBox(width: 6),
                  const Icon(Icons.access_time, size: 12, color: Colors.grey),
                  const SizedBox(width: 2),
                  Text(course.duration,
                      style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  const SizedBox(width: 6),
                  const Icon(Icons.star, size: 12, color: Color(0xFFFFB347)),
                  const SizedBox(width: 2),
                  Text('${course.rating}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFFFFB347),
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(
              course.isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
              color: course.isBookmarked ? const Color(0xFF6C63FF) : Colors.grey,
            ),
            onPressed: onBookmark,
          ),
          isThreeLine: true,
        ),
      ),
    );
  }
}

// ── GridView Screen ──────────────────────────────────────────

class _GridViewScreen extends StatefulWidget {
  @override
  State<_GridViewScreen> createState() => _GridViewScreenState();
}

class _GridViewScreenState extends State<_GridViewScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: const Color(0xFF6C63FF),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Row(
            children: [
              _StatChip(label: '${courses.length} Courses', icon: Icons.school),
              const SizedBox(width: 8),
              const _StatChip(label: 'Grid Layout', icon: Icons.grid_view),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Text(
            'Browse Courses',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1A1A2E),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.82,
            ),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return _CourseGridCard(
                course: course,
                onTap: () => _onCourseTap(context, course),
                onBookmark: () => setState(() {
                  course.isBookmarked = !course.isBookmarked;
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  void _onCourseTap(BuildContext context, Course course) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => _CourseDetailSheet(course: course),
    );
  }
}

// ── Course Grid Card ─────────────────────────────────────────

class _CourseGridCard extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  final VoidCallback onBookmark;

  const _CourseGridCard({
    required this.course,
    required this.onTap,
    required this.onBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: course.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(course.icon, color: course.color, size: 24),
                  ),
                  GestureDetector(
                    onTap: onBookmark,
                    child: Icon(
                      course.isBookmarked
                          ? Icons.bookmark
                          : Icons.bookmark_outline,
                      size: 20,
                      color: course.isBookmarked
                          ? const Color(0xFF6C63FF)
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                course.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1A1A2E),
                  height: 1.3,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                course.instructor,
                style: const TextStyle(fontSize: 11, color: Colors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              _Tag(label: course.level, color: course.color),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [
                    const Icon(Icons.play_circle_outline,
                        size: 13, color: Colors.grey),
                    const SizedBox(width: 3),
                    Text('${course.lessons} lessons',
                        style:
                            const TextStyle(fontSize: 10, color: Colors.grey)),
                  ]),
                  Row(children: [
                    const Icon(Icons.star, size: 13, color: Color(0xFFFFB347)),
                    const SizedBox(width: 2),
                    Text('${course.rating}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: Color(0xFFFFB347),
                          fontWeight: FontWeight.bold,
                        )),
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Detail Bottom Sheet ──────────────────────────────────────

class _CourseDetailSheet extends StatelessWidget {
  final Course course;
  const _CourseDetailSheet({required this.course});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.55,
      minChildSize: 0.4,
      maxChildSize: 0.85,
      builder: (_, controller) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: ListView(
          controller: controller,
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: course.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(course.icon, color: course.color, size: 32),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(course.title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A1A2E),
                          )),
                      const SizedBox(height: 4),
                      Text('by ${course.instructor}',
                          style: const TextStyle(
                              fontSize: 13, color: Colors.grey)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _DetailStat(
                    icon: Icons.access_time,
                    label: 'Duration',
                    value: course.duration,
                    color: course.color),
                _DetailStat(
                    icon: Icons.play_circle_outline,
                    label: 'Lessons',
                    value: '${course.lessons}',
                    color: course.color),
                _DetailStat(
                    icon: Icons.star,
                    label: 'Rating',
                    value: '${course.rating}',
                    color: const Color(0xFFFFB347)),
                _DetailStat(
                    icon: Icons.bar_chart,
                    label: 'Level',
                    value: course.level,
                    color: course.color),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: course.color,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Enrolled in "${course.title}"!'),
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  );
                },
                child: const Text('Enroll Now',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Reusable Widgets ─────────────────────────────────────────

class _StatChip extends StatelessWidget {
  final String label;
  final IconData icon;
  const _StatChip({required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(children: [
        Icon(icon, size: 14, color: Colors.white),
        const SizedBox(width: 5),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 12)),
      ]),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  const _Tag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(label,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          )),
    );
  }
}

class _DetailStat extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _DetailStat(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(icon, color: color, size: 22),
      const SizedBox(height: 4),
      Text(value,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1A1A2E),
          )),
      Text(label,
          style: const TextStyle(fontSize: 10, color: Colors.grey)),
    ]);
  }
}
