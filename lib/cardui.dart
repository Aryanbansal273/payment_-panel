import 'dart:ui';
import 'package:faker/faker.dart' as fkr;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CardUI extends StatefulWidget {
  const CardUI({super.key});

  @override
  State<CardUI> createState() => _CardUIState();
}

class _CardUIState extends State<CardUI> {
  final RxBool isCardSelected = false.obs;
  final Rx<Color> payButtonColor = Colors.white.obs;
  final Rx<Color> cardButtonColor = Colors.white.obs;
  final RxBool _isCvvVisible = false.obs;
  final RxBool _isFrozen = false.obs;
  final faker = fkr.Faker();

  List<String> generateCardNumber() {
    String cardNumber = faker.randomGenerator.numberOfLength(16);
    return [
      cardNumber.substring(0, 4),
      cardNumber.substring(4, 8),
      cardNumber.substring(8, 12),
      cardNumber.substring(12, 16),
    ];
  }

  String generateExpiryDate() {
    int month = faker.randomGenerator.integer(12, min: 1);
    int year = faker.randomGenerator.integer(10, min: 0) + DateTime.now().year % 100;
    return '${month.toString().padLeft(2, '0')}/${year.toString().padLeft(2, '0')}';
  }

  String generateCvv() {
    return faker.randomGenerator.numberOfLength(3);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    double cardWidth = size.width * 0.60;
    double cardHeight = size.height * 0.45;
    final cardNumbers = generateCardNumber();
    final expiryDate = generateExpiryDate();
    final cvv = generateCvv();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'select payment mode',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'choose your preferred payment method to make payment.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Obx(() => Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 12.0),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: payButtonColor.value, width: 3.0),
                            bottom: BorderSide(color: payButtonColor.value, width: 0.1),
                            left: BorderSide(color: payButtonColor.value, width: 1.0),
                            right: BorderSide(color: payButtonColor.value, width: 1.0),
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          ),
                          onPressed: () {
                            payButtonColor.value = Colors.red;
                            cardButtonColor.value = Colors.white;
                          },
                          child: const Text(
                            'Pay',
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                      )),
                    ),
                    Flexible(
                      child: Obx(() => Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: cardButtonColor.value, width: 3.0),
                            bottom: BorderSide(color: cardButtonColor.value, width: 0.1),
                            left: BorderSide(color: cardButtonColor.value, width: 1.0),
                            right: BorderSide(color: cardButtonColor.value, width: 1.0),
                          ),
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
                          ),
                          onPressed: () {
                            cardButtonColor.value = Colors.red;
                            payButtonColor.value = Colors.white;
                          },
                          child: const Text(
                            'Card',
                            style: TextStyle(color: Colors.white, fontSize: 18.0),
                          ),
                        ),
                      )),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'YOUR DIGITAL DEBIT CARD',
                        style: TextStyle(color: Colors.grey[600], fontSize: size.width * 0.04),
                      ),
                      SizedBox(height: size.height * 0.02),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Container(
                              width: cardWidth,
                              height: cardHeight,
                              margin: EdgeInsets.only(right: size.width * 0.03),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey[900]!),
                              ),
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Opacity(
                                        opacity: 0.2,
                                        child: Image.asset(
                                          'assets/3.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          gradient: RadialGradient(
                                            center: Alignment.center,
                                            colors: [
                                              Colors.black.withOpacity(0.6),
                                              Colors.transparent,
                                            ],
                                            stops: const [0.5, 1.0],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(size.width * 0.05, size.height * 0.03, size.width * 0.05, size.height * 0.02),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Image.asset(
                                              'assets/5.jpg',
                                              height: size.height * 0.04,
                                              fit: BoxFit.contain,
                                            ),
                                            Container(
                                              padding: const EdgeInsets.all(3),
                                              child: Image.asset(
                                                'assets/yesbank.png',
                                                height: size.height * 0.04,
                                                fit: BoxFit.contain,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: size.height * 0.02),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 3,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: cardNumbers
                                                          .map((e) => Padding(
                                                        padding: const EdgeInsets.only(bottom: 5),
                                                        child: Text(
                                                          e,
                                                          style: TextStyle(
                                                            color: Colors.white.withOpacity(0.8),
                                                            fontSize: size.width * 0.055,
                                                            fontFamily: 'Mechanismo',
                                                            fontWeight: FontWeight.w100,
                                                            fontFamilyFallback: const ['monospace'],
                                                            letterSpacing: 1.2,
                                                          ),
                                                        ),
                                                      ))
                                                          .toList(),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('expiry',
                                                            style: TextStyle(color: Colors.grey[600], fontSize: size.width * 0.04)),
                                                        Text(expiryDate,
                                                            style: TextStyle(color: Colors.white, fontSize: size.width * 0.045)),
                                                        SizedBox(height: size.height * 0.05),
                                                        Text('cvv',
                                                            style: TextStyle(color: Colors.grey[600], fontSize: size.width * 0.05)),
                                                        Obx(() => Row(
                                                          children: [
                                                            Row(
                                                              children: List.generate(3, (index) {
                                                                return Opacity(
                                                                  opacity: _isCvvVisible.value ? 1.0 : (1.0 - (index * 0.3)),
                                                                  child: Text(
                                                                    _isCvvVisible.value ? cvv[index] : '*',
                                                                    style: TextStyle(
                                                                      color: Colors.white,
                                                                      fontSize: size.width * 0.05,
                                                                      fontFamily: 'monospace',
                                                                    ),
                                                                  ),
                                                                );
                                                              }),
                                                            ),
                                                            const SizedBox(width: 8),
                                                            GestureDetector(
                                                              onTap: () => _isCvvVisible.value = !_isCvvVisible.value,
                                                              child: Icon(
                                                                _isCvvVisible.value ? Icons.visibility : Icons.visibility_off,
                                                                color: Colors.red,
                                                                size: size.width * 0.05,
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 10),
                                                child: Row(
                                                  children: [
                                                    const Icon(Icons.copy, color: Colors.red, size: 20),
                                                    const SizedBox(width: 5),
                                                    Text('copy details',
                                                        style: TextStyle(color: Colors.red, fontSize: size.width * 0.04)),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Positioned(
                                    right: 10,
                                    bottom: 10,
                                    child: SizedBox(
                                      height: size.width * 0.15,
                                      child: Image.asset(
                                        'assets/6.jpg',
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                  Obx(() => _isFrozen.value
                                      ? Positioned.fill(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        'assets/3.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                      : const SizedBox.shrink()),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.25,
                            child: GestureDetector(
                              onTap: () => _isFrozen.value = !_isFrozen.value,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Obx(() => Container(
                                    padding: EdgeInsets.all(size.width * 0.04),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: Colors.grey[800]!,
                                        width: 2.0,
                                      ),
                                      color: Colors.black,
                                    ),
                                    child: Icon(
                                      Icons.ac_unit,
                                      color: _isFrozen.value ? Colors.red : Colors.white,
                                      size: size.width * 0.08,
                                    ),
                                  )),
                                  const SizedBox(height: 5),
                                  Text(
                                    'freeze',
                                    style: TextStyle(
                                      color: _isFrozen.value? Colors.red: Colors.white,
                                      fontSize: size.width * 0.04,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),],
          ),
        ),
      ),
    );
  }
}