import 'package:flutter/material.dart';

class HourlyForcastItem extends StatelessWidget{
  final String time;
  final IconData icon;
  final String temperature;
  const HourlyForcastItem({
    super.key,
    required this.time,
    required this.icon,
    required this.temperature,
    });

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
                          Text(
                               time,
                               style :const TextStyle(
                                         fontSize: 18,
                                         fontWeight:FontWeight.bold,
                                       ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                    ),
                          const SizedBox(height: 8),
                                      Icon(
                           icon,
                              size: 64),
                          const SizedBox(height: 8),
                          Text(
                              temperature,
                            style: const TextStyle(fontSize: 10),
                            ),
                        ],
                      ),
                    ),
                  );
  }
}