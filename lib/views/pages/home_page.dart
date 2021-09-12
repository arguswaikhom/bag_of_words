import 'package:bag_of_words/bloc/auth/auth_bloc.dart';
import 'package:bag_of_words/bloc/auth/auth_state.dart';
import 'package:bag_of_words/bloc/home/day_revision_summary_bloc.dart';
import 'package:bag_of_words/bloc/home/day_revision_summary_event.dart';
import 'package:bag_of_words/bloc/home/day_revision_summary_state.dart';
import 'package:bag_of_words/data/providers/day_revision_cloud_provider.dart';
import 'package:bag_of_words/data/repos/auth/auth_repo.dart';
import 'package:bag_of_words/data/repos/day_revision_repo.dart';
import 'package:bag_of_words/res/app_color.dart';
import 'package:bag_of_words/res/app_string.dart';
import 'package:bag_of_words/views/pages/login_page.dart';
import 'package:bag_of_words/views/reps/day_revision_stat_rep.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Route route() => MaterialPageRoute<void>(builder: (_) => HomePage());

  @override
  Widget build(BuildContext context) {
    final User user = context.read<AuthRepo>().getAuthenticatedUser();
    return BlocProvider(
      create: (_) => DayRevisionSummaryBloc(
        DayRevisionRepo(
          user: user,
          cloudProvider: DayRevisionCloudProvider(),
        ),
      ),
      child: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DayRevisionSummaryBloc _dayRevSumBloc;

  @override
  void initState() {
    super.initState();
    _dayRevSumBloc = context.read<DayRevisionSummaryBloc>();
    _dayRevSumBloc.add(DayRevisionSummaryFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkBg,
      appBar: AppBar(
        title: Text(AppString.appName),
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.more_vert_rounded),
            onPressed: () {
              // TODO: Implement logout option with bottom sheet
            },
          ),
        ],
      ),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state.status != AuthStatus.AUTHENTICATED) {
            Navigator.pushAndRemoveUntil(
              context,
              LoginPage.route(),
              (route) => false,
            );
          }
        },
        child: HomeScreenBody(),
      ),
    );
  }
}

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: BlocBuilder<DayRevisionSummaryBloc, DayRevisionSummaryState>(
        builder: (context, state) {
          if (state.status == DayRevisionSummaryStatus.SUCCESS) {
            return DayRevisionStatRep(
              todaysDayStat: state.todaysDayStat,
              yestDayStat: state.yestDayStat,
            );
          }

          return DayRevisionStatRep();
        },
      ),
    );
  }
}
