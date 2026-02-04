import 'package:flutter/material.dart';
import 'package:saasf/core/constants/constants.dart';

/// My Schedule Page - Staff's assigned bookings for the day
/// Staff can view and mark appointments as completed
class MySchedulePage extends StatefulWidget {
  const MySchedulePage({super.key});

  @override
  State<MySchedulePage> createState() => _MySchedulePageState();
}

class _MySchedulePageState extends State<MySchedulePage> {
  DateTime _selectedDate = DateTime.now();

  // Mock data - Replace with API call: GET /api/v1/bookings?staff_id=:id
  final List<Map<String, dynamic>> _appointments = [
    {
      'id': 'apt-1',
      'customer': 'John Doe',
      'service': 'Haircut',
      'time': '10:00 AM',
      'duration': '30 min',
      'status': 'confirmed',
      'phone': '+1 234 567 890',
    },
    {
      'id': 'apt-2',
      'customer': 'Jane Smith',
      'service': 'Hair Coloring',
      'time': '11:00 AM',
      'duration': '60 min',
      'status': 'in_progress',
      'phone': '+1 234 567 891',
    },
    {
      'id': 'apt-3',
      'customer': 'Bob Wilson',
      'service': 'Styling',
      'time': '1:00 PM',
      'duration': '20 min',
      'status': 'confirmed',
      'phone': '+1 234 567 892',
    },
    {
      'id': 'apt-4',
      'customer': 'Alice Brown',
      'service': 'Hair Treatment',
      'time': '2:00 PM',
      'duration': '45 min',
      'status': 'confirmed',
      'phone': '+1 234 567 893',
    },
    {
      'id': 'apt-5',
      'customer': 'Charlie Davis',
      'service': 'Haircut',
      'time': '3:30 PM',
      'duration': '30 min',
      'status': 'completed',
      'phone': '+1 234 567 894',
    },
  ];

  int get _completedCount =>
      _appointments.where((a) => a['status'] == 'completed').length;
  int get _pendingCount =>
      _appointments.where((a) => a['status'] != 'completed').length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('My Schedule'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_month),
            onPressed: _selectDate,
          ),
        ],
      ),
      body: Column(
        children: [
          // Date & Stats Header
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary,
            child: Column(
              children: [
                // Date Selector
                InkWell(
                  onTap: _selectDate,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          _formatDate(_selectedDate),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Stats Row
                Row(
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        'Total',
                        '${_appointments.length}',
                        Icons.event,
                        Colors.white,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Pending',
                        '$_pendingCount',
                        Icons.pending_actions,
                        AppColors.warning,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildStatCard(
                        'Done',
                        '$_completedCount',
                        Icons.check_circle,
                        AppColors.success,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Appointments List
          Expanded(
            child: _appointments.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _appointments.length,
                    itemBuilder: (context, index) =>
                        _buildAppointmentCard(_appointments[index]),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.8),
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
          Icon(
            Icons.event_available,
            size: 64,
            color: AppColors.textHint,
          ),
          const SizedBox(height: 16),
          const Text(
            'No appointments today',
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enjoy your free time!',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textHint,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    final status = appointment['status'] as String;
    final isCompleted = status == 'completed';
    final isInProgress = status == 'in_progress';

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isInProgress ? AppColors.primary : AppColors.border,
          width: isInProgress ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Time Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isInProgress
                  ? AppColors.primary.withOpacity(0.1)
                  : isCompleted
                      ? AppColors.success.withOpacity(0.1)
                      : AppColors.background,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: isInProgress
                      ? AppColors.primary
                      : isCompleted
                          ? AppColors.success
                          : AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  appointment['time'],
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: isInProgress
                        ? AppColors.primary
                        : isCompleted
                            ? AppColors.success
                            : AppColors.textPrimary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '• ${appointment['duration']}',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Spacer(),
                // Status Badge
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getStatusColor(status).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    _getStatusText(status),
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: _getStatusColor(status),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Customer Row
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Center(
                        child: Text(
                          appointment['customer'][0],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment['customer'],
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            appointment['service'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Phone Button
                    IconButton(
                      onPressed: () => _callCustomer(appointment['phone']),
                      icon: const Icon(
                        Icons.phone_outlined,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
                if (!isCompleted) ...[
                  const SizedBox(height: 16),
                  // Action Buttons
                  Row(
                    children: [
                      if (!isInProgress)
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () => _startAppointment(appointment),
                            icon: const Icon(Icons.play_arrow, size: 18),
                            label: const Text('Start'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.primary,
                              side: const BorderSide(color: AppColors.primary),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      if (isInProgress) ...[
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () => _completeAppointment(appointment),
                            icon: const Icon(Icons.check, size: 18),
                            label: const Text('Complete'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.success,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'confirmed':
        return AppColors.info;
      case 'in_progress':
        return AppColors.primary;
      case 'completed':
        return AppColors.success;
      case 'cancelled':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getStatusText(String status) {
    switch (status) {
      case 'confirmed':
        return 'Confirmed';
      case 'in_progress':
        return 'In Progress';
      case 'completed':
        return 'Completed';
      case 'cancelled':
        return 'Cancelled';
      default:
        return status;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final selected = DateTime(date.year, date.month, date.day);

    if (selected == today) {
      return 'Today, ${_formatMonthDay(date)}';
    } else if (selected == tomorrow) {
      return 'Tomorrow, ${_formatMonthDay(date)}';
    } else {
      return '${_getDayName(date.weekday)}, ${_formatMonthDay(date)}';
    }
  }

  String _formatMonthDay(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}';
  }

  String _getDayName(int weekday) {
    final days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  Future<void> _selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now().add(const Duration(days: 60)),
    );
    if (date != null) {
      setState(() => _selectedDate = date);
    }
  }

  void _callCustomer(String phone) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Calling $phone...')),
    );
  }

  void _startAppointment(Map<String, dynamic> appointment) {
    setState(() {
      appointment['status'] = 'in_progress';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Started appointment with ${appointment['customer']}'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _completeAppointment(Map<String, dynamic> appointment) {
    setState(() {
      appointment['status'] = 'completed';
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Completed appointment with ${appointment['customer']}'),
        backgroundColor: AppColors.success,
      ),
    );
  }
}
