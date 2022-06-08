import 'dart:io';
import 'dart:typed_data';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:cosmere_us/data/bloc/book_bloc.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import 'package:cosmere_us/components/book_list.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // this variable determnines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;
  // scroll controller
  late ScrollController _scrollController;

  late TutorialCoachMark tutorialCoachMark;
  List<TargetFocus> targets = [];

  GlobalKey key = GlobalKey();
  final GlobalKey _key1 = GlobalKey();
  final GlobalKey _key2 = GlobalKey();
  final GlobalKey _key3 = GlobalKey();

  @override
  void initState() {
    rootBundle.load('assets/images/compartir.png').then((data) {
      setState(() {
        imageData = data;
      });
    });
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });
    initTargets();
    tutorial();
    super.initState();
  }

  void tutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool('tutorial') == null) {
      WidgetsBinding.instance!.addPostFrameCallback(_layout);
    }
  }

  void _layout(_) {
    Future.delayed(const Duration(milliseconds: 100));
    showTutorial();
  }

  void showTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    tutorialCoachMark = TutorialCoachMark(
      context,
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "SKIP",
      paddingFocus: 10,
      opacityShadow: 0.8,
      onFinish: () {
        prefs.setBool('tutorial', true);
        debugPrint("finish");
      },
      onClickTarget: (target) {
        debugPrint('onClickTarget: $target');
      },
      onSkip: () {
        prefs.setBool('tutorial', true);
        debugPrint("skip");
      },
      onClickOverlay: (target) {
        debugPrint('onClickOverlay: $target');
      },
    )..show();
  }

  void initTargets() {
    targets.add(
      TargetFocus(
        identify: "Target 0",
        keyTarget: _key1,
        enableOverlayTab: true,
        contents: [
          TargetContent(
              align: ContentAlign.bottom,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    "STORE YOUR PROGRESS",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30.0),
                  ),
                  Text(
                    "ALMACENA TU PROGRESO",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 20.0),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0),
                    child: Text(
                      "Access the description of each book, mark the completed ones and save your progress.",
                      style: TextStyle(color: Colors.white, fontSize: 15.0),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Text(
                    "Accede a la descripción de cada libro, marca los completados y guarda tu progreso.",
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                    textAlign: TextAlign.justify,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: SizedBox(
                        width: 50,
                        child: Image(
                            image: AssetImage('assets/images/guardado.png'))),
                  )
                ],
              ))
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: "Target 1",
        keyTarget: _key2,
        //color: Colors.red,
        contents: [
          TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  "COSMERE TIME LINE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30.0),
                ),
                Text(
                  "LÍNEA TEMPORAL DEL COSMERE",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 20.0),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Text(
                    "Follow the lines for a reading according to the recommended order. However, you can start with 'The Final Empire' or 'Warbreaker'.",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Text(
                  "Sigue las líneas para una lectura de acuerdo al orden recomendado. Sin embargo, se puede comenzar por 'El imperio final' o 'El aliento de los dioses'.",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          )
        ],
        shape: ShapeLightFocus.RRect,
        enableOverlayTab: true,
        radius: 5,
      ),
    );
    targets.add(TargetFocus(
      identify: "Target 2",
      keyTarget: _key3,
      enableOverlayTab: true,
      contents: [
        TargetContent(
            align: ContentAlign.top,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 40),
                  child: SizedBox(
                      width: 150,
                      child: Image(
                          image: AssetImage('assets/images/Arcanum.png'))),
                ),
                Text(
                  "UNBOUNDED ARCANUM",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: Text(
                    "ARCANUM ILIMITADO",
                    style: TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                ),
              ],
            )),
        TargetContent(
            align: ContentAlign.bottom,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "«Arcanum Unlimited» is a short story anthology that compiles the Cosmere-related stories that Brandon Sanderson has published over the years.\nAlthough some are stand-alone stories that can be enjoyed on their own, others require you to have previously read some of the Cosmere novels. Cosmere. Read them following the white lines.",
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                    textAlign: TextAlign.justify,
                  ),
                ),
                Text(
                  "«Arcanum Ilimitado» es una antología de relatos que recopila las historias relacionadas con el Cosmere que Brandon Sanderson ha publicado a lo largo de los años.\nAunque algunos son relatos independientes que se pueden disfrutar por separado, otras requieren haber leído previamente algunas novelas del Cosmere. Leelos siguiendo las líneas blancas.",
                  style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  textAlign: TextAlign.justify,
                ),
              ],
            ))
      ],
      shape: ShapeLightFocus.Circle,
    ));
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(seconds: 1), curve: Curves.linear);
  }

  late ByteData imageData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        backgroundColor: const Color.fromARGB(255, 0, 18, 36),
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: const [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Image(image: AssetImage('assets/images/drawer.png')),
            ),
            Image(image: AssetImage('assets/images/info_ing.png')),
            Padding(
              padding: EdgeInsets.only(top: 50),
              child: SizedBox(
                  height: 100,
                  child: Image(
                      image:
                          AssetImage('assets/images/soludev_logo_mono.png'))),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<BookBloc, BookState>(
        builder: (context, state) {
          if (state is BookLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BookLoadedState) {
            return SingleChildScrollView(
                controller: _scrollController,
                child: Stack(
                  children: [
                    Column(
                      children: const [
                        Image(
                          image: AssetImage('assets/images/imagen_fondo.png'),
                          fit: BoxFit.contain,
                        ),
                        Image(
                          image: AssetImage('assets/images/imagen_fondo2.png'),
                          fit: BoxFit.contain,
                        ),
                      ],
                    ),
                    // fechas amarillas
                    Positioned(
                        key: _key2,
                        top: 247,
                        left: 257,
                        child: const SizedBox(width: 20, height: 20)),
                    Positioned(
                        key: _key3,
                        top: 445,
                        left: 195,
                        child: const SizedBox(
                          width: 20,
                          height: 20,
                        )),
                    bookCircle(0, 20,
                        top: 70, left: 170, color: Colors.amber, key: _key1),
                    bookCircle(1, 15.0, top: 190, left: -10),
                    bookCircle(2, 15.0, top: 158, right: 3),
                    bookCircle(3, 15.0, top: 286, left: 65),
                    bookCircle(4, 20.0,
                        top: 375,
                        right: 60,
                        color: const Color.fromARGB(255, 243, 166, 78)),
                    bookCircle(5, 20.0,
                        top: 483,
                        left: 19,
                        color: const Color.fromARGB(255, 156, 95, 14)),
                    bookCircle(6, 15.0, top: 564, right: 22),
                    bookCircle(7, 20.0,
                        top: 690,
                        right: 160,
                        color: const Color.fromARGB(255, 123, 144, 236)),
                    bookCircle(8, 20.0,
                        top: 868,
                        right: -12,
                        color: const Color.fromARGB(255, 59, 211, 127)),
                    bookCircle(9, 20.0,
                        top: 905,
                        right: 185,
                        color: const Color.fromARGB(255, 59, 211, 127)),
                    bookCircle(10, 20.0,
                        top: 983,
                        left: 1,
                        color: const Color.fromARGB(255, 151, 103, 12)),
                    bookCircle(11, 15.0, top: 1071, right: 8),
                    //Segundo fondo---------------------------------------------------------
                    bookCircle(12, 20.0,
                        bottom: 1000,
                        left: 45,
                        color: const Color.fromARGB(255, 42, 228, 228)),
                    bookCircle(13, 20.0,
                        bottom: 860,
                        right: 35,
                        color: const Color.fromARGB(255, 233, 182, 14)),
                    bookCircle(14, 20.0,
                        bottom: 750,
                        left: 30,
                        color: const Color.fromARGB(255, 207, 188, 18)),
                    bookCircle(15, 15.0, bottom: 683, left: 179),
                    bookCircle(16, 20.0,
                        bottom: 567,
                        left: 35,
                        color: const Color.fromARGB(255, 155, 121, 12)),
                    bookCircle(17, 20.0,
                        bottom: 565,
                        right: 41,
                        color: const Color.fromARGB(255, 18, 82, 219)),
                    bookCircle(18, 20.0,
                        bottom: 405,
                        right: 153,
                        color: const Color.fromARGB(255, 48, 107, 235)),
                    bookCircle(19, 15.0, bottom: 285, left: 1),
                    bookCircle(20, 20.0, bottom: 150, right: 37),
                    bookCircle(21, 15.0, bottom: 70, left: 35),
                    bookCircle(22, 20.0, bottom: 215, left: 145),
                    //Soludev
                    Positioned(
                      bottom: 20,
                      left: 145,
                      child: Row(
                        children: [
                          const Icon(
                            Icons.developer_mode_rounded,
                            color: Colors.white,
                            size: 25,
                          ),
                          const Text(
                            "Powered by: ",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                          SizedBox(
                            width: 70,
                            height: 70,
                            child: GestureDetector(
                              onTap: () async {
                                const url = "https://soludevs.web.app/";
                                if (await canLaunch(url)) {
                                  await launch(url);
                                } else {
                                  throw "Could not launch $url";
                                }
                              },
                              child: const Image(
                                  image: AssetImage(
                                      'assets/images/soludev_logo_mono.png')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ));
          }
          if (state is BookErrorState) {
            return Center(
              child: Text(state.error.toString()),
            );
          }
          return Container();
        },
      ),
      floatingActionButton: _showBackToTopButton == false
          ? null
          : FloatingActionButton(
              backgroundColor: Colors.blueGrey[800],
              onPressed: _scrollToTop,
              child: const Icon(Icons.arrow_upward),
            ),
    );
  }

  Widget getBook(BuildContext context, int index) {
    return StatefulBuilder(
      builder: (context, setState) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Stack(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 45 + 20, right: 20, bottom: 20),
              margin: const EdgeInsets.only(top: 45),
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(20),
                  // ignore: prefer_const_literals_to_create_immutables
                  boxShadow: [
                    const BoxShadow(
                        color: Color.fromARGB(255, 133, 125, 125),
                        offset: Offset(0, 10),
                        blurRadius: 10),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(height: 50),
                  FittedBox(
                    fit: BoxFit.cover,
                    child: Text(
                      book[index].title!,
                      style: GoogleFonts.trispace(
                        textStyle: const TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            letterSpacing: .5),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(book[index].description!,
                        style: GoogleFonts.trispace(
                          textStyle: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              letterSpacing: .5),
                        ),
                        textAlign: TextAlign.justify),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  if (!book[index].pending!)
                    Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.white),
                        child: bookState(setState, index, book[index].title!)),
                  Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_forward_ios))),
                ],
              ),
            ),
            Positioned(
              left: 70,
              right: 70,
              child: SizedBox(
                width: 20,
                height: 140,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(45)),
                  child: Image(
                    image: AssetImage('assets/images/${book[index].image}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bookState(StateSetter setState, int ind, String title) {
    return Column(
      children: [
        CheckboxListTile(
            checkColor: Colors.black,
            activeColor: Colors.white,
            value: book[ind].status,
            title: Text(
              book[ind].status! ? "Completed" : "Pending",
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
            onChanged: (value) {
              //book[ind].status = value;
              BlocProvider.of<BookBloc>(context).add(
                ChangeStatusBookEvent(value!, ind),
              );
              setState(() {});
              //setBookPreferences();
            }),
        book[ind].status!
            ? Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Rate: ",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      DropdownButton<String>(
                        value: book[ind].rate,
                        dropdownColor: Colors.black87,
                        borderRadius: BorderRadius.circular(10),
                        icon: const Icon(Icons.star, color: Colors.white),
                        elevation: 16,
                        style: const TextStyle(color: Colors.white),
                        underline: Container(
                          //height: 2,
                          color: Colors.grey[200],
                        ),
                        onChanged: (String? newValue) {
                          BlocProvider.of<BookBloc>(context).add(
                            ChangeRateBookEvent(newValue!, ind),
                          );
                          setState(() {});
                        },
                        items: <String>[
                          '0',
                          '1',
                          '2',
                          '3',
                          '4',
                          '5',
                          '6',
                          '7',
                          '8',
                          '9',
                          '10'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text("       $value ",
                                style: const TextStyle(
                                    fontSize: 20, color: Colors.white)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  ElevatedButton(
                      style:
                          ElevatedButton.styleFrom(primary: Colors.transparent),
                      onPressed: () async {
                        Uint8List _imagefile = imageData.buffer.asUint8List();
                        //guardar el archivo en el directorio principal de la aplicacion
                        MimeType type = MimeType.PNG;
                        String path = await FileSaver.instance.saveFile(
                            "image-share", _imagefile, "png",
                            mimeType: type);
                        //se busca la imagen guardada y se crea un tipo File necesario para poder subir
                        final file = File(path);
                        GallerySaver.saveImage(file.path);
                        await Share.shareFiles([(file.path)],
                            text:
                                'Completed "${book[ind].title}". Rate: ${book[ind].rate} ☆. COSMERE, find us in the Play Store! https://play.google.com/store/apps/details?id=com.soludev.cosmere');
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text("Share", style: TextStyle(fontSize: 20)),
                          SizedBox(width: 10),
                          Icon(Icons.share),
                        ],
                      )),
                ],
              )
            : Container(),
      ],
    );
  }

  Widget bookCircle(
    int index,
    double radius, {
    GlobalKey<State<StatefulWidget>>? key,
    double? top,
    double? left,
    double? right,
    double? bottom,
    Color? color,
  }) {
    return Positioned(
      key: key,
      top: top,
      left: left,
      right: right,
      bottom: bottom,
      child: AvatarGlow(
        glowColor: (color == null) ? Colors.white : color,
        endRadius: 60.0,
        child: Material(
          // Replace this child with your own
          elevation: 8.0,
          shape: const CircleBorder(),
          child: GestureDetector(
            onTap: () {
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return getBook(context, index);
                  });
            },
            child: book[index].pending!
                ? CircleAvatar(
                    child:
                        const Icon(Icons.timelapse_sharp, color: Colors.white),
                    backgroundColor: Colors.orange[300],
                    radius: radius,
                  )
                : CircleAvatar(
                    child: book[index].status!
                        ? const Icon(Icons.check, color: Colors.white)
                        : null,
                    backgroundColor: book[index].status!
                        ? Colors.green[300]
                        : Colors.grey[100],
                    radius: radius,
                  ),
          ),
        ),
      ),
    );
  }
}
