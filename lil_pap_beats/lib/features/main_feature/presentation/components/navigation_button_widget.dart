import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constant/colors.dart';
import '../../../../dependency_injection.dart';
import '../cubit/main_page_index/main_page_index_cubit.dart';

class NavigationButton extends StatefulWidget {
  const NavigationButton({
    super.key,
    required this.index,
    required this.label,
    required this.icon,
  });

  final int index;
  final String label;
  final IconData icon;

  @override
  State<NavigationButton> createState() => _NavigationButtonState();
}

class _NavigationButtonState extends State<NavigationButton> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainPageIndexCubit, int>(
      builder: (context, state) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              widget.icon,
              color: state == widget.index ? kPrimaryColor : Colors.white,
              size: 25,
            ),
            onPressed: () {
              sl<MainPageIndexCubit>().changeIndex(widget.index);
            },
          ),
          Visibility(
            visible: state == widget.index,
            child: Text(
              widget.label,
              style: const TextStyle(
                color: kPrimaryColor,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
