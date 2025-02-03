import 'package:airbnb_app/controller/message_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/message_model.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key});
  final List<String> messagetype = ['All', 'Travelling', 'Support'];
  final MessageController messageController = Get.put(MessageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search & Tune Icons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    child: Icon(Icons.search, size: 30, color: Colors.black),
                  ),
                  SizedBox(width: 20),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade300,
                    ),
                    child: Icon(Icons.tune, size: 30, color: Colors.black),
                  )
                ],
              ),
              SizedBox(height: 30),

              // Messages Heading
              Text(
                "Messages",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35,
                ),
              ),
              SizedBox(height: 20),

              // Message Type Tabs
              Obx(() => Row(
                children: List.generate(
                  messagetype.length,
                      (index) => GestureDetector(
                    onTap: () {
                      messageController.selectedindex.value = index;
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 22,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: messageController.selectedindex.value ==
                              index
                              ? Colors.black
                              : Colors.black12.withOpacity(0.04),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Text(
                          messagetype[index],
                          style: TextStyle(
                            color: messageController.selectedindex.value ==
                                index
                                ? Colors.white
                                : Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              )),
              const SizedBox(height: 10),
              ...messages.map((message) => _buildMessageItem(message)),
            ],
          ),
        ),
      ),
    );
    
  }
  Widget _buildMessageItem(Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 85,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(message.image),
                  ),
                ),
              ),
              Positioned(
                bottom: -10,
                right: -18,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(message.vendorImage),
                  backgroundColor: Colors.white,
                  radius: 25,
                ),
              ),
            ],
          ),
          const SizedBox(width: 25),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      message.name,
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                    Text(
                      message.date,
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                Text(
                  message.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.1,
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  message.duration,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    height: 1.4,
                    fontSize: 17,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
