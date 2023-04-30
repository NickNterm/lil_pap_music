import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constant/colors.dart';
import '../../../loading_feature/presentation/bloc/beats_for_placement/beats_for_placement_bloc.dart';
import '../components/beats_for_placement_widget.dart';

class BeatsForPlacementPage extends StatelessWidget {
  const BeatsForPlacementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(15, 15, 15, 10),
              child: Text(
                "Beats For Placement Page",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              height: 5,
              width: MediaQuery.of(context).size.width * 0.5,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            const SizedBox(height: 15),
            BlocBuilder<BeatsForPlacementBloc, BeatsForPlacementState>(
              builder: (context, state) {
                if (state is BeatsForPlacementLoaded) {
                  var beats = state.beats;
                  return ListView.builder(
                    itemCount: beats.length,
                    padding: const EdgeInsets.only(bottom: 120),
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        child: BeatForPlacementWidget(
                          beat: beats[index],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
