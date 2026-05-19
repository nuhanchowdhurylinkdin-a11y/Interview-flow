import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:dtc6464/core/services/network_caller.dart';
import 'package:dtc6464/core/services/storage_service.dart';
import 'package:dtc6464/core/utils/constants/api_constants.dart';
import 'package:dtc6464/core/utils/logging/logger.dart';
import 'package:dtc6464/features/nav_screens/profile/resumes/controllers/resumes_controller.dart';
import 'package:dtc6464/features/practice/model/analize_model.dart';
import 'package:dtc6464/features/practice/model/question_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../../core/utils/constants/snackbar_constant.dart';
import 'package:flutter_tts/flutter_tts.dart';

/// [PracticeController] manages the interview practice logic including
/// Speech-to-Text (STT), Text-to-Speech (TTS), Audio Recording, and API interactions.
class PracticeController extends GetxController {
  final NetworkCaller _networkCaller = Get.find<NetworkCaller>();

  // ==========================================
  // SERVICES & ENGINES
  // ==========================================
  late AudioRecorder audioRecorder;
  late AudioPlayer audioPlayer;
  final SpeechToText _speechToText = SpeechToText();
  final FlutterTts flutterTts = FlutterTts();

  // ==========================================
  // INTERVIEW CONFIGURATION & STATE
  // ==========================================
  var selectedIndex = 0.obs;
  var selectedTopic = "".obs;
  RxInt selectedQuestion = 0.obs;
  RxString inputType = 'voice'.obs; // 'voice' or 'type'

  // ==========================================
  // RESUME & ROLE SELECTION
  // ==========================================
  RxList<ResumeItem> resumes = <ResumeItem>[].obs;
  RxList<String> targetRoles = <String>[].obs;
  RxBool isResumesLoading = false.obs;
  RxBool isRolesLoading = false.obs;
  RxInt selectedResumeIndex = (-1).obs;
  RxString selectedRole = ''.obs;

  // ==========================================
  // SPEECH TO TEXT (STT) STATES
  // ==========================================
  var isRecording = false.obs;
  var isListening = false.obs;
  RxString recognizedText = "".obs;
  String _completeSentence = ""; // Internal buffer to prevent text duplication
  final TextEditingController answerController = TextEditingController();

  // ==========================================
  // AUDIO PLAYER & RECORDING STATES
  // ==========================================
  var recordedPath = "".obs;
  var amplitude = 0.0.obs;
  var isPlaying = false.obs;
  var position = Duration.zero.obs;
  var duration = Duration.zero.obs;

  // ==========================================
  // API & LOADING STATES
  // ==========================================
  RxBool isStartPracticeLoading = false.obs;
  RxBool isSubmitAnswerLoading = false.obs;
  Rx<QuestionsModel?> questions = Rx<QuestionsModel?>(null);
  Rx<AnalizeModel?> analizeData = Rx<AnalizeModel?>(null);

  // ==========================================
  // SUBSCRIPTIONS
  // ==========================================
  StreamSubscription<Amplitude>? _amplitudeSubscription;
  StreamSubscription<Duration>? _posSub;
  StreamSubscription<Duration>? _durSub;
  StreamSubscription<PlayerState>? _stateSub;

  @override
  void onInit() {
    super.onInit();
    _initAudioSystems();
    _initTts();
  }

  // ---------------------------------------------------------------------------
  // INITIALIZATION METHODS
  // ---------------------------------------------------------------------------

  /// Initializes the audio player listeners for progress and state tracking.
  void _initAudioSystems() {
    audioRecorder = AudioRecorder();
    audioPlayer = AudioPlayer();

    _durSub = audioPlayer.onDurationChanged.listen((d) => duration.value = d);
    _posSub = audioPlayer.onPositionChanged.listen((p) => position.value = p);
    _stateSub = audioPlayer.onPlayerStateChanged.listen(
          (s) => isPlaying.value = s == PlayerState.playing,
    );

    audioPlayer.onPlayerComplete.listen((_) {
      isPlaying.value = false;
      position.value = Duration.zero;
    });
  }

  /// Configures Flutter Text-to-Speech settings.
  Future<void> _initTts() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
  }

  // ---------------------------------------------------------------------------
  // RESUME & ROLE FETCHING
  // ---------------------------------------------------------------------------

  /// Fetches user's resumes.
  Future<void> fetchResumes() async {
    try {
      isResumesLoading.value = true;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.resumes,
        token: StorageService.accessToken,
      );

      if (response.isSuccess) {
        final data = response.responseData['data'];
        if (data != null && data['resumes'] != null) {
          resumes.assignAll(
            (data['resumes'] as List).map((e) => ResumeItem.fromJson(e)).toList(),
          );
        }
      }
    } catch (e) {
      AppLoggerHelper.error('Error fetching resumes: $e');
    } finally {
      isResumesLoading.value = false;
    }
  }

  /// Fetches user's target roles.
  Future<void> fetchRoles() async {
    try {
      isRolesLoading.value = true;
      final response = await _networkCaller.getRequest(
        ApiConstant.baseUrl + ApiConstant.targetRole,
        token: StorageService.accessToken,
      );

      if (response.isSuccess) {
        final data = response.responseData['data'];
        if (data != null && data['targetRole'] != null) {
          targetRoles.assignAll(List<String>.from(data['targetRole']));
        }
      }
    } catch (e) {
      AppLoggerHelper.error('Error fetching roles: $e');
    } finally {
      isRolesLoading.value = false;
    }
  }

  // ---------------------------------------------------------------------------
  // SPEECH TO TEXT (STT) LOGIC
  // ---------------------------------------------------------------------------

  /// Core logic for handling live speech recognition results.
  /// Combines new words with [_completeSentence] to manage the text area.
  void _startSpeechEngine() {
    _speechToText.listen(
      onResult: (result) {
        if (!isRecording.value) return;

        String currentWords = result.recognizedWords.trim();
        if (currentWords.isEmpty) return;

        String finalCalculatedText = _completeSentence.isEmpty
            ? currentWords
            : "$_completeSentence $currentWords".trim();

        recognizedText.value = finalCalculatedText;
        answerController.text = finalCalculatedText;

        // Keep cursor at the end for seamless user experience
        answerController.selection = TextSelection.fromPosition(
          TextPosition(offset: answerController.text.length),
        );

        if (result.finalResult) {
          // Add period at the end of each completed sentence
          if (!finalCalculatedText.endsWith('.') &&
              !finalCalculatedText.endsWith('?') &&
              !finalCalculatedText.endsWith('!')) {
            finalCalculatedText = '$finalCalculatedText.';
            recognizedText.value = finalCalculatedText;
            answerController.text = finalCalculatedText;
            answerController.selection = TextSelection.fromPosition(
              TextPosition(offset: answerController.text.length),
            );
          }
          _completeSentence = finalCalculatedText;
        }
      },
      listenOptions: SpeechListenOptions(
        listenMode: ListenMode.dictation,
        partialResults: true,
      ),
    );
  }

  /// Initializes listening. Auto-restarts if engine stops while button is held.
  Future<void> startListening() async {
    await HapticFeedback.mediumImpact();
    _completeSentence = answerController.text.trim();

    bool available = await _speechToText.initialize(
      onStatus: (status) {
        if (status == 'notListening' && isRecording.value) {
          _startSpeechEngine();
        }
      },
    );

    if (available) {
      isRecording.value = true;
      _startSpeechEngine();
    }
  }

  /// Stops the STT engine and locks the final text.
  Future<void> stopListening() async {
    isRecording.value = false;
    await _speechToText.stop();

    _completeSentence = answerController.text.trim();
    recognizedText.value = _completeSentence;
  }

  // ---------------------------------------------------------------------------
  // INTERVIEW & API LOGIC
  // ---------------------------------------------------------------------------

  /// Fetches a new interview session from the backend.
  Future<void> startInterview(BuildContext context) async {
    try {
      final role = selectedRole.value;
      final resumeName = selectedResumeIndex.value >= 0
          ? resumes[selectedResumeIndex.value].filename
          : '';
      final type = selectedIndex.value == 1 ? "behavioral" : "technical";
      final category = selectedTopic.value;

      resetData();
      isStartPracticeLoading.value = true;

      final response = await _networkCaller.postRequest(
        ApiConstant.baseUrl + ApiConstant.startInterview,
        body: {
          "type": type,
          "category": category,
          "selectedRole": role,
          "selectedResume": resumeName,
        },
        token: StorageService.accessToken,
      );

      AppLoggerHelper.info('Interview Response: ${response.responseData}');
      AppLoggerHelper.info('Interview isSuccess: ${response.isSuccess}');
      AppLoggerHelper.info('Interview errorMessage: ${response.errorMessage}');

      if (response.isSuccess) {
        questions.value = QuestionsModel.fromJson(response.responseData);
      } else {
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        Navigator.pop(context);
      }
    } catch (e) {
      SnackBarConstant.errorThin(title: 'Error', message: e.toString());
      Navigator.pop(context);
    } finally {
      isStartPracticeLoading.value = false;
    }
  }

  /// Submits the user's answer for evaluation.
  Future<void> submitInterview(BuildContext context) async {
    try {
      isSubmitAnswerLoading.value = true;
      final token = StorageService.accessToken;
      final response = await _networkCaller.postRequest(
          ApiConstant.baseUrl + ApiConstant.submitInterview + questions.value!.data.sessionId,
          body: {
            "question": questions.value!.data.aiData.personalizedQuestions[selectedQuestion.value].question,
            "answer": recognizedText.value.trim(),
          },
          token: token
      );

      if(!response.isSuccess) {
        isSubmitAnswerLoading.value = false;
        SnackBarConstant.errorThin(title: 'Failed', message: response.errorMessage);
        Navigator.pop(context);
        return;
      }

      analizeData.value = AnalizeModel.fromJson(response.responseData);
      isSubmitAnswerLoading.value = false;
    } catch (e) {
      isSubmitAnswerLoading.value = false;
      Navigator.pop(context);
      SnackBarConstant.errorThin(title: 'Error', message: e.toString());
    } finally {
      isSubmitAnswerLoading.value = false;
    }
  }

  /// Increments question index and resets specific question-based data.
  void nextQuestion() {
    if (questions.value != null &&
        selectedQuestion.value < questions.value!.data.aiData.personalizedQuestions.length - 1) {
      selectedQuestion.value++;

      recognizedText.value = "";
      _completeSentence = "";
      recordedPath.value = "";
      answerController.clear();
    } else {
      SnackBarConstant.success(title: 'Finished', message: 'You have completed all questions!');
    }
  }

  /// Updates internal sentence buffer when manual edits occur.
  void updateCompleteSentence(String value) {
    _completeSentence = value.trim();
    recognizedText.value = value.trim();
  }

  // ---------------------------------------------------------------------------
  // AUDIO RECORDING LOGIC
  // ---------------------------------------------------------------------------

  /// Starts raw audio recording to local storage.
  Future<void> startRecording() async {
    await HapticFeedback.mediumImpact();
    try {
      if (!await audioRecorder.hasPermission()) return;
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/rec_${DateTime.now().millisecondsSinceEpoch}.m4a';

      await audioRecorder.start(
        const RecordConfig(encoder: AudioEncoder.aacLc),
        path: path,
      );
      isRecording.value = true;
      recordedPath.value = "";

      _amplitudeSubscription = audioRecorder
          .onAmplitudeChanged(const Duration(milliseconds: 100))
          .listen((amp) {
        double currentAmp = amp.current.clamp(-50.0, 0.0);
        amplitude.value = (currentAmp + 50.0) / 50.0;
      });
    } catch (_) {}
  }

  /// Stops audio recording and saves file path.
  Future<void> stopRecording() async {
    try {
      _amplitudeSubscription?.cancel();
      final path = await audioRecorder.stop();
      isRecording.value = false;
      amplitude.value = 0.0;
      if (path != null) recordedPath.value = path;
      AppLoggerHelper.debug(answerController.text);
    } catch (_) {}
  }

  // ---------------------------------------------------------------------------
  // HELPERS & CLEANUP
  // ---------------------------------------------------------------------------

  /// Completely resets the controller state for a fresh start.
  void resetData() {
    selectedQuestion.value = 0;
    recognizedText.value = "";
    _completeSentence = "";
    recordedPath.value = "";
    answerController.clear();
    isRecording.value = false;
    isListening.value = false;
    amplitude.value = 0.0;
    position.value = Duration.zero;
    duration.value = Duration.zero;
    questions.value = null;
    selectedResumeIndex.value = -1;
    selectedRole.value = '';
  }

  void selectType(int index) => selectedIndex.value = index;

  /// Plays question text using TTS engine. Re-initializes on failure.
  Future<void> speak(String text) async {
    if (text.isEmpty) return;
    try {
      await flutterTts.speak(text);
    } catch (_) {
      // TTS engine connection died — re-init and retry once
      await _initTts();
      await flutterTts.speak(text);
    }
  }

  /// Default data for skeleton loading or error states.
  PersonalizedQuestion getPlaceholderQuestion() {
    return PersonalizedQuestion(
      question: "Loading question...",
      hints: ["Hint 1", "Hint 2"],
    );
  }

  @override
  void onClose() {
    _amplitudeSubscription?.cancel();
    _posSub?.cancel();
    _durSub?.cancel();
    _stateSub?.cancel();
    audioRecorder.dispose();
    audioPlayer.dispose();
    flutterTts.stop();
    _speechToText.stop();
    super.onClose();
  }
}