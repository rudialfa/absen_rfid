import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/colors.dart';
import 'spaces.dart';

class CustomImagePicker extends StatefulWidget {
  final String label;
  final Function(String? imagePath) onChanged;
  final String? imageUrl;
  final bool showLabel;
  final double borderRadius;

  const CustomImagePicker({
    super.key,
    required this.label,
    required this.onChanged,
    this.imageUrl,
    this.showLabel = true,
    this.borderRadius = 8.0,
  });

  @override
  State<CustomImagePicker> createState() => _CustomImagePickerState();
}

class _CustomImagePickerState extends State<CustomImagePicker> {
  XFile? _image;

  Future<void> _choosePhoto() async {
    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (!mounted || image == null) return;

    setState(() {
      _image = image;
    });

    widget.onChanged(image.path);
  }

  void _removePhoto() {
    setState(() {
      _image = null;
    });

    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel) ...[
          Text(
            widget.label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.black,
            ),
          ),
          const SpaceHeight(12),
        ],

        InkWell(
          onTap: _choosePhoto,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              border: Border.all(color: AppColors.stroke),
            ),
            child: Center(
              child: _image != null
                  ? Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          width: 65,
                          height: 65,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius,
                            ),
                            border: Border.all(color: AppColors.stroke),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius,
                            ),
                            child: Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: _removePhoto,
                          child: const CircleAvatar(
                            radius: 11,
                            backgroundColor: AppColors.error,
                            child: Icon(
                              Icons.close,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : widget.imageUrl != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(widget.borderRadius),
                      child: CachedNetworkImage(
                        imageUrl: widget.imageUrl!,
                        height: 65,
                        width: 65,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const SizedBox(
                          height: 65,
                          width: 65,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) =>
                            const _ImagePlaceholder(),
                      ),
                    )
                  : const _ImagePlaceholder(),
            ),
          ),
        ),
      ],
    );
  }
}

class _ImagePlaceholder extends StatelessWidget {
  const _ImagePlaceholder();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 65,
      height: 65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_photo_alternate_outlined,
            size: 32,
            color: AppColors.gray,
          ),
          SizedBox(height: 4),
          Text('Upload', style: TextStyle(fontSize: 10, color: AppColors.gray)),
        ],
      ),
    );
  }
}
