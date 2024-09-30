import 'dart:io';
import 'package:intl/intl.dart';
import 'package:agora_chat_uikit/agora_chat_uikit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:speed_dating_front/dating/controller/dating_controller.dart';
import 'package:speed_dating_front/dating/model/create_dating.model.dart';
import 'package:speed_dating_front/dating/widget/tag_section_widget.dart';
import 'package:speed_dating_front/util/create_dating_storage.dart';
import 'package:speed_dating_front/util/theme/theme.dart';

class CreatingDatingPageScreen extends StatefulWidget {
  final CreateDatingModel? model;

  const CreatingDatingPageScreen({super.key, this.model});

  @override
  State<CreatingDatingPageScreen> createState() =>
      _CreatingDatingPageScreenState();
}

class _CreatingDatingPageScreenState extends State<CreatingDatingPageScreen> {
  final ImagePicker _picker = ImagePicker();
  List<File> _selectedImages = [];
  int maleCapacity = 0;
  int femaleCapacity = 0;
  List<String> tags = [];
  DateTime? _selectedDateTime;

  TextEditingController titleController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  // 에러 메시지 변수
  String? priceError;
  String? maleCapacityError;
  String? femaleCapacityError;

  void _validatePrice(String value) {
    setState(() {
      priceError = (double.tryParse(value) == null) ? "유효한 가격을 입력해주세요." : null;
    });
  }

  void _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime:
            TimeOfDay.fromDateTime(_selectedDateTime ?? DateTime.now()),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          // 포맷팅된 날짜와 시간
          final DateFormat dateFormat = DateFormat('yyyy년 MM월 dd일 HH시 mm분');
          _dateController.text = dateFormat.format(_selectedDateTime!);
        });
      }
    }
  }

  void _validateCapacity(String value, String gender) {
    setState(() {
      final errorMessage = "유효한 인원 수를 입력해주세요.";
      if (gender == "여") {
        femaleCapacityError =
            (int.tryParse(value) == null) ? errorMessage : null;
      } else {
        maleCapacityError = (int.tryParse(value) == null) ? errorMessage : null;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.model != null) {
      titleController.text = widget.model!.title ?? '';
      priceController.text = widget.model!.price?.toString() ?? '';
      descriptionController.text = widget.model!.description ?? '';
      maleCapacity = widget.model!.maleCapacity ?? 0;
      femaleCapacity = widget.model!.femaleCapacity ?? 0;
      _selectedImages =
          widget.model!.imagePaths?.map((path) => File(path)).toList() ?? [];
      tags = widget.model!.tags?.map((tag) => tag).toList() ?? [];
    }
  }

  String? _convertKSTToUTCString(DateTime? selectedDateTime) {
    if (selectedDateTime == null) return null;
    // KST -> UTC 변환 후 ISO 8601 포맷으로 변환
    // print("selectedDateTime ${selectedDateTime.toUtc().toIso8601String()}");
    return selectedDateTime.toUtc().toIso8601String();
  }

  void _saveModel() {
    final model = CreateDatingModel(
      title: titleController.text,
      price: double.tryParse(priceController.text),
      imagePaths: _selectedImages.map((e) => e.path).toList(),
      maleCapacity: maleCapacity,
      femaleCapacity: femaleCapacity,
      description: descriptionController.text,
      startDate: _convertKSTToUTCString(_selectedDateTime),
    );
    CreateDatingStorage.saveDatingModel(model);
  }

  void _clearModel() {
    CreateDatingStorage.clearModel();
  }

  void _checkForUnsavedChanges() {
    if (titleController.text.isNotEmpty ||
        priceController.text.isNotEmpty ||
        descriptionController.text.isNotEmpty ||
        _selectedImages.isNotEmpty ||
        tags.isNotEmpty) {
      _showExitDialog();
    } else {
      Navigator.of(context).pop();
    }
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null && _selectedImages.length < 10) {
      setState(() {
        _selectedImages.add(File(pickedFile.path));
      });
    }
  }

  void _showExitDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("작성중인 글을 저장할까요?"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                ElevatedButton(
                  child: Text("저장하기"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: lightColorScheme.primary,
                  ),
                  onPressed: () {
                    // 저장 로직 추가
                    _saveModel();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text("저장안함"),
                  style: TextButton.styleFrom(
                    foregroundColor: lightColorScheme.error,
                  ),
                  onPressed: () {
                    _clearModel();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // 페이지 닫기
                  },
                ),
              ],
            ),
          ),
          backgroundColor: lightColorScheme.surface,
          titleTextStyle: TextStyle(
            color: lightColorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            color: lightColorScheme.onSurface,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        );
      },
    );
  }

  bool _validateFields() {
    if (titleController.text.isEmpty) {
      _displayValidationError("제목을 입력해주세요.");
      return false;
    }
    if (priceController.text.isEmpty ||
        double.tryParse(priceController.text) == null) {
      _displayValidationError("유효한 참가 가격을 입력해주세요.");
      return false;
    }
    if (maleCapacity == 0 || femaleCapacity == 0) {
      _displayValidationError("참여 인원을 입력해주세요.");
      return false;
    }
    if (descriptionController.text.isEmpty) {
      _displayValidationError("설명을 입력해주세요.");
      return false;
    }
    return true;
  }

  void _displayValidationError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final datingController = Provider.of<DatingController>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close_rounded),
          onPressed: () {
            _checkForUnsavedChanges();
          },
        ),
        title: Text(
          "스개팅 만들기",
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // 키보드 닫기
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildImagePickerSection(),
                      SizedBox(height: 20),
                      _buildTextFieldSection(
                        "제목",
                        "제목을 입력하세요",
                        TextInputType.text,
                        controller: titleController,
                        errorText: null,
                        onChanged: (_) {},
                      ),
                      SizedBox(height: 20),
                      _buildTextFieldSection(
                        "참가 가격",
                        "가격을 입력하세요",
                        TextInputType.number,
                        controller: priceController,
                        errorText: priceError,
                        onChanged: _validatePrice,
                      ),
                      SizedBox(height: 20),
                      _buildParticipantsSection(),
                      SizedBox(height: 20),
                      _buildTextFieldSection(
                        "자세한 설명",
                        "설명을 입력하세요",
                        TextInputType.text,
                        maxLines: 5,
                        controller: descriptionController,
                        errorText: null,
                        onChanged: (_) {},
                      ),
                      SizedBox(height: 20),
                      _buildDatePickerSection(),
                      SizedBox(height: 20),
                      TagSectionWidget(),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(16),
        color: Colors.white,
        child: ElevatedButton(
          onPressed: () async {
            if (_validateFields()) {
              CreateDatingModel model = CreateDatingModel(
                title: titleController.text,
                price: double.tryParse(priceController.text),
                imagePaths: _selectedImages.map((file) => file.path).toList(),
                maleCapacity: maleCapacity,
                femaleCapacity: femaleCapacity,
                description: descriptionController.text,
                startDate: _convertKSTToUTCString(_selectedDateTime),
                tags: tags,
              );
              await datingController.createDating(model);
              _clearModel();
            }
          },
          child: Text("작성완료"),
        ),
      ),
    );
  }

  Widget _buildDatePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("시작 시각", style: Theme.of(context).textTheme.subtitle1),
        SizedBox(height: 10),

        // 날짜가 선택되지 않았을 때 날짜 선택 버튼 표시
        _selectedDateTime == null
            ? ElevatedButton(
                onPressed: () => _selectDateTime(context),
                child: Text("날짜 선택"),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 선택된 날짜 표시
                  Text(
                    "${_selectedDateTime!.year}-${_selectedDateTime!.month}-${_selectedDateTime!.day} "
                    "${_selectedDateTime!.hour}:${_selectedDateTime!.minute}",
                    style: TextStyle(fontSize: 16),
                  ),
                  // 수정 버튼
                  TextButton(
                    onPressed: () => _selectDateTime(context),
                    child: Text("수정"),
                  ),
                ],
              ),
      ],
    );
  }

  Widget _buildTextFieldSection(
    String title,
    String hintText,
    TextInputType keyboardType, {
    required TextEditingController controller,
    String? errorText,
    required Function(String) onChanged,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 10),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: hintText,
            errorText: errorText, // 에러 메시지 출력
          ),
          keyboardType: keyboardType,
          onChanged: onChanged,
          maxLines: maxLines,
        ),
      ],
    );
  }

  Widget _buildImagePickerSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            InkWell(
              onTap: _pickImage,
              child: Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.camera_alt),
                    SizedBox(height: 5),
                    Text(
                      "${_selectedImages.length}/10",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                height: 80,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _selectedImages[index],
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          // 오른쪽 상단에 X 버튼 추가
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImages.removeAt(index);
                                });
                              },
                              child: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.close,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          // 첫 번째 이미지 하단에 썸네일 표시
                          if (index == 0)
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                color: Colors.black.withOpacity(0.6),
                                height: 20,
                                alignment: Alignment.center,
                                child: Text(
                                  "썸네일",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildParticipantsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("참여 인원"),
        SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildGenderParticipantField("여"),
            ),
            SizedBox(width: 10),
            Expanded(
              child: _buildGenderParticipantField("남"),
            ),
          ],
        ),
      ],
    );
  }

  _buildGenderParticipantField(String gender) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(gender),
        SizedBox(height: 5),
        TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "인원 수",
          ),
          keyboardType: TextInputType.number,
          onChanged: (value) {
            setState(() {
              if (gender == "여") {
                femaleCapacity = int.tryParse(value) ?? 0; // 여성 인원 수 저장
              } else {
                maleCapacity = int.tryParse(value) ?? 0; // 남성 인원 수 저장
              }
            });
          },
        ),
      ],
    );
  }
}
