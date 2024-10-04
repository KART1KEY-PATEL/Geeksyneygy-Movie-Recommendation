import 'package:flutter/material.dart';
import 'package:geeksynergymovie/auth_state.dart';
import 'package:geeksynergymovie/utils/color.dart';
import 'package:geeksynergymovie/widgets/movie_card.dart';
import 'package:geeksynergymovie/services/movie_service.dart';
import 'package:geeksynergymovie/utils/text_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void showCompanyInfo(BuildContext context) {
    final sH = MediaQuery.of(context).size.height;
    final sW = MediaQuery.of(context).size.width;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.accentPrimaryColor,
          title: txt(
            'Company Info',
            isBold: true,
            size: sH * 0.02,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              txt('Company: Geeksynergy Technologies Pvt Ltd'),
              txt('Address: Sanjayanagar, Bengaluru-56'),
              txt('Phone: XXXXXXXXX09'),
              txt('Email: XXXXXX@gmail.com'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final sH = MediaQuery.of(context).size.height;
    final sW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: txt('Home Page', size: sH * 0.028),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthState>(context, listen: false).logout();
              Navigator.pushReplacementNamed(context, '/signinPage');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () => showCompanyInfo(context),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: sW * 0.04,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: sW * 0.02,
                vertical: sH * 0.02,
              ),
              decoration: BoxDecoration(
                color: AppColors.secondaryButtonColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: txt(
                  "Company Info",
                  color: AppColors.blackTextColor,
                  size: sH * 0.018,
                  weight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: sH * 0.01),
          Expanded(
            child: FutureBuilder(
              future: MovieService().getMovieRecommendations(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  final movies = snapshot.data['result'];
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      final movie = movies[index];
                      return MovieCard(movie: movie);
                    },
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
