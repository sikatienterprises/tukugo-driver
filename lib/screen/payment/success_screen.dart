import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentSuccessScreen extends StatelessWidget {
  void _showRatingDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: RatingBottomSheet(
            amount: 100.0,
            onSubmit: (rating, feedback) {
              print('Rating: $rating');
              print('Feedback: $feedback');
              // Handle the rating and feedback submission here
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Container(
          padding: EdgeInsets.only(left: 16),
          child: GestureDetector(
            onTap: () {
              // Show the rating dialog - FIXED THIS PART
              _showRatingDialog(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Color(0xFF007AFF),
              size: 20,
            ),
          ),
        ),
        title: Text(
          'Payment',
          style: TextStyle(
            color: Color.fromRGBO(0, 0, 0, 0.8),
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(
              Icons.download,
              color: Color.fromRGBO(29, 27, 32, 0.6),
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Green Success Container
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: Color.fromRGBO(20, 145, 20, 0.8),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
              child: Column(
                children: [
                  Text(
                    'Payment succeeded',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 100,
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    '₹100.0',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 42,
                      fontWeight: FontWeight.w600,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '467332245211',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Payment Details
          Expanded(
            child: Container(
              width: double.infinity,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildInfoRow('Amount', '₹100'),
                    _buildDivider(),
                    _buildInfoRow('Date', 'June 15, 2025 11:13 AM'),
                    _buildDivider(),
                    _buildInfoRow('Order ID', '46524566221'),
                    _buildDivider(),
                    _buildInfoRow('Customer\'s name', 'Divyansh'),
                    _buildDivider(),
                    _buildInfoRow('Status', 'Succeeded'),
                    Spacer(),

                    // Optional: Add a rating button in the details section
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => _showRatingDialog(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Rate Experience',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.6),
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Color.fromRGBO(0, 0, 0, 0.5),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 0.5,
      color: Color(0xFFE5E5EA),
    );
  }
}

class RatingBottomSheet extends StatefulWidget {
  final double amount;
  final Function(int rating, String feedback)? onSubmit;

  const RatingBottomSheet({
    Key? key,
    required this.amount,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<RatingBottomSheet> createState() => _RatingBottomSheetState();
}

class _RatingBottomSheetState extends State<RatingBottomSheet> {
  int selectedRating = 4; // Default to 4 stars as shown in image
  final TextEditingController _feedbackController = TextEditingController();

  String get ratingText {
    switch (selectedRating) {
      case 1:
        return 'Poor';
      case 2:
        return 'Fair';
      case 3:
        return 'Good';
      case 4:
        return 'Excellent';
      case 5:
        return 'Outstanding';
      default:
        return '';
    }
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top handle indicator
            Container(
              width: 132,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(2),
              ),
            ),

            const SizedBox(height: 36),

            // Star Rating
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRating = index + 1;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      Icons.star,
                      size: 40,
                      color: index < selectedRating
                          ? Colors.amber
                          : Colors.grey[300],
                    ),
                  ),
                );
              }),
            ),

            const SizedBox(height: 40),

            // Rating text
            Text(
              ratingText,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.blue,
                fontWeight: FontWeight.w600,
              ),
            ),

            const SizedBox(height: 20),

            // Rating description
            Text(
              'You rated Divyansh $selectedRating star${selectedRating != 1 ? 's' : ''}',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromRGBO(184, 184, 184, 1),
              ),
            ),

            const SizedBox(height: 24),

            // Feedback text field
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Write your text...',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Submit button
            SizedBox(
              width: 368,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (widget.onSubmit != null) {
                    widget.onSubmit!(selectedRating, _feedbackController.text);
                  }
                  context.go('/payment');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            // Add some bottom padding for safe area
            SizedBox(height: MediaQuery.of(context).padding.bottom + 40),
          ],
        ),
      ),
    );
  }
}
