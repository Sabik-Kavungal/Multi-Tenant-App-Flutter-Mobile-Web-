import 'package:flutter/material.dart';
import 'package:saasf/core/constants/constants.dart';

/// Queue Management Page - Real-time queue for walk-in customers
/// Staff can manage the waiting queue and call next customers
class QueueManagementPage extends StatefulWidget {
  const QueueManagementPage({super.key});

  @override
  State<QueueManagementPage> createState() => _QueueManagementPageState();
}

class _QueueManagementPageState extends State<QueueManagementPage> {
  // Mock data - Replace with API call: GET /api/v1/queue?tenant_id=:id
  Map<String, dynamic>? _currentlyServing;
  final List<Map<String, dynamic>> _waitingQueue = [
    {
      'id': 'token-6',
      'token': 6,
      'name': 'Jane Smith',
      'service': 'Haircut',
      'waitTime': 15,
      'joinedAt': '10:15 AM',
    },
    {
      'id': 'token-7',
      'token': 7,
      'name': 'Bob Wilson',
      'service': 'Coloring',
      'waitTime': 30,
      'joinedAt': '10:20 AM',
    },
    {
      'id': 'token-8',
      'token': 8,
      'name': 'Alice Brown',
      'service': 'Styling',
      'waitTime': 45,
      'joinedAt': '10:30 AM',
    },
    {
      'id': 'token-9',
      'token': 9,
      'name': 'Charlie Davis',
      'service': 'Haircut',
      'waitTime': 55,
      'joinedAt': '10:35 AM',
    },
  ];

  @override
  void initState() {
    super.initState();
    // Start with first customer being served
    _currentlyServing = {
      'id': 'token-5',
      'token': 5,
      'name': 'John Doe',
      'service': 'Haircut',
      'startedAt': '10:00 AM',
    };
  }

  int get _totalWaiting => _waitingQueue.length;
  int get _avgWaitTime {
    if (_waitingQueue.isEmpty) return 0;
    return (_waitingQueue.fold<int>(
              0,
              (sum, item) => sum + (item['waitTime'] as int),
            ) /
            _waitingQueue.length)
        .round();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Queue Management'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('Queue refreshed')));
            },
          ),
          IconButton(icon: const Icon(Icons.add), onPressed: _addToQueue),
        ],
      ),
      body: Column(
        children: [
          // Stats Header
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary,
            child: Row(
              children: [
                Expanded(
                  child: _buildHeaderStat(
                    'In Queue',
                    '$_totalWaiting',
                    Icons.people,
                  ),
                ),
                Container(width: 1, height: 40, color: Colors.white24),
                Expanded(
                  child: _buildHeaderStat(
                    'Avg Wait',
                    '$_avgWaitTime min',
                    Icons.timer,
                  ),
                ),
              ],
            ),
          ),

          // Currently Serving Card
          if (_currentlyServing != null) _buildCurrentlyServingCard(),

          // Queue List Header
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Waiting Queue',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  '$_totalWaiting customers',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          // Queue List
          Expanded(
            child: _waitingQueue.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _waitingQueue.length,
                    itemBuilder: (context, index) =>
                        _buildQueueItem(_waitingQueue[index], index),
                  ),
          ),
        ],
      ),
      floatingActionButton:
          _waitingQueue.isNotEmpty && _currentlyServing == null
          ? FloatingActionButton.extended(
              onPressed: _callNext,
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.play_arrow),
              label: const Text('Call Next'),
            )
          : null,
    );
  }

  Widget _buildHeaderStat(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white70, size: 24),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.8)),
        ),
      ],
    );
  }

  Widget _buildCurrentlyServingCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.success, AppColors.success.withOpacity(0.8)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.success.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.play_circle, color: Colors.white, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'NOW SERVING',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  'Started: ${_currentlyServing!['startedAt']}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                // Token Number
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      '#${_currentlyServing!['token']}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.success,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _currentlyServing!['name'],
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _currentlyServing!['service'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                // Complete Button
                ElevatedButton(
                  onPressed: _completeCurrentService,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.success,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Done',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.groups_outlined, size: 64, color: AppColors.textHint),
          const SizedBox(height: 16),
          const Text(
            'No customers waiting',
            style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
          ),
          const SizedBox(height: 8),
          Text(
            'Queue is empty',
            style: TextStyle(fontSize: 14, color: AppColors.textHint),
          ),
        ],
      ),
    );
  }

  Widget _buildQueueItem(Map<String, dynamic> item, int index) {
    final isFirst = index == 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isFirst ? AppColors.primary : AppColors.border,
          width: isFirst ? 2 : 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Position & Token
            Column(
              children: [
                // Position Badge
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: isFirst
                        ? AppColors.primary
                        : AppColors.textHint.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: isFirst ? Colors.white : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '#${item['token']}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
            // Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['name'],
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.content_cut,
                        size: 14,
                        color: AppColors.textHint,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        item['service'],
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 14, color: AppColors.textHint),
                      const SizedBox(width: 4),
                      Text(
                        'Joined at ${item['joinedAt']}',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textHint,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Wait Time & Actions
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: _getWaitTimeColor(item['waitTime']).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.timer_outlined,
                        size: 14,
                        color: _getWaitTimeColor(item['waitTime']),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '~${item['waitTime']} min',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: _getWaitTimeColor(item['waitTime']),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isFirst && _currentlyServing == null)
                      IconButton(
                        onPressed: () => _callCustomer(item),
                        icon: const Icon(
                          Icons.play_circle_filled,
                          color: AppColors.primary,
                        ),
                        tooltip: 'Call',
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () => _removeFromQueue(item),
                      icon: Icon(Icons.close, color: AppColors.error, size: 20),
                      tooltip: 'Remove',
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getWaitTimeColor(int minutes) {
    if (minutes <= 15) return AppColors.success;
    if (minutes <= 30) return AppColors.warning;
    return AppColors.error;
  }

  void _callNext() {
    if (_waitingQueue.isEmpty) return;

    final next = _waitingQueue.removeAt(0);
    setState(() {
      _currentlyServing = {...next, 'startedAt': _getCurrentTime()};
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Now serving: ${next['name']} (Token #${next['token']})'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _callCustomer(Map<String, dynamic> item) {
    _waitingQueue.remove(item);
    setState(() {
      _currentlyServing = {...item, 'startedAt': _getCurrentTime()};
    });
  }

  void _completeCurrentService() {
    final completed = _currentlyServing!['name'];
    setState(() {
      _currentlyServing = null;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Completed service for $completed'),
        backgroundColor: AppColors.success,
      ),
    );

    // Auto-call next if queue is not empty
    if (_waitingQueue.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 500), _callNext);
    }
  }

  void _removeFromQueue(Map<String, dynamic> item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Remove from Queue'),
        content: Text('Remove ${item['name']} from the queue?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _waitingQueue.remove(item);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item['name']} removed from queue')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
            ),
            child: const Text('Remove'),
          ),
        ],
      ),
    );
  }

  void _addToQueue() {
    final lastToken = _waitingQueue.isEmpty
        ? (_currentlyServing?['token'] ?? 0) as int
        : _waitingQueue.last['token'] as int;

    showDialog(
      context: context,
      builder: (context) {
        String name = '';
        String service = 'Haircut';

        return AlertDialog(
          title: const Text('Add to Queue'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'Customer Name',
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => name = value,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: service,
                decoration: const InputDecoration(
                  labelText: 'Service',
                  border: OutlineInputBorder(),
                ),
                items: ['Haircut', 'Coloring', 'Styling', 'Treatment']
                    .map((s) => DropdownMenuItem(value: s, child: Text(s)))
                    .toList(),
                onChanged: (value) => service = value ?? 'Haircut',
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (name.isEmpty) return;
                Navigator.pop(context);
                setState(() {
                  _waitingQueue.add({
                    'id': 'token-${lastToken + 1}',
                    'token': lastToken + 1,
                    'name': name,
                    'service': service,
                    'waitTime': _avgWaitTime + 15,
                    'joinedAt': _getCurrentTime(),
                  });
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '$name added to queue (Token #${lastToken + 1})',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12
        ? now.hour - 12
        : (now.hour == 0 ? 12 : now.hour);
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
