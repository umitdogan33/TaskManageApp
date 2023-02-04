import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manage_app/core/components/CustomAppBarWidget.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> changeValue(bool value) async {
    var sp = await SharedPreferences.getInstance();
    sp.setBool("notipermission", value);
  }

  Future<bool> getValue() async {
    var sp = await SharedPreferences.getInstance();
    var notiAccept = sp.getBool("notipermission") ?? true;
    return notiAccept;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Settings",actions: []),
      body: FutureBuilder(
        future: getValue(),
        builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("Settings",style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w600))),
                Divider(),
                Row(
                  children: [
                    Switch(
                      value: snapshot.data ?? true,
                      onChanged: (value) {
                        setState(() {
                          changeValue(value);
                        });
                      },
                    ),
                    Text("Notification Permission",style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w500))
                  ],
                ),
              ],
            );
        },
      ),
    );
  }
}
