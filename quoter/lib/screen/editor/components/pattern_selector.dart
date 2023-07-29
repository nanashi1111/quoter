import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quoter/screen/editor/blocs/editor_bloc.dart';

const int COLUMNS = 4;
const double BORDER_RADIUS = 10;

class PatternSelector extends StatelessWidget {
  const PatternSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: COLUMNS, mainAxisSpacing: 5, crossAxisSpacing: 5),
        itemBuilder: (context, pos) {
          return PatternItem(
            position: 1 + pos,
          );
        },
        shrinkWrap: true,
        itemCount: 6,
        physics: const ClampingScrollPhysics(),
      ),
    );
  }
}

class PatternItem extends StatelessWidget {
  int position;

  PatternItem({required this.position});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Image(
          image: AssetImage(
            "assets/images/pattern_${position}.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      onTap: (){
        context.read<EditorBloc>().add(ChangePatternEvent(position: position));
      },
    );
  }
}
