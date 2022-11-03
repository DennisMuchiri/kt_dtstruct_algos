import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loyaltyapp/utils/ui/pgbison_app_theme.dart';

class DashBoardClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var roundnessFactor = 50.0;

    var path = Path();

    path.moveTo(0, size.height * 0.33);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, roundnessFactor * 2);
    path.quadraticBezierTo(size.width - 10, roundnessFactor,
        size.width - roundnessFactor * 1.5, roundnessFactor * 1.5);
    path.lineTo(
        roundnessFactor * 0.6, size.height * 0.33 - roundnessFactor * 0.3);
    path.quadraticBezierTo(
        0, size.height * 0.33, 0, size.height * 0.33 + roundnessFactor);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DashBoard2Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //var roundnessFactor = 50.0;
    var roundnessFactor = 20.0;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height - roundnessFactor);
    path.quadraticBezierTo(size.width, size.height - roundnessFactor,
        size.width, size.height - (roundnessFactor + roundnessFactor));
    path.lineTo(size.width, roundnessFactor);
    path.quadraticBezierTo(size.width, 0, size.width - roundnessFactor, 0);
    path.lineTo(roundnessFactor, 0);

    path.quadraticBezierTo(0, 0, 0, roundnessFactor);
    /*path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width/2, size.height/2);
    path.quadraticBezierTo(
        size.width / 2, size.height - 40, size.width, size.height);*/

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DashBoard2Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var roundnessFactor = 20.0;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height - roundnessFactor);
    path.quadraticBezierTo(size.width, size.height - roundnessFactor,
        size.width, size.height - (roundnessFactor + roundnessFactor));
    path.lineTo(size.width, roundnessFactor);
    path.quadraticBezierTo(size.width, 0, size.width - roundnessFactor, 0);
    path.lineTo(roundnessFactor, 0);

    path.quadraticBezierTo(0, 0, 0, roundnessFactor);
    canvas.drawShadow(
        path, PGBisonAppTheme.pg_dark_grey.withOpacity(0.5), 10.0, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class DashBoard3Clipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    //var roundnessFactor = 50.0;
    var roundnessFactor = 20.0;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, roundnessFactor);
    path.quadraticBezierTo(size.width, 0, size.width - roundnessFactor, 0);
    path.lineTo(roundnessFactor, roundnessFactor);

    path.quadraticBezierTo(
        0, roundnessFactor, 0, roundnessFactor + roundnessFactor);

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}

class DashBoard3Painter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var roundnessFactor = 20.0;
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height - roundnessFactor);
    path.quadraticBezierTo(0, size.height, roundnessFactor, size.height);
    path.lineTo(size.width - roundnessFactor, size.height);
    path.quadraticBezierTo(
        size.width, size.height, size.width, size.height - roundnessFactor);
    path.lineTo(size.width, roundnessFactor);
    path.quadraticBezierTo(size.width, 0, size.width - roundnessFactor, 0);
    path.lineTo(roundnessFactor, roundnessFactor);

    path.quadraticBezierTo(
        0, roundnessFactor, 0, roundnessFactor + roundnessFactor);
    canvas.drawShadow(
        path, PGBisonAppTheme.pg_dark_grey.withOpacity(0.5), 10.0, false);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
