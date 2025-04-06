import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'bottom_nav_bar.dart';
import '../models/trash_information_model.dart';
import '../widgets/pcs_total_badge.dart';
import 'package:go_router/go_router.dart';
import '../functions/dirary_storage.dart';
import 'package:flutter/services.dart';

enum InfoSheetType { loading, information, error }

class InfoSheet extends StatelessWidget {
  final InfoSheetType type;
  final int trash_id;

  const InfoSheet({super.key, required this.type, required this.trash_id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: SingleChildScrollView(
                  child: Container(child: _buildContent(context)),
                ),
              ),
            ),
            const SizedBox(height: 10),
            BottomNavBar(selectedIndex: -1),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    switch (type) {
      case InfoSheetType.loading:
        return Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 12),
              const Text("Now Loading . . .", style: TextStyle(fontSize: 22)),
            ],
          ),
        );
      case InfoSheetType.information:
        return _infomationDisplay(context, trash_id);
      case InfoSheetType.error:
        return _errorDisplay();
    }
  }

  Column _infomationDisplay(BuildContext context, int id) {
    TrashInformationModel? trashCategory =
        TrashInformationModel.getCategoryById(id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("This is", style: TextStyle(fontSize: 22)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              trashCategory!.name,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900),
            ),
            PcsTotalBadge(count: trashCategory.total, color: Colors.black)
          ],
        ),
        buildTags(trashCategory.tags, trashCategory.color),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(24.0),
          child: Image.asset(trashCategory.imagePath),
        ),
        const SizedBox(height: 16),
        trashCategory.description,
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset('assets/icons/trash_diary.svg'),
            SvgPicture.asset('assets/icons/arrow_right.svg'),
            _ClaimPointButton(trashId: trash_id),
          ],
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {
            context.push('/map', extra: trash_id);
            print('Button pressed!');
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Center(
              child: Text(
                'Find nearby bin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Column _errorDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Sorry But...", style: TextStyle(fontSize: 22)),
        const SizedBox(height: 4),
        const Text(
          "Unrecognized Item",
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Image.asset('assets/images/trash_not_found.png'),
        const SizedBox(height: 8),
        RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: "The item you scanned could not be recognized.\n\n",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              TextSpan(
                text: "Try the following steps:\n\n",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              WidgetSpan(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildBulletPoint(
                          "Check Lighting & Angle: Ensure the item is well-lit and clearly visible in the camera."),
                      buildBulletPoint(
                          "Try Again: Adjust the position and rescan."),
                      buildBulletPoint(
                          "Manually Select: If scanning fails, you can manually search for the item in the list."),
                      buildBulletPoint(
                          "Report Issue: If the item is missing from our database, consider reporting it so we can improve recognition."),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _ClaimPointButton extends StatefulWidget {
  final int trashId;

  const _ClaimPointButton({super.key, required this.trashId});

  @override
  State<_ClaimPointButton> createState() => _ClaimPointButtonState();
}

class _ClaimPointButtonState extends State<_ClaimPointButton> {
  bool hasClaimed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (hasClaimed) return;

        setState(() => hasClaimed = true);

        final trashCategory =
            TrashInformationModel.getCategoryById(widget.trashId);

        // ✅ เพิ่ม 1 แต้มในวันปัจจุบัน และรับค่ารวมของขยะนี้ในวันนี้กลับมา
        final updated =
            await DiaryStorage.addPointForTrashId(widget.trashId.toString());

        _showTopToast(
          context,
          'คุณได้รับแต้มสำหรับ "${trashCategory?.name ?? 'ขยะนี้'}" แล้ว\nรวมวันนี้: $updated แต้ม',
        );
      },
      child: Opacity(
        opacity: hasClaimed ? 0.5 : 1.0,
        child: SvgPicture.asset('assets/icons/click_here_button.svg'),
      ),
    );
  }

  void _showTopToast(BuildContext context, String message) {
    HapticFeedback.mediumImpact();
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 40,
        left: 20,
        right: 20,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    Future.delayed(const Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }
}

SizedBox buildTags(List<String> tags, Color color) {
  return SizedBox(
    height: 40,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      itemCount: tags.length,
      separatorBuilder: (context, index) => const SizedBox(width: 8),
      itemBuilder: (context, index) => Chip(
        side: BorderSide.none,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        label: Text(
          tags[index],
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: color,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    ),
  );
}

Widget buildBulletPoint(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 1.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("• ", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Expanded(child: Text(text)),
      ],
    ),
  );
}
