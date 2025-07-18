import 'package:chat_app/CustomUI/OwnFileCard.dart';
import 'package:chat_app/CustomUI/OwnMessageCard.dart';
import 'package:chat_app/CustomUI/ReplyCard.dart';
import 'package:chat_app/CustomUI/ReplyFileCard.dart';
import 'package:chat_app/Model/MessageModel.dart';
import 'package:chat_app/Screens/CameraScreen.dart';
import 'package:chat_app/Screens/CameraView.dart';
import 'package:chat_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:chat_app/Model/ChatModel.dart';
import 'package:flutter_svg/svg.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class Individualpage extends StatefulWidget {
  const Individualpage(
      {super.key, required this.chatModel, required this.sourchat});

  final ChatModel chatModel;
  final ChatModel sourchat;

  @override
  State<Individualpage> createState() => _IndividualpageState();
}

class _IndividualpageState extends State<Individualpage> {
  bool show = false;
  bool sendButton = false;
  List<MessageModel> messages = []; // ✅ Store messages locally
  FocusNode focusNode = FocusNode(); // ✅ Fixed FocusScopeNode() to FocusNode()
  IO.Socket? socket;
  TextEditingController _controller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  

  ImagePicker _picker = ImagePicker();
  late XFile file;

 @override
void initState() {
    super.initState();
    connect();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        setState(() {
          show = false;
        });
      }
    });
  } 






  // ✅ Establish socket connection
  void connect() {
    if (widget.sourchat == null) {
      print("⚠ Error: sourchat is null! Cannot connect to socket.");
      return;
    }

    // ✅ Prevent multiple connections
    if (socket != null && socket!.connected) {
      print("⚠ Already connected. Skipping reconnection.");
      return;
    }

    socket = IO.io(
        "https://whatsapp-clone-foew.onrender.com",
        IO.OptionBuilder()
            .setTransports(["websocket"])
            .enableAutoConnect()
            .setReconnectionAttempts(5)
            .setReconnectionDelay(5000)
            .build());

    socket!.connect(); // ✅ Use `socket!` since it's now initialized

    socket!.onConnect((_) {
      print("✅ Connected with ID: ${socket!.id}");
      socket!.on("message", (data) {
        print(data);
        setMessage("destination", data["message"],data["path"]);
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      });

      if (widget.sourchat.id != null) {
        // ✅ Removed unnecessary null check
        print("🧠 Current sourchat ID: ${widget.sourchat.id}");
        String userId = widget.sourchat.id.toString(); // ✅ Convert to string
        socket!.emit("signin", userId); // ✅ Send only the string ID
        print("📤 Sent signin request with ID: $userId");
      } else {
        print("⚠ Warning: sourchat ID is null!");
      }
    });

    socket!.onDisconnect((_) => print("❌ Disconnected"));
    socket!.onConnectError((error) => print("⚠ Connection Error: \$error"));
    socket!.onError((error) => print("⚠ Socket Error: \$error"));
  }

  // ✅ Send message through socket
  void sendMessage(String message, int sourId, int targetId, String path) {
  setMessage("source", message, path); // Show on sender's chat

  if (socket != null && socket!.connected) {
    socket!.emit("message", {
      "message": message,
      "sourceId": sourId,
      "targetId": targetId,
      "path": path,
    });
    print("📩 Message sent: $message from $sourId to $targetId");
  } else {
    print("⚠ Error: Socket is not connected!");
  }
}


void setMessage(String type, String message, String path) {
  setState(() {
    messages.add(MessageModel(
      type: type,
      message: message,
      path: path,
      time: DateTime.now().toString().substring(10, 16),
    ));
  });
}

  // ✅ Store messages locally
 

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  
void onImageSend(String imagePath) async {
  print("Image sent: $imagePath");

  var request = http.MultipartRequest(
    'POST',
    Uri.parse("http://192.168.1.19:5000/routes/addimage"), // Ensure the URL is correct
  );

  // Make sure the field name matches the one used in Multer (in this case, 'img')
  request.files.add(
    await http.MultipartFile.fromPath(
      'img',  // field name must match `upload.single("img")`
      imagePath,
    ),
  );

  request.headers.addAll({
    'Content-Type': 'multipart/form-data',
    'Accept': 'application/json',
  });

  try {
    // Send the request and handle the response
    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print("Image uploaded successfully");
      // Handle the response if needed
    } else {
      print("Failed to upload image");
    }
  } catch (e) {
    print("Error uploading image: $e");
  }
}




  

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          "assets/whatsapp_Back.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.blueGrey,
          appBar: AppBar(
            titleSpacing: 0,
            leadingWidth: 70,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.arrow_back, size: 24),
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.blueGrey,
                    child: SvgPicture.asset(
                      widget.chatModel.isGroup
                          ? "assets/groups.svg"
                          : "assets/person.svg",
                      height: 37,
                      width: 37,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            title: InkWell(
              onTap: () {},
              child: Container(
                margin: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatModel.name,
                      style: const TextStyle(
                        fontSize: 18.5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      "last seen today at 12:05",
                      style: TextStyle(fontSize: 13),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              PopupMenuButton<String>(
                onSelected: (value) {
                  print(value);
                },
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: "View Contact",
                      child: Text("View Contact"),
                    ),
                    const PopupMenuItem(
                      value: "Media, links, and docs",
                      child: Text("Media, links, and docs"),
                    ),
                    const PopupMenuItem(
                      value: "WhatsApp Web",
                      child: Text("WhatsApp Web"),
                    ),
                    const PopupMenuItem(
                      value: "Search",
                      child: Text("Search"),
                    ),
                    const PopupMenuItem(
                      value: "Mute notification",
                      child: Text("Mute notification"),
                    ),
                    const PopupMenuItem(
                      value: "Wallpaper",
                      child: Text("Wallpaper"),
                    ),
                  ];
                },
              ),
            ],
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WillPopScope(
                child: Column(
                  children: [
                    Expanded(
                      // height: MediaQuery.of(context).size.height - 140,
                      child: ListView.builder(
                        shrinkWrap: true,
                        controller: _scrollController,
                        itemCount: messages.length + 1,
                        itemBuilder: (context, index) {
                          if (index == messages.length) {
                            return Container(
                              height: 70,
                            );
                          }
                          if (messages[index].type == "source") {
                            return OwnMessageCard(
  message: messages[index].message,
  time: messages[index].time, // ✅ added status
);
} else {
  return ReplyCard(
    message: messages[index].message,
    time: messages[index].time,
  );
}

                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width - 60,
                                    child: Card(
                                      margin: const EdgeInsets.only(
                                          left: 2, right: 2, bottom: 8),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: TextFormField(
                                        controller: _controller,
                                        focusNode: focusNode,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 1,
                                        onChanged: (value) {
                                          if (value.length > 0) {
                                            setState(() {
                                              sendButton = true;
                                            });
                                          } else {
                                            setState(() {
                                              sendButton = false;
                                            });
                                          }
                                        },
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Type a message",
                                          prefixIcon: IconButton(
                                            icon: const Icon(
                                              Icons.emoji_emotions,
                                            ),
                                            onPressed: () {
                                              focusNode.unfocus();
                                              focusNode.canRequestFocus = false;
                                              setState(() {
                                                show = !show;
                                              });
                                            },
                                          ),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.attach_file),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      context: context,
                                                      builder: (builder) =>
                                                          bottomsheet());
                                                },
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                    Navigator.push(context,MaterialPageRoute(builder: (builder)=>CameraScreen(cameras: cameras, onImageSend: (imagePath) => onImageSend(imagePath))));
                                                },
                                                icon: const Icon(
                                                    Icons.camera_alt),
                                              )
                                            ],
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(5),
                                        ),
                                      ),
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: 8,
                                    right: 5,
                                    left: 2,
                                  ),
                                  child: CircleAvatar(
                                    radius: 25,
                                    backgroundColor: const Color(0xFF128C7E),
                                    child: IconButton(
                                      onPressed: () {
                                        if (sendButton) {
                                          _scrollController.animateTo(
                                              _scrollController
                                                  .position.maxScrollExtent,
                                              duration:
                                                  Duration(milliseconds: 300),
                                              curve: Curves.easeOut);
                                          sendMessage(
                                            _controller.text,
                                            widget.sourchat.id,
                                            widget.chatModel.id,
                                            "",
                                          );
                                          _controller.clear();
                                          setState(() {
                                            sendButton = false;
                                          });
                                        }
                                      },
                                      icon: Icon(
                                        sendButton ? Icons.send : Icons.mic,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            // show?emojiSelect():Container(),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                onWillPop: () {
                  if (show) {
                    setState(() {
                      show = false;
                    });
                  } else {
                    Navigator.pop(context);
                  }
                  return Future.value(false);
                }),
          ),
        ),
      ],
    );
  }

  Widget bottomsheet() {
  return SizedBox(
    height: 278,
    width: MediaQuery.of(context).size.width,
    child: Card(
      margin: const EdgeInsets.all(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconcreation(
                  Icons.insert_drive_file,
                  Colors.indigo,
                  "Document",
                  () {},
                ),
                const SizedBox(
                  width: 40,
                ),
                iconcreation(
                  Icons.camera_alt,
                  Colors.pink,
                  "Camera",
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => CameraScreen(cameras: cameras,
                        onImageSend: onImageSend,),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  width: 40,
                ),
                iconcreation(
                  Icons.insert_photo,
                  Colors.purple,
                  "Gallery",
                  () async {
                    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      file = pickedFile;
                      // Handle the picked file here
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (builder) => CameraViewPage(
                          path: file.path,
                          onImageSend: onImageSend,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                iconcreation(
                  Icons.headset,
                  Colors.orange,
                  "Audio",
                  () {},
                ),
                const SizedBox(
                  width: 40,
                ),
                iconcreation(
                  Icons.location_pin,
                  Colors.teal,
                  "Location",
                  () {},
                ),
                const SizedBox(
                  width: 40,
                ),
                iconcreation(
                  Icons.person,
                  Colors.blue,
                  "Contact",
                  () {},
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}


Widget iconcreation(IconData icon, Color color, String text, Function() onTap) {
  return InkWell(
    onTap: onTap,
    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(
            icon,
            size: 29,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 12,
          ),
        ),
      ],
    ),
  );
}

  // Widget emojiSelect() {
  //   return EmojiPicker(
  //     onEmojiSelected: (Category? category, Emoji emoji) {
  //       print(emoji.emoji);
  //       setState(() {
  //         controller.text = controller.text + emoji.emoji;
  //       });
  //     },
  //     config: Config(
  //       columns: 7,
  //       emojiSizeMax: 32, // Set this to your preferred size
  //       verticalSpacing: 0,
  //       horizontalSpacing: 0,
  //       gridPadding: EdgeInsets.zero,
  //       bgColor: const Color(0xFFF2F2F2),
  //     ),
  //   );
  // }
}
