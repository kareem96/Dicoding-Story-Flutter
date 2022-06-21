import 'dart:io';

import 'package:dicoding_story_flutter/src/domain/domain.dart';
import 'package:dicoding_story_flutter/src/presentation/presentations.dart';
import 'package:dicoding_story_flutter/src/utils/utils.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key}) : super(key: key);

  @override
  State<UploadPage> createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  final _descriptionController = TextEditingController();
  final _fnDescription = FocusNode();
  final _keyForm = GlobalKey<FormState>();
  File? image;


  Future pickImageCamera() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }

  Future pickImageGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print("Failed to pick image: $e");
    }
  }



  @override
  Widget build(BuildContext context) {
    return Parent(
      appBar: MyAppBar().call(

      ),
      child: BlocListener<UploadCubit, UploadState>(
        listener: (_, state){
          log.d("uploadState $state");
          switch (state.status){
            case UploadStatus.loading:
              context.show();
              break;
            case UploadStatus.success:
              context.dismiss();
              context.back();
              break;
            case UploadStatus.failure:
              context.dismiss();
              state.message.toString().toToastError();
              break;
          }
        },
        child: Parent(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(Dimens.space24),
              child: AutofillGroup(
                child: Form(
                  key: _keyForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      image != null ? Image.file(image!, height: 250, width: 350,) : const Icon(Icons.image, size: 120,),

                      TextForm(
                        controller: _descriptionController,
                        maxLine: null,
                        prefixIcon: const Icon(Icons.description),
                        minLine: 3,
                        hint: "Description",
                        hintText: "Type something..",
                      ),
                      const SpacerVertical(),
                      PickImage(
                          title: "Pick Image Gallery",
                          onClick: (){
                            pickImageGallery();
                          },
                      ),
                      const SpacerVertical(),
                      PickImage(
                          title: "Pick Image Camera",
                          onClick: (){
                            pickImageCamera();
                          }
                      ),
                      Button(
                          title: "Post Story",
                          onPressed: (){
                            context.read<UploadCubit>().upload(UploadParams(
                              description: _descriptionController.text,
                              photo: image
                            ));
                          }
                      ),Button(
                          title: "back",
                          onPressed: (){
                            context.goTo(AppRoute.mainScreen);
                          }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
