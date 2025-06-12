import 'package:flutter/material.dart';

class ImageSliderDialog extends StatefulWidget
{
  final List<String> imagePaths;
  final int initialIndex;

  const ImageSliderDialog({
    super.key,
    required this.imagePaths,
    required this.initialIndex,
  });

  @override
  State<StatefulWidget> createState()=> _ImageSliderDialogState();
}

class _ImageSliderDialogState extends State<ImageSliderDialog>
{
  late PageController _pageController;

  @override
  void initState()
  {
    super.initState();
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: widget.imagePaths.length,
            itemBuilder: (context, index) {
              return InteractiveViewer(
                child: Image.asset(
                  "assets/event_pictures/${widget.imagePaths[index]}",
                  fit: BoxFit.contain,
                ),
              );
            },
          ),
          Positioned(
            top: 40,
            right: 20,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )
        ],
      ),
    );
  }
}