import 'package:chat/controller/socketcontroller.dart';
import 'package:chat/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Conversation extends StatefulWidget {
  Conversation({super.key});

  @override
  State<Conversation> createState() => _ConversationState();
}

class _ConversationState extends State<Conversation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GetBuilder<SocketController>(
          builder: (controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                controller.userToText!.userFirstName,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text(controller.typing == '' ? controller.onlineStatus! : 'typing...' , style: TextStyle(
                fontSize: 12,
              ),)
            ],
          ),
        ),
      ),
      body: GetBuilder<SocketController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.only(right: 10 , left: 10 , bottom: 80 , top: 10),
          child: ListView.separated(
            reverse: true,
            itemCount: controller.messages.length,
            separatorBuilder: (context, index) {
              return const SizedBox(
                height: 5,
              );
            },
            itemBuilder: (context, index) {
              var message = controller.messages[index];
              return message.sender == sharedPreferences?.getInt('userid')
                  ? Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.only(left: 80),
                        constraints:
                            const BoxConstraints(maxWidth: double.infinity),
                        decoration: BoxDecoration(
                          color: Colors.indigo[800],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        child: Text(
                          message.content,
                          style: TextStyle(
                            color: Colors.white
                          ),
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 179, 179, 179),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10 ,vertical: 10),
                          child: Text(message.content , style: TextStyle(color: Colors.white),),
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
      bottomSheet: GetBuilder<SocketController>(
        builder: (controller) => Padding(
          padding: const EdgeInsets.only(bottom: 10, right: 7, left: 7),
          child: Card(
            color: Colors.indigo.withOpacity(0.1),
            child: Container(
              decoration: const BoxDecoration(
                
                  // boxShadow: [BoxShadow(blurRadius: 80, color: Colors.black)]
                  // 
                  ),
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller.messageController.value,
                      decoration:  InputDecoration(
                        fillColor: Colors.indigo.withOpacity(0.4),
                        border: InputBorder.none,
                        hintText: "Type your message...",
                      ),
                      onChanged: (value) {
                         if (controller.messageController.value.text == '') {
                          controller.changeUserToTextTypingValue({
                          'conversationid': controller.currentConvoId,
                          'sender': sharedPreferences?.getInt('userid'),
                        });
                          controller.update();
                        } else {
                           controller.isUserTyping({
                          'conversationid': controller.currentConvoId,
                          'sender': sharedPreferences?.getInt('userid'),
                        });
                        controller.update();
                        }
                        
                        
                      },
                      onSubmitted: (value) {
                        controller.changeUserToTextTypingValue({
                          'conversationid': controller.currentConvoId,
                          'sender': sharedPreferences?.getInt('userid'),
                        });
                        controller.sendMessage({
                          'sender': sharedPreferences?.getInt('userid'),
                          'conversationid': controller.currentConvoId,
                          'content': value
                        });
                        
                            controller.updateUserToTextChatList({
                          'conversationid': controller.currentConvoId,
                          'sender': sharedPreferences?.getInt('userid'),
                        });
            
                        controller.messageController.value.clear();
                      },
                    ),
                  ),
                  controller.messageController.value.text == ''
                      ? const SizedBox()
                      : IconButton(
                          icon: const Icon(Icons.send , color: Colors.indigo,),
                          onPressed: () {
                            // Send message when send button is pressed
                            
                            controller.changeUserToTextTypingValue({
                          'conversationid': controller.currentConvoId,
                          'sender': sharedPreferences?.getInt('userid'),
                        });
                            controller.sendMessage({
                              'sender': sharedPreferences?.getInt('userid'),
                              'conversationid': controller.currentConvoId,
                              'content': controller.messageController.value.text
                            });
                            controller.updateUserToTextChatList({
                          'conversationid': controller.currentConvoId,
                          'sender': sharedPreferences?.getInt('userid'),
                        });
                            controller.messageController.value.clear();
                            controller.update();
                          },
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
