import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoter/screen/editor/blocs/editor_bloc.dart';

const int COLUMNS = 4;
const double BORDER_RADIUS = 10;

class WallpaperSelector extends StatelessWidget {
  const WallpaperSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: COLUMNS, mainAxisSpacing: 5, crossAxisSpacing: 5),
        itemBuilder: (context, pos) {
          return WallpaperItem(
            position: 1 + pos,
          );
        },
        shrinkWrap: true,
        itemCount: 86,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}

class WallpaperItem extends StatelessWidget {
  int position;

  WallpaperItem({required this.position});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image(
          image: AssetImage(
            _getImagePath(),
          ),
          fit: BoxFit.cover,
        ),
      ),
      onTap: () {
        context.read<EditorBloc>().add(ChangeBackgroundImageEvent(position: position));
      },
    );
  }

  String _getImagePath() {
    return "assets/images/bg_${position.toString().padLeft(2, '0')}.jpg";
  }
}
