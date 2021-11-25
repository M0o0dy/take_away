import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_conditional_rendering/conditional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:take_away/data/admin_drawer_navbar.dart';
import 'package:take_away/layout/admin_cubit/states.dart';
import 'package:take_away/shared/components/constance.dart';
import 'package:take_away/shared/styles/icons.dart';

import 'admin_cubit/cubit.dart';

class AdminLayout extends StatelessWidget {
  const AdminLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = AdminCubit.get(context);
    return Builder(builder: (BuildContext context) {
      cubit.getUserData();
      return BlocConsumer<AdminCubit, AdminStates>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          drawer: Conditional.single(
            context: context,
            widgetBuilder: (BuildContext context) =>AdminNavBar(
              condition: state is SuccessProfileImagePickedState,
              accountEmail: cubit.userModel!.email,
              accountName: cubit.userModel!.name,
              accountImage: cubit.userModel!.image,
            ),
            conditionBuilder: (BuildContext context) => cubit.userModel != null,
            fallbackBuilder: (BuildContext context)=>const SizedBox(),
          ),
          appBar: AppBar(
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  '7HEVƎN',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  'Takeaway',
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  signOut(context);
                },
                child: const Icon(IconBroken.Logout),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(
                  cubit.mainBottomScreenTitle[cubit.mainCurrentIndex],
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 30,
                  ),
                ),
                cubit.mainBottomScreen[cubit.mainCurrentIndex]
              ],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'جديد'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline), label: 'إتسلمت'),
            ],
            currentIndex: cubit.mainCurrentIndex,
            showSelectedLabels: true,
            onTap: (index) {
              cubit.mainChangeIndex(index);
            },
          ),
        ),
      );
    });
  }
}