
import 'package:flutter/material.dart';
import 'package:sahra/core/constants/constants_properties.dart';

class MovieOverview extends StatefulWidget {
  final String overview;
  const MovieOverview({super.key, required this.overview});

  @override
  _MovieOverviewState createState() => _MovieOverviewState();
}

class _MovieOverviewState extends State<MovieOverview> {
  bool _isExpanded = false; 
  @override
  Widget build(BuildContext context) {
    final displayText = _isExpanded ? widget.overview : widget.overview.substring(0, 100);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            displayText,
            maxLines: _isExpanded ? null : 3, 
            overflow: _isExpanded ? null : TextOverflow.ellipsis, 
            textAlign: TextAlign.start,
            style: const TextStyle(
              fontSize: 15,
              fontFamily: kmainfont, 
              fontWeight: FontWeight.w400,
            ),
          ),
          if (widget.overview.length > 100) 
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? 'Show Less' : 'Show More',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black45,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
