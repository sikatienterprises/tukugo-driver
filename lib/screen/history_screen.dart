import 'package:flutter/material.dart';

// Data model for history items
class HistoryItem {
  final String name;
  final String location;
  final String time;
  final String status;

  HistoryItem({
    required this.name,
    required this.location,
    required this.time,
    required this.status,
  });
}

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Sample data for different tabs
  static List<HistoryItem> upcomingItems = [
    HistoryItem(
      name: 'Rahul',
      location: 'Mustang Shelby GT',
      time: 'Today at 09:20 am',
      status: 'upcoming',
    ),
    HistoryItem(
      name: 'Ravi',
      location: 'Mustang Shelby GT',
      time: 'Today at 10:20 am',
      status: 'upcoming',
    ),
    HistoryItem(
      name: 'Aryan',
      location: 'Mustang Shelby GT',
      time: 'Tomorrow at 09:20 am',
      status: 'upcoming',
    ),
    HistoryItem(
      name: 'Divyansh',
      location: 'Mustang Shelby GT',
      time: 'Today at 09:20 am',
      status: 'upcoming',
    ),
    HistoryItem(
      name: 'Priyam',
      location: 'Mustang Shelby GT',
      time: 'Today at 10:20 am',
      status: 'upcoming',
    ),
    HistoryItem(
      name: 'Suruchi',
      location: 'Mustang Shelby GT',
      time: 'Tomorrow at 09:20 am',
      status: 'upcoming',
    ),
    HistoryItem(
      name: 'Riya',
      location: 'Mustang Shelby GT',
      time: 'Today at 10:20 am',
      status: 'upcoming',
    ),
    HistoryItem(
      name: 'Pranjal',
      location: 'Mustang Shelby GT',
      time: 'Tomorrow at 09:20 am',
      status: 'upcoming',
    ),
  ];

  static List<HistoryItem> completedItems = [
    HistoryItem(
      name: 'Rahul',
      location: 'Mustang Shelby GT',
      time: 'Done',
      status: 'completed',
    ),
    HistoryItem(
      name: 'Ravi',
      location: 'Mustang Shelby GT',
      time: 'Done',
      status: 'completed',
    ),
    HistoryItem(
      name: 'Aryan',
      location: 'Mustang Shelby GT',
      time: 'Done',
      status: 'completed',
    ),
    HistoryItem(
      name: 'Divyansh',
      location: 'Mustang Shelby GT',
      time: 'Done',
      status: 'completed',
    ),
    HistoryItem(
      name: 'Priyam',
      location: 'Mustang Shelby GT',
      time: 'Done',
      status: 'completed',
    ),
    HistoryItem(
      name: 'Suruchi',
      location: 'Mustang Shelby GT',
      time: 'Done',
      status: 'completed',
    ),
    HistoryItem(
      name: 'Riya',
      location: 'Mustang Shelby GT',
      time: 'Done',
      status: 'completed',
    ),
    HistoryItem(
      name: 'Pranjal',
      location: 'Mustang Shelby GT',
      time: 'Done',
      status: 'completed',
    ),
  ];

  static List<HistoryItem> cancelledItems = [
    HistoryItem(
      name: 'Rahul',
      location: 'Mustang Shelby GT',
      time: 'Cancelled',
      status: 'cancelled',
    ),
    HistoryItem(
      name: 'Ravi',
      location: 'Mustang Shelby GT',
      time: 'Cancelled',
      status: 'cancelled',
    ),
    HistoryItem(
      name: 'Aryan',
      location: 'Mustang Shelby GT',
      time: 'Cancelled',
      status: 'cancelled',
    ),
    HistoryItem(
      name: 'Divyansh',
      location: 'Mustang Shelby GT',
      time: 'Cancelled',
      status: 'cancelled',
    ),
    HistoryItem(
      name: 'Priyam',
      location: 'Mustang Shelby GT',
      time: 'Cancelled',
      status: 'cancelled',
    ),
    HistoryItem(
      name: 'Suruchi',
      location: 'Mustang Shelby GT',
      time: 'Cancelled',
      status: 'cancelled',
    ),
    HistoryItem(
      name: 'Riya',
      location: 'Mustang Shelby GT',
      time: 'Cancelled',
      status: 'cancelled',
    ),
    HistoryItem(
      name: 'Pranjal',
      location: 'Mustang Shelby GT',
      time: 'Cancelled',
      status: 'cancelled',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'History',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.all(16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TabBar(
                controller: _tabController,
                indicator: BoxDecoration(
                  color: const Color(0xFF2196F3),
                  borderRadius: BorderRadius.circular(6),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey[700],
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                unselectedLabelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                tabs: const [
                  Tab(text: 'Upcoming'),
                  Tab(text: 'Completed'),
                  Tab(text: 'Cancelled'),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildHistoryList(upcomingItems),
                _buildHistoryList(completedItems),
                _buildHistoryList(cancelledItems),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryList(List<HistoryItem> items) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return HistoryCard(item: items[index]);
      },
    );
  }
}

class HistoryCard extends StatelessWidget {
  final HistoryItem item;

  const HistoryCard({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (item.status) {
      case 'completed':
        statusColor = const Color(0xFF4CAF50);
        break;
      case 'cancelled':
        statusColor = const Color(0xFFF44336);
        break;
      default:
        statusColor = Colors.grey[600]!;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.location,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            item.time,
            style: TextStyle(
              fontSize: 13,
              color: statusColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
