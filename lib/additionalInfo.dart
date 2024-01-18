import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget{
  final IconData icon;
  final String label;
  final String value;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  }
  );

  @override 
  Widget build(BuildContext context) {
    return  Card(
             elevation: 10,
             child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(80),
                      ),
                      child: Column(
                        children: [
                           Icon(
                           icon,
                              size: 64),
                          const SizedBox(height: 16),
                          Text(
                               label,
                               style :const TextStyle(
                                         fontSize: 8,
                                       ),
                                    ),
                          const SizedBox(height: 18),      
                          Text(
                              value,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                        ],
                      ),
                    ),
                  );
  }
}