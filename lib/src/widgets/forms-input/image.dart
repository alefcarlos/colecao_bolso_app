import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:colecao_bolso_app/application/shared/shared.dart';

class ImageInput extends StatefulWidget {
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File _imageFlie;

  void _getImage(BuildContext context, ImageSource source) async {
    var result = await ImagePicker.pickImage(source: source, maxWidth: 400.0);
    var cropeed = await cropImage(path: result.path, title: 'Ajustar imagem');

    setState(() {
      _imageFlie = cropeed;
    });

    Navigator.pop(context);
  }

  void _openImagePicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 200.0,
            padding: EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                ListTile(
                  leading: Icon(
                    Icons.camera_roll,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Galeria',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    'Permite escolher uma foto já existente em sua galeria.',
                  ),
                  onTap: () => _getImage(context, ImageSource.gallery),
                ),
                Divider(),
                ListTile(
                  leading: Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Câmera',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  subtitle: Text(
                    'Permite utilizar sua câmera para tirar uma nova foto.',
                  ),
                  onTap: () => _getImage(context, ImageSource.camera),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var buttonColor = Theme.of(context).primaryColor;
    return Container(
      child: Column(
        children: <Widget>[
          OutlineButton(
            borderSide: BorderSide(color: buttonColor, width: 2.0),
            onPressed: () => _openImagePicker(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.camera_alt,
                  color: buttonColor,
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text(
                  'Adicionar imagem',
                  style: TextStyle(color: buttonColor),
                )
              ],
            ),
          ),
          SizedBox(height: 10.0),
          _imageFlie == null
              ? Text('Selecione uma imagem para um preview.')
              : Image.file(_imageFlie,
                  fit: BoxFit.cover,
                  height: 300.0,
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.topCenter),
        ],
      ),
    );
  }
}
