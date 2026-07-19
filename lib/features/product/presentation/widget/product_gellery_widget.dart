import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../../common/design/src/theme/assets.gen.dart';
import '../../../../common/design/src/widgets/cach_network_image.dart';
import '../../../../common/extensions/src/context_extensions.dart';
import '../../../../common/helper/src/locale_keys.dart';


enum GalleryType {
  image,
  video,
  defaultImage,
}


class GalleryItem {
  final GalleryType type;
  final String? value;


  const GalleryItem({
    required this.type,
    this.value,
  });
}



class ProductGalleryWidget extends StatefulWidget {

  final List<String> gallery;
  final String? video;
  final bool showBackButton;
  final bool isFromDecktop;
  final int productId;


  const ProductGalleryWidget({
    super.key,
    required this.gallery,
    required this.productId,
    this.video,
    this.showBackButton = true,
    this.isFromDecktop = false,
  });


  @override
  State<ProductGalleryWidget> createState() =>
      _ProductGalleryWidgetState();
}



class _ProductGalleryWidgetState
    extends State<ProductGalleryWidget> {


  late final PageController _pageController;
  late final ValueNotifier<int> currentPage;


  late final List<GalleryItem> items;



  @override
  void initState() {
    super.initState();

    _pageController = PageController();
    currentPage = ValueNotifier(0);

    items = _buildItems();
  }



  List<GalleryItem> _buildItems() {

    final result = <GalleryItem>[];


    // الفيديو دائما أول عنصر
    if (widget.video?.trim().isNotEmpty == true) {

      result.add(
        GalleryItem(
          type: GalleryType.video,
          value: widget.video,
        ),
      );
    }


    // بعدها الصور
    for (final image in widget.gallery) {

      if (image.trim().isNotEmpty) {

        result.add(
          GalleryItem(
            type: GalleryType.image,
            value: image,
          ),
        );
      }
    }



    // لا يوجد أي شيء
    if (result.isEmpty) {

      result.add(
        const GalleryItem(
          type: GalleryType.defaultImage,
        ),
      );
    }


    return result;
  }



  @override
  void dispose() {

    _pageController.dispose();
    currentPage.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    return Stack(
      fit: StackFit.expand,
      children: [


        PageView.builder(

          controller: _pageController,

          itemCount: items.length,


          onPageChanged: (index){

            currentPage.value = index;

          },


          itemBuilder: (context,index){

            final item = items[index];


            switch(item.type){


              case GalleryType.video:

                return ProductGalleryVideoWidget(
                  videoUrl: item.value!,
                );


              case GalleryType.image:

                return Hero(
                  tag: '${widget.productId}',
                  child: CacheNetworkImage(
                    imageUrl: item.value!,
                    boxFit: BoxFit.cover,
                  ),
                );


              case GalleryType.defaultImage:

                return Assets.images.png.logo.image(
                  fit: BoxFit.contain,
                );

            }

          },

        ),



        IgnorePointer(
          child: _buildGradient(),
        ),



        if(widget.showBackButton)

          PositionedDirectional(
            top: context.statusBarHeight + 8,
            start: 20,

            child: InkWell(
              onTap: context.pop,

              child: Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: context.cardColor,
                  shape: BoxShape.circle,
                ),

                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: context.textColor,
                ),
              ),
            ),
          ),



        if(items.length > 1)

          PositionedDirectional(

            bottom: widget.isFromDecktop
                ? context.navigationBarHeight + 12
                : 12,

            end: 20,


            child: Container(

              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),


              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.45),
                borderRadius: BorderRadius.circular(12),
              ),


              child: ValueListenableBuilder<int>(

                valueListenable: currentPage,


                builder:(context,value,_){

                  return Text(

                    LocaleKeys.imageCounter.tr(

                      namedArgs: {

                        "current":
                        '${value + 1}',

                        "total":
                        '${items.length}',

                      },

                    ),


                    style: context.bodyLarge(
                      color: context.cardColor,
                      fontSize: 12,
                    ),
                  );
                },
              ),
            ),
          ),


      ],
    );
  }



  Widget _buildGradient(){

    return DecoratedBox(

      decoration: BoxDecoration(

        gradient: LinearGradient(

          begin: Alignment.topCenter,

          end: Alignment.bottomCenter,

          colors: [

            Colors.black.withOpacity(.2),

            Colors.transparent,

          ],

        ),

      ),

    );

  }

}



class ProductGalleryVideoWidget extends StatefulWidget {

  final String videoUrl;

  const ProductGalleryVideoWidget({
    super.key,
    required this.videoUrl,
  });


  @override
  State<ProductGalleryVideoWidget> createState() =>
      _ProductGalleryVideoWidgetState();
}


class _ProductGalleryVideoWidgetState
    extends State<ProductGalleryVideoWidget> {

  VideoPlayerController? _controller;

  bool _loading = true;
  bool _hasError = false;


  @override
  void initState() {
    super.initState();
    _initialize();
  }


  Future<void> _initialize() async {

    if (!mounted) return;


    setState(() {
      _loading = true;
      _hasError = false;
    });


    try {

      await _controller?.dispose();


      final controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );


      await controller.initialize();

      await controller.setLooping(true);
      await controller.setVolume(0);
      await controller.play();


      if (!mounted) {
        controller.dispose();
        return;
      }


      setState(() {
        _controller = controller;
        _loading = false;
      });


    } catch (_) {

      if (!mounted) return;


      setState(() {
        _loading = false;
        _hasError = true;
      });

    }
  }



  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {


    if (_loading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }


    if (_hasError) {

      return Material(
        color: Colors.transparent,
        child: Center(
          child: ElevatedButton.icon(
            onPressed: () {
              _initialize();
            },
            icon: Icon(
              Icons.refresh,
              color: context.cardColor,
            ),
            label: Text(
              LocaleKeys.retry.tr(),
              style: context.bodyMedium(
                color: context.cardColor,
              ),
            ),
          ),
        ),
      );
    }



    return ClipRect(
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,

          child: SizedBox(
            width: _controller!.value.size.width,
            height: _controller!.value.size.height,

            child: VideoPlayer(
              _controller!,
            ),
          ),
        ),
      ),
    );
  }
}