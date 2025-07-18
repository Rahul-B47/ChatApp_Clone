class ChatModel {
  String name;
  String icon;
  bool isGroup;
  String time;
  String currentMessage;
  String status;
  bool select=false;
  int id;

  // Constructor with default values
  ChatModel({
    this.name = '',
    this.icon = 'default_icon.png', // Default value for icon
    this.isGroup = false,          // Default value for isGroup
    this.time = '',
    this.currentMessage = '',      // Default value for currentMessage
    this.status = '',
    this.select=false,
    this.id=0,
  });
}
