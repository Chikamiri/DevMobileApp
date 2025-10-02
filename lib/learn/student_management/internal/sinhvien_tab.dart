import 'package:flutter/material.dart';

typedef OnStudentTap = void Function(Map<String, String> student);

class SinhVienTab extends StatefulWidget {
  final OnStudentTap? onTap;
  const SinhVienTab({super.key, this.onTap});

  @override
  State<SinhVienTab> createState() => _SinhVienTabState();
}

class _SinhVienTabState extends State<SinhVienTab> {
  final List<Map<String, String>> _allStudents = [
    {'id': 'SV001', 'name': 'Lee Mank Duck', 'class': 'K63'},
    {'id': 'SV002', 'name': 'Trần Thị B', 'class': 'K36.3'},
    {'id': 'SV003', 'name': 'Negga C', 'class': 'K36'},
    {'id': 'SV004', 'name': 'Phạm Thị D', 'class': 'K62'},
    {'id': 'SV005', 'name': 'Hoàng Văn E', 'class': 'K61'},
  ];

  List<Map<String, String>> _filtered = [];
  String _query = '';
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _filtered = List.from(_allStudents);
  }

  void _filter(String q) {
    setState(() {
      _query = q;
      _filtered = _allStudents
          .where(
            (s) =>
                s['name']!.toLowerCase().contains(q.toLowerCase()) ||
                s['id']!.toLowerCase().contains(q.toLowerCase()) ||
                (s['class'] ?? '').toLowerCase().contains(q.toLowerCase()),
          )
          .toList();
    });
  }

  Future<void> _refresh() async {
    setState(() => _loading = true);
    await Future.delayed(const Duration(milliseconds: 600));
    setState(() => _loading = false);
  }

  String _initials(String name) {
    final parts = name.split(' ');
    if (parts.length == 1) return parts[0].substring(0, 1).toUpperCase();
    return (parts[0].substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return RefreshIndicator(
      onRefresh: _refresh,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: TextField(
              onChanged: _filter,
              decoration: InputDecoration(
                hintText: 'Tìm theo tên / mã / lớp',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _query.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _filter('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              children: [
                Text('Danh sách sinh viên', style: theme.textTheme.titleMedium),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(const SnackBar(content: Text('LOLLLLLLLL')));
                  },
                  icon: const Icon(Icons.person_add),
                  label: const Text('Thêm'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: _loading
                ? Center(
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.primary,
                    ),
                  )
                : _filtered.isEmpty
                ? Center(
                    child: Text(
                      'Không tìm thấy sinh viên',
                      style: theme.textTheme.bodyMedium,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 6,
                    ),
                    itemCount: _filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 6),
                    itemBuilder: (context, index) {
                      final s = _filtered[index];
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          onTap: () {
                            if (widget.onTap != null) widget.onTap!(s);
                          },
                          leading: CircleAvatar(
                            backgroundColor: theme.colorScheme.primaryContainer,
                            foregroundColor:
                                theme.colorScheme.onPrimaryContainer,
                            child: Text(
                              _initials(s['name'] ?? ''),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          title: Text(
                            s['name'] ?? '',
                            style: theme.textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            '${s['id']} • ${s['class']}',
                            style: theme.textTheme.bodySmall,
                          ),
                          trailing: PopupMenuButton<String>(
                            onSelected: (val) {
                              if (val == 'edit') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Edit (chưa implement)'),
                                  ),
                                );
                              } else if (val == 'delete') {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: const Text('Xác nhận'),
                                    content: Text(
                                      'Xóa ${s['name']} (${s['id']})?',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(),
                                        child: const Text('Huỷ'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          setState(() {
                                            _allStudents.removeWhere(
                                              (e) => e['id'] == s['id'],
                                            );
                                            _filter(_query);
                                          });
                                          Navigator.of(ctx).pop();
                                        },
                                        child: const Text('Xóa'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            itemBuilder: (context) => const [
                              PopupMenuItem(value: 'edit', child: Text('Sửa')),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Xóa'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
