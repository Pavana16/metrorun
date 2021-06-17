import 'package:flutter/material.dart';
import 'translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
class ProfilePreview extends StatefulWidget {
  @override
  _ProfilePreviewState createState() => _ProfilePreviewState();
}

class _ProfilePreviewState extends State<ProfilePreview> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 100, height: 100),
              child: ElevatedButton(
                child: Text(
                  LocaleKeys.View_Profile.tr(),
                  style: TextStyle(fontSize: 18, color: Colors.green[900]),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/profilepage');
                },
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    side: BorderSide(color: Colors.green.shade200, width: 3.0),
                    primary: Colors.white),
              ),
            ),
            SizedBox(height: 50.0),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: 100, height: 100),
              child: ElevatedButton(
                child: Text(
                  LocaleKeys.View_Rides.tr(),
                  style: TextStyle(fontSize: 18, color: Colors.green[900]),
                  textAlign: TextAlign.center,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed('/ridespage');
                },
                style: ElevatedButton.styleFrom(
                    shape: CircleBorder(),
                    side: BorderSide(color: Colors.green.shade200, width: 3.0),
                    primary: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
