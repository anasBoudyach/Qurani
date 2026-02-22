import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Khatmah (Reading Plans) screen.
/// Lets users set a goal to read the Quran in 30, 60, or 90 days
/// with daily page targets and progress tracking.
class KhatmahScreen extends StatefulWidget {
  const KhatmahScreen({super.key});

  @override
  State<KhatmahScreen> createState() => _KhatmahScreenState();
}

class _KhatmahScreenState extends State<KhatmahScreen> {
  static const _totalPages = 604;
  static const _prefsKeyPlan = 'khatmah_plan_days';
  static const _prefsKeyStartDate = 'khatmah_start_date';
  static const _prefsKeyPagesRead = 'khatmah_pages_read';

  int? _planDays;
  DateTime? _startDate;
  int _pagesRead = 0;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _planDays = prefs.getInt(_prefsKeyPlan);
      final startStr = prefs.getString(_prefsKeyStartDate);
      if (startStr != null) {
        _startDate = DateTime.tryParse(startStr);
      }
      _pagesRead = prefs.getInt(_prefsKeyPagesRead) ?? 0;
      _loading = false;
    });
  }

  Future<void> _startPlan(int days) async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    await prefs.setInt(_prefsKeyPlan, days);
    await prefs.setString(_prefsKeyStartDate, now.toIso8601String());
    await prefs.setInt(_prefsKeyPagesRead, 0);
    setState(() {
      _planDays = days;
      _startDate = now;
      _pagesRead = 0;
    });
  }

  Future<void> _addPages(int pages) async {
    final newTotal = (_pagesRead + pages).clamp(0, _totalPages);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_prefsKeyPagesRead, newTotal);
    setState(() => _pagesRead = newTotal);
  }

  Future<void> _resetPlan() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_prefsKeyPlan);
    await prefs.remove(_prefsKeyStartDate);
    await prefs.remove(_prefsKeyPagesRead);
    setState(() {
      _planDays = null;
      _startDate = null;
      _pagesRead = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        appBar: AppBar(title: const Text('Reading Plan')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Reading Plan'),
        actions: [
          if (_planDays != null)
            IconButton(
              icon: const Icon(Icons.restart_alt_rounded),
              tooltip: 'Reset plan',
              onPressed: () => showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Reset Plan?'),
                  content: const Text(
                      'This will erase your current progress. Are you sure?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () {
                        _resetPlan();
                        Navigator.pop(dialogContext);
                      },
                      child: const Text('Reset'),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: _planDays == null ? _buildPlanSelection() : _buildPlanProgress(),
    );
  }

  // ─── Plan Selection ───

  Widget _buildPlanSelection() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Header
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primary,
                Theme.of(context).colorScheme.primary.withAlpha(179),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            children: [
              const Icon(Icons.auto_stories_rounded,
                  color: Colors.white, size: 48),
              const SizedBox(height: 12),
              const Text(
                'Complete the Quran',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Choose a reading plan that fits your pace',
                style: TextStyle(color: Colors.white.withAlpha(204)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          'Choose Your Plan',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 12),
        _PlanOption(
          days: 30,
          pagesPerDay: (_totalPages / 30).ceil(),
          title: 'Intensive',
          subtitle: '~20 pages/day — for dedicated readers',
          color: Colors.deepPurple,
          icon: Icons.bolt_rounded,
          onTap: () => _startPlan(30),
        ),
        _PlanOption(
          days: 60,
          pagesPerDay: (_totalPages / 60).ceil(),
          title: 'Moderate',
          subtitle: '~10 pages/day — balanced pace',
          color: Colors.teal,
          icon: Icons.speed_rounded,
          onTap: () => _startPlan(60),
        ),
        _PlanOption(
          days: 90,
          pagesPerDay: (_totalPages / 90).ceil(),
          title: 'Gentle',
          subtitle: '~7 pages/day — steady and consistent',
          color: Colors.blue,
          icon: Icons.self_improvement_rounded,
          onTap: () => _startPlan(90),
        ),
        _PlanOption(
          days: 365,
          pagesPerDay: (_totalPages / 365).ceil(),
          title: 'Annual',
          subtitle: '~2 pages/day — relaxed year-long journey',
          color: Colors.green,
          icon: Icons.calendar_today_rounded,
          onTap: () => _startPlan(365),
        ),
      ],
    );
  }

  // ─── Plan Progress ───

  Widget _buildPlanProgress() {
    final dailyTarget = (_totalPages / _planDays!).ceil();
    final progress = _pagesRead / _totalPages;
    final daysElapsed = _startDate != null
        ? DateTime.now().difference(_startDate!).inDays + 1
        : 1;
    final expectedPages = (dailyTarget * daysElapsed).clamp(0, _totalPages);
    final isOnTrack = _pagesRead >= expectedPages;
    final pagesRemaining = _totalPages - _pagesRead;
    final daysRemaining = _planDays! - daysElapsed;
    final isCompleted = _pagesRead >= _totalPages;

    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Progress ring
        Center(
          child: SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 12,
                    backgroundColor:
                        Theme.of(context).colorScheme.primary.withAlpha(51),
                    strokeCap: StrokeCap.round,
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '${(progress * 100).toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                    ),
                    Text(
                      '$_pagesRead / $_totalPages pages',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(153),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        // Status
        if (isCompleted)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withAlpha(26),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.green.withAlpha(102)),
            ),
            child: Row(
              children: [
                const Icon(Icons.celebration_rounded, color: Colors.green),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Khatmah Complete!',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      Text(
                        'Ma sha Allah! You completed the Quran in $daysElapsed days.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        else
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isOnTrack
                  ? Colors.green.withAlpha(20)
                  : Colors.orange.withAlpha(20),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isOnTrack
                    ? Colors.green.withAlpha(102)
                    : Colors.orange.withAlpha(102),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  isOnTrack
                      ? Icons.check_circle_rounded
                      : Icons.warning_rounded,
                  color: isOnTrack ? Colors.green : Colors.orange,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isOnTrack ? 'On Track!' : 'Behind Schedule',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: isOnTrack ? Colors.green : Colors.orange,
                        ),
                      ),
                      Text(
                        isOnTrack
                            ? 'Keep it up! Read $dailyTarget pages today.'
                            : 'You need to read ${expectedPages - _pagesRead} extra pages to catch up.',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 20),
        // Stats grid
        Row(
          children: [
            _StatCard(
              label: 'Daily Target',
              value: '$dailyTarget',
              unit: 'pages',
              icon: Icons.today_rounded,
            ),
            const SizedBox(width: 12),
            _StatCard(
              label: 'Days Left',
              value: '${daysRemaining.clamp(0, _planDays!)}',
              unit: 'of $_planDays',
              icon: Icons.hourglass_bottom_rounded,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _StatCard(
              label: 'Remaining',
              value: '$pagesRemaining',
              unit: 'pages',
              icon: Icons.menu_book_rounded,
            ),
            const SizedBox(width: 12),
            _StatCard(
              label: 'Day',
              value: '$daysElapsed',
              unit: 'of $_planDays',
              icon: Icons.calendar_today_rounded,
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Log pages
        if (!isCompleted) ...[
          Text(
            'Log Today\'s Reading',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _QuickLogButton(
                  pages: 1, label: '+1', onTap: () => _addPages(1)),
              const SizedBox(width: 8),
              _QuickLogButton(
                  pages: 5, label: '+5', onTap: () => _addPages(5)),
              const SizedBox(width: 8),
              _QuickLogButton(
                  pages: dailyTarget,
                  label: '+$dailyTarget',
                  onTap: () => _addPages(dailyTarget)),
              const SizedBox(width: 8),
              _QuickLogButton(
                  pages: 20, label: '+20', onTap: () => _addPages(20)),
            ],
          ),
          const SizedBox(height: 12),
          // Custom input
          OutlinedButton.icon(
            onPressed: () => _showCustomInput(),
            icon: const Icon(Icons.edit_rounded, size: 18),
            label: const Text('Log custom amount'),
          ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }

  void _showCustomInput() {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log Pages Read'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Number of pages',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final pages = int.tryParse(controller.text);
              if (pages != null && pages > 0) {
                _addPages(pages);
              }
              Navigator.pop(ctx);
            },
            child: const Text('Log'),
          ),
        ],
      ),
    );
  }
}

class _PlanOption extends StatelessWidget {
  final int days;
  final int pagesPerDay;
  final String title;
  final String subtitle;
  final Color color;
  final IconData icon;
  final VoidCallback onTap;

  const _PlanOption({
    required this.days,
    required this.pagesPerDay,
    required this.title,
    required this.subtitle,
    required this.color,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withAlpha(26),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$title — $days days',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withAlpha(153),
                          ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, size: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  final IconData icon;

  const _StatCard({
    required this.label,
    required this.value,
    required this.unit,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest
              .withAlpha(128),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 18,
                color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              '$label ($unit)',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withAlpha(128),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickLogButton extends StatelessWidget {
  final int pages;
  final String label;
  final VoidCallback onTap;

  const _QuickLogButton({
    required this.pages,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FilledButton.tonal(
        onPressed: onTap,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
