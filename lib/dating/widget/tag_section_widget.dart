import 'package:flutter/material.dart';

class TagSectionWidget extends StatefulWidget {
  @override
  _TagSectionWidgetState createState() => _TagSectionWidgetState();
}

class _TagSectionWidgetState extends State<TagSectionWidget> {
  List<String> _tags = [];
  final int maxTags = 20;
  final TextEditingController _tagController = TextEditingController();
  bool _isAddingTag = false;

  void _addTag(String tag) {
    if (_tags.length < maxTags) {
      setState(() {
        _tags.add(tag);
        _isAddingTag = false;
      });
    }
  }

  void _removeTag(int index) {
    setState(() {
      _tags.removeAt(index);
    });
  }

  Widget _buildTagChip(String tag, int index) {
    return Chip(
      label: Text(tag),
      onDeleted: () => _removeTag(index),
      deleteIcon: Icon(Icons.close),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("태그"),
        SizedBox(height: 10),
        Wrap(
          spacing: 8.0,
          runSpacing: 4.0,
          children: [
            ..._tags.asMap().entries.map((entry) {
              int index = entry.key;
              String tag = entry.value;
              return _buildTagChip(tag, index);
            }).toList(),
            if (_isAddingTag)
              Container(
                width: 100,
                child: TextField(
                  controller: _tagController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "태그 입력",
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) {
                    if (value.isNotEmpty) {
                      _addTag(value);
                      _tagController.clear();
                    }
                  },
                ),
              ),
            if (!_isAddingTag && _tags.length < maxTags)
              ActionChip(
                label: Text("+태그 (${_tags.length}/$maxTags)"),
                onPressed: () {
                  setState(() {
                    _isAddingTag = true;
                  });
                },
              ),
          ],
        ),
      ],
    );
  }
}
