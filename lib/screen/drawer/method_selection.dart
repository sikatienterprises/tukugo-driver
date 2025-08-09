import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PaymentMethod {
  final String id;
  final String type;
  final String cardNumber;
  final String expiry;

  PaymentMethod({
    this.id = '',
    this.type = '',
    this.cardNumber = '',
    this.expiry = '',
  });
}

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedSavedMethod = '';
  String? _selectedDropdownMethod;
  String _customInput = '';
  final TextEditingController _customInputController = TextEditingController();

  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      id: 'visa',
      type: 'Visa',
      cardNumber: '**** **** **** 1234',
      expiry: '12/25',
    ),
    PaymentMethod(
      id: 'mastercard',
      type: 'MasterCard',
      cardNumber: '**** **** **** 5678',
      expiry: '11/24',
    ),
    PaymentMethod(id: 'cash', type: 'Cash'),
  ];

  final List<String> _otherPaymentOptions = ['UPI', 'Net Banking', 'Wallet'];

  void _resetSavedSelection() {
    setState(() {
      _selectedSavedMethod = '';
    });
  }

  void _resetDropdownSelection() {
    setState(() {
      _selectedDropdownMethod = null;
      _customInputController.clear();
      _customInput = '';
    });
  }

  @override
  void dispose() {
    _customInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            context.go('/wallet');
          },
          child: const Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: const Text(
          'Amount',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Select payment method',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),

            // Other methods dropdown
            DropdownButtonFormField<String>(
              value: _selectedDropdownMethod,
              decoration: InputDecoration(
                hintText: 'Other Payment Method',
                hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              items: _otherPaymentOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                );
              }).toList(),
              onChanged: (value) {
                _resetSavedSelection(); // Unselect saved method
                setState(() {
                  _selectedDropdownMethod = value;
                });
              },
            ),

            if (_selectedDropdownMethod != null) ...[
              const SizedBox(height: 12),
              TextFormField(
                controller: _customInputController,
                decoration: InputDecoration(
                  hintText: _selectedDropdownMethod == 'UPI'
                      ? 'Enter UPI ID'
                      : 'Enter ${_selectedDropdownMethod!} details',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onChanged: (val) {
                  _customInput = val;
                },
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    print(
                      'Saved ${_selectedDropdownMethod!} with value $_customInput',
                    );
                    // Add your save logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Save Payment Method',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],

            const SizedBox(height: 24),

            // Saved payment methods list
            Expanded(
              child: ListView.builder(
                itemCount: _paymentMethods.length,
                itemBuilder: (context, index) {
                  final method = _paymentMethods[index];
                  final isSelected = _selectedSavedMethod == method.id;

                  return GestureDetector(
                    onTap: () {
                      _resetDropdownSelection(); // Unselect dropdown if saved is selected
                      setState(() {
                        _selectedSavedMethod = method.id;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.teal.withOpacity(0.1)
                            : Colors.grey.shade100,
                        border: Border.all(
                          color:
                              isSelected ? Colors.teal : Colors.grey.shade300,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: _buildPaymentIcon(method),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  method.type,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (method.cardNumber.isNotEmpty) ...[
                                  const SizedBox(height: 4),
                                  Text(
                                    method.cardNumber,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                  Text(
                                    method.expiry,
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                                ] else
                                  Text(
                                    'Cash',
                                    style: TextStyle(color: Colors.grey[600]),
                                  ),
                              ],
                            ),
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
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            if (_selectedSavedMethod.isNotEmpty) {
              print('Proceed with saved method: $_selectedSavedMethod');
              context.go('/auth/drawer/addmoney');
            } else {
              print('Please select or enter a payment method');
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please select or enter a payment method'),
                backgroundColor: Colors.red,
              ));
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentIcon(PaymentMethod method) {
    switch (method.id) {
      case 'visa':
        return Center(
          child: Text(
            'VISA',
            style: TextStyle(
              color: Colors.blue[700],
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      case 'mastercard':
        return Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(left: 3),
                decoration: const BoxDecoration(
                  color: Colors.orange,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        );
      case 'cash':
        return Icon(Icons.money, color: Colors.green[600], size: 20);
      default:
        return const Icon(Icons.credit_card, color: Colors.grey, size: 20);
    }
  }
}
