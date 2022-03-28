import 'package:face_graph_api/user.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: const MyHomePage(title: 'OrderGO'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  Widget post(String text, int index) {
    return SizedBox(
      height: 200,
      child: Card(
          elevation: 20,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 1),
              Center(child: Text(text, style: TextStyle(fontSize: 20))),
              Spacer(flex: 1),
              IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  usr.delete(index);
                },
              )
            ],
          )),
    );
  }

  late User usr;
  @override
  void initState() {
    super.initState();
    usr = User(
        "EAAPtOol2mTYBAEbZBrCRZB3y7S2heWSEanyZAkRXvvm4deDkFtZAAFZBUjJ7MjknQrotkVK4tWsKc1ye3zwTMgQZBrA0ZAwG6xysaksLmOw3MeIILWs9JFQZB2j8fsihFCKsuD332O4zbtGKKg7GtQnU62RhoAVhWRfV5nyXuBWhMwCVjZCfeDVUAoM7nodxXx00QUTGxjL8di5YJe5aCjhHJI4pbCRzef9MZD",
        "1105260600269110",
        "5052aba243b433a9131405ce2b2adeca",
        this);
  }

  void set_message() {
    late BuildContext _contextdailog1;
    TextEditingController myController = TextEditingController();
    FloatingActionButton button = FloatingActionButton(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Image.asset("assets/images/GO.png", fit: BoxFit.fill),
      ),
      backgroundColor: Colors.grey.shade700,
      onPressed: () {
        usr.set_post(myController.text);
        Navigator.of(_contextdailog1).pop();
      },
    );
    Container veiw = Container(
      child: Center(
        child: TextField(
            controller: myController,
            expands: true,
            minLines: null,
            maxLines: null,
            textAlign: TextAlign.center,
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder())),
      ),
    );
    AlertDialog alert = AlertDialog(
      content: veiw,
      actions: [button],
      actionsAlignment: MainAxisAlignment.center,
    );
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        _contextdailog1 = dialogContext;
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.title),
          leading: Image.asset("assets/images/logo.png")),
      body: Center(
          child: ListView.builder(
        padding: EdgeInsets.all(5),
        itemCount: usr.posts.length,
        itemBuilder: (context, index) {
          return post(usr.posts[index]["message"], index);
        },
      )),
      floatingActionButton: FloatingActionButton(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset("assets/images/GO.png", fit: BoxFit.fill),
        ),
        backgroundColor: Colors.grey.shade700,
        onPressed: () {
          set_message();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
