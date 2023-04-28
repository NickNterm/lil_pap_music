import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lil_pap_beats/constant/colors.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/bloc/albums/albums_bloc.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/bloc/collaborations/collaborations_bloc.dart';
import 'package:lil_pap_beats/features/loading_feature/presentation/cubit/show_intro/show_intro_cubit.dart';

import '../../../../core/functions/functions.dart';
import '../../../../dependency_injection.dart';
import '../bloc/beats_for_placement/beats_for_placement_bloc.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> scaleAnimation;
  int loadingCount = 0;
  late StreamSubscription albumListener;
  late StreamSubscription collabListener;
  late StreamSubscription beatsListener;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )
      ..addListener(() {
        setState(() {});
      })
      ..forward()
      ..repeat(reverse: true);
    scaleAnimation = Tween(
      begin: 0.0,
      end: 10.0,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeOut,
      ),
    );
    Future.delayed(const Duration(seconds: 3), () {
      sl<AlbumsBloc>().add(GetAlbumsEvent());
      sl<CollaborationsBloc>().add(GetCollaborationsEvent());
      sl<BeatsForPlacementBloc>().add(GetBeatsForPlacementEvent());
      sl<ShowIntroCubit>().getShowIntro();
    });

    albumListener = sl<AlbumsBloc>().stream.listen((state) {
      if (state is AlbumsLoaded) {
        loadingCount++;
        if (loadingCount == 3) {
          dataIsReady();
        }
        albumListener.cancel();
      }
      if (state is AlbumsError) {
        showSnackBarMessage(context, state.failure.message);
      }
    });

    collabListener = sl<CollaborationsBloc>().stream.listen((state) {
      if (state is CollaborationsLoaded) {
        loadingCount++;
        if (loadingCount == 3) {
          dataIsReady();
        }
        collabListener.cancel();
      }
      if (state is CollaborationsError) {
        showSnackBarMessage(context, state.failure.message);
      }
    });

    beatsListener = sl<BeatsForPlacementBloc>().stream.listen((state) {
      if (state is BeatsForPlacementLoaded) {
        loadingCount++;
        if (loadingCount == 3) {
          dataIsReady();
        }
        beatsListener.cancel();
      }
      if (state is BeatsForPlacementError) {
        showSnackBarMessage(context, state.failure.message);
      }
    });
  }

  void dataIsReady() {
    bool isShowIntro =
        (sl<ShowIntroCubit>().state as ShowIntroLoaded).showIntro;

    if (isShowIntro) {
      Navigator.pushReplacementNamed(context, '/intro');
      return;
    }
    Navigator.pushReplacementNamed(context, '/home');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Text(
              'LP',
              style: GoogleFonts.leckerliOne(
                color: kPrimaryColor,
                fontSize: 80,
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: scaleAnimation.value,
                sigmaY: scaleAnimation.value,
              ),
              child: Text(
                'LP',
                style: GoogleFonts.leckerliOne(
                  color: kPrimaryColor,
                  fontSize: 80,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
