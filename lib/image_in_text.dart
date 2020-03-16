import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_to_path_maker/text_to_path_maker.dart' as pm;

pm.PMFont font;

FutureOr init(String pathToTTF, {bool isAsset = false}) async {
  if (isAsset)
    font = pm.PMFontReader().parseTTFAsset(await rootBundle.load(pathToTTF));
  else {
    font = await pm.PMFontReader().parseTTF(pathToTTF);
  }
}

class ImageInText extends StatelessWidget {
  final String text;
  final ImageProvider image;
  final BoxFit boxFit;
  const ImageInText({Key key,@required this.text,@required this.image,this.boxFit = BoxFit.cover})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    assert(font != null, "Font is null, did you forget to call init");
    assert(text!=null, "Text Can't Be Null");
    return ClipPath(
      clipper: _TextInImageClipper(text),
      child: Image(
        image: image,
        fit: boxFit,
      ),
    );
  }
}

class _TextInImageClipper extends CustomClipper<Path> {
  final String text;
  _TextInImageClipper(this.text);
  @override
  Path getClip(Size size) {
    final list = text.split("");
    final width = (size.width / text.length);
    Path path = Path();
    for (int i = 0; i < text.length; i++) {
      path.addPath(
          pathForCharacter(
              Size.square(width),
              list[i]),
          Offset(width * i, (size.height-width)/2));
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }

  Path pathForCharacter(Size size, String character) {
    final codeUnit = character.codeUnitAt(0);
    bool small = false;
    if(codeUnit>= 'a'.codeUnitAt(0) && codeUnit<= 'z'.codeUnitAt(0))
      small = true;
    Matrix4 matrix4;
    Path pathForText = font.generatePathForCharacter(character.codeUnits[0]);
    matrix4 = Matrix4.identity();
    matrix4.rotateX(pi);
    pathForText = pathForText.transform(matrix4.storage);
    final bounds = pathForText.getBounds();
    matrix4 = Matrix4.identity();
    matrix4.translate(-bounds.left, -bounds.top);
    pathForText = pathForText.transform(matrix4.storage);
    matrix4 = Matrix4.identity();
    double scale = min(size.width / bounds.width, size.height / bounds.height);
    matrix4.scale(scale*(small?0.75:1),scale*(small?0.75:1));
    pathForText = pathForText.transform(matrix4.storage);
    matrix4 = Matrix4.identity();
    matrix4.translate((size.width-pathForText.getBounds().width)/2, size.height-pathForText.getBounds().height);
    pathForText = pathForText.transform(matrix4.storage);
    return pathForText;
  }
}
