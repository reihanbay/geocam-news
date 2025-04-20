import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import 'viewmodel/geocam_viewmodel.dart';

class HomecamScreen extends StatefulWidget {
  const HomecamScreen({super.key});

  @override
  State<HomecamScreen> createState() => _HomecamScreenState();
}

class _HomecamScreenState extends State<HomecamScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<GeocamViewmodel>();
    vm.loadPhoto();
    vm.loadLocation();
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "GeoCam News",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              ContainerCapture(),
            ],
          ),
        ),
      ),
    );
  }
}

class ContainerCapture extends StatelessWidget {
  const ContainerCapture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    onCameraView(GeocamViewmodel vm) async {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.camera);
      final isAndroid = defaultTargetPlatform == TargetPlatform.android;
      final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
      final isNotMobile = !(isAndroid || isiOS);
      if (isNotMobile) return;
      if (pickedFile != null) {
        vm.setImageBytes(pickedFile);
        vm.setImagePath(pickedFile.path);
      }
    }

    SnackBar snackBarAlert(String message) => SnackBar(content: Text(message));
    return Consumer<GeocamViewmodel>(builder: (context, vm, ___) {
      return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8F8F8F).withValues(alpha: 0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: vm.photo == null
                        ? Container(
                            padding: EdgeInsets.only(top: 16),
                            height: 220,
                            child: Center(
                              child: Column(
                                children: [
                                  Image.asset("assets/location.png"),
                                  const SizedBox(height: 6),
                                  Text("Ambil Gambar",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSurface))
                                ],
                              ),
                            ))
                        : Image.memory(vm.photo!,
                            fit: BoxFit.contain, width: double.infinity)),
                Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Theme.of(context)
                              .colorScheme
                              .surface
                              .withValues(alpha: 0.7)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Latitude",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  )),
                              Text(
                                  vm.latitude != null
                                      ? vm.latitude.toString()
                                      : "Tidak Tersedia",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Longitude",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  )),
                              Text(
                                  vm.longitude != null
                                      ? vm.longitude.toString()
                                      : "Tidak Tersedia",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () async {
                      final resetData = await vm.resetData();
                      if (resetData) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBarAlert("Data terhapus!"));
                      }
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Reset",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                FloatingActionButton.small(
                  onPressed: () {
                    vm.getLocation();
                    onCameraView(vm);
                  },
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: SvgPicture.asset(
                    "assets/camera.svg",
                    colorFilter: ColorFilter.mode(
                        Theme.of(context).colorScheme.onPrimary,
                        BlendMode.srcIn),
                  ),
                ),
                const SizedBox(width: 6),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      if (vm.photo == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBarAlert("Gambar Tidak Tersedia"));
                      } else if (vm.latitude == null ||
                          vm.longitude == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            snackBarAlert("Lokasi Tidak Ditemukan"));
                      } else {
                        final result = await vm.savePhotoLocation(
                            vm.photo!,
                            vm.latitude!,
                            vm.longitude!) ;
                        if(result) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            snackBarAlert("Berhasil Simpan!"));
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    label: Text("Simpan Data",
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
