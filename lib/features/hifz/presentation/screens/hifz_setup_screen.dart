import 'package:flutter/material.dart';
import '../../../quran/data/models/surah_info.dart';
import 'hifz_screen.dart';

/// Setup screen for Hifz mode — pick surah and ayah range.
class HifzSetupScreen extends StatefulWidget {
  const HifzSetupScreen({super.key});

  @override
  State<HifzSetupScreen> createState() => _HifzSetupScreenState();
}

class _HifzSetupScreenState extends State<HifzSetupScreen> {
  SurahInfo? _selectedSurah;
  int _startAyah = 1;
  int _endAyah = 0; // 0 = entire surah
  String _searchQuery = '';

  List<SurahInfo> get _filteredSurahs {
    if (_searchQuery.isEmpty) return SurahInfo.all;
    final q = _searchQuery.toLowerCase();
    return SurahInfo.all.where((s) {
      return s.nameTransliteration.toLowerCase().contains(q) ||
          s.nameEnglish.toLowerCase().contains(q) ||
          s.nameArabic.contains(q) ||
          s.number.toString() == q;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hifz Mode')),
      body: _selectedSurah == null ? _buildSurahPicker() : _buildRangePicker(),
    );
  }

  Widget _buildSurahPicker() {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose a Surah to memorize',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              // Search
              TextField(
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Search surahs...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Theme.of(context)
                      .colorScheme
                      .surfaceContainerHighest
                      .withAlpha(128),
                ),
              ),
            ],
          ),
        ),
        // Popular short surahs for memorization
        if (_searchQuery.isEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Popular for Hifz',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <int>[36, 55, 56, 67, 78, 112, 113, 114]
                      .map((n) {
                        final s = SurahInfo.all[n - 1];
                        return ActionChip(
                          label: Text(s.nameTransliteration),
                          avatar: CircleAvatar(
                            radius: 12,
                            backgroundColor:
                                Theme.of(context).colorScheme.primaryContainer,
                            child: Text(
                              '${s.number}',
                              style: const TextStyle(fontSize: 10),
                            ),
                          ),
                          onPressed: () => setState(() {
                            _selectedSurah = s;
                            _startAyah = 1;
                            _endAyah = s.ayahCount;
                          }),
                        );
                      })
                      .toList(),
                ),
                const SizedBox(height: 12),
                const Divider(),
              ],
            ),
          ),
        // Surah list
        Expanded(
          child: ListView.builder(
            itemCount: _filteredSurahs.length,
            itemBuilder: (context, index) {
              final surah = _filteredSurahs[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  child: Text(
                    '${surah.number}',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color:
                          Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ),
                ),
                title: Text(surah.nameTransliteration),
                subtitle: Text(
                    '${surah.nameEnglish} • ${surah.ayahCount} ayahs'),
                trailing: Text(
                  surah.nameArabic,
                  style: const TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 18,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                onTap: () => setState(() {
                  _selectedSurah = surah;
                  _startAyah = 1;
                  _endAyah = surah.ayahCount;
                }),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRangePicker() {
    final surah = _selectedSurah!;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Selected surah card
          Container(
            padding: const EdgeInsets.all(20),
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
                Text(
                  surah.nameArabic,
                  style: const TextStyle(
                    fontFamily: 'AmiriQuran',
                    fontSize: 28,
                    color: Colors.white,
                  ),
                  textDirection: TextDirection.rtl,
                ),
                const SizedBox(height: 4),
                Text(
                  '${surah.nameTransliteration} • ${surah.ayahCount} ayahs',
                  style: TextStyle(color: Colors.white.withAlpha(204)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          TextButton.icon(
            onPressed: () => setState(() => _selectedSurah = null),
            icon: const Icon(Icons.swap_horiz, size: 18),
            label: const Text('Change surah'),
          ),
          const SizedBox(height: 24),
          // Ayah range
          Text(
            'Ayah Range',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildRangeField(
                  label: 'From',
                  value: _startAyah,
                  max: surah.ayahCount,
                  onChanged: (v) => setState(() => _startAyah = v),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('to', style: TextStyle(fontSize: 16)),
              ),
              Expanded(
                child: _buildRangeField(
                  label: 'To',
                  value: _endAyah,
                  max: surah.ayahCount,
                  onChanged: (v) => setState(() => _endAyah = v),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Quick range buttons
          Wrap(
            spacing: 8,
            children: [
              _rangeChip('All', 1, surah.ayahCount),
              _rangeChip('First 10', 1, 10.clamp(1, surah.ayahCount)),
              if (surah.ayahCount > 10)
                _rangeChip('Last 10',
                    (surah.ayahCount - 9).clamp(1, surah.ayahCount),
                    surah.ayahCount),
              _rangeChip('First half', 1, (surah.ayahCount / 2).ceil()),
              _rangeChip('Second half',
                  (surah.ayahCount / 2).ceil() + 1, surah.ayahCount),
            ],
          ),
          const Spacer(),
          // Start button
          FilledButton.icon(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => HifzScreen(
                    surah: surah,
                    startAyah: _startAyah,
                    endAyah: _endAyah,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.play_arrow_rounded),
            label: Text(
              'Start Memorizing (${_endAyah - _startAyah + 1} ayahs)',
            ),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRangeField({
    required String label,
    required int value,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelMedium),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withAlpha(102),
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: value.clamp(1, max),
              isExpanded: true,
              items: List.generate(max, (i) => i + 1)
                  .map((n) => DropdownMenuItem(
                      value: n, child: Text('$n')))
                  .toList(),
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _rangeChip(String label, int start, int end) {
    final isActive = _startAyah == start && _endAyah == end;
    return ActionChip(
      label: Text(label),
      backgroundColor: isActive
          ? Theme.of(context).colorScheme.primaryContainer
          : null,
      onPressed: () => setState(() {
        _startAyah = start;
        _endAyah = end;
      }),
    );
  }
}
