import 'package:app_well_mate/components/prescription_item.dart';
import 'package:app_well_mate/const/color_scheme.dart';
import 'package:app_well_mate/model/hospital_model.dart';
import 'package:app_well_mate/model/notification_model.dart';
import 'package:app_well_mate/model/prescription_detail_model.dart';
import 'package:app_well_mate/model/prescription_model.dart';
import 'package:app_well_mate/screen/notification_func/index.dart';
import 'package:app_well_mate/utils/app.colors.dart';
import 'package:app_well_mate/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class HospitalDetailPage extends StatefulWidget {
  const HospitalDetailPage({super.key, required this.notifiItem});
  final NotificationModel notifiItem;

  @override
  State<HospitalDetailPage> createState() => _HospitalDetailPageState();
}

class _HospitalDetailPageState extends State<HospitalDetailPage> {
  PrescriptionDetailModel? preDetailModel;

  PrescriptionModel? prescriptionModel;

  HospitalModel? hospitalModel;
  @override
  void initState() {
    preDetailModel =
        getPrescriptionModelDetailFromId(widget.notifiItem.idDonThuocCT!);

    if (preDetailModel != null) {
      print("id preDetailModel ${preDetailModel!.idPre}");

      prescriptionModel = getPrescriptionModel(preDetailModel!.idPre!);

      if (prescriptionModel != null) {
        print("name hospital: ${prescriptionModel!.hospital!.name}");

        hospitalModel = prescriptionModel!.hospital!;
      }
    }

    // prescriptionModel = getPrescriptionModel(preDetailModel!.idPre!);
    // hospitalModel = getHospital(prescriptionModel!.idHospital!);

    // print(hospitalModel!.name!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Expanded(
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Image.network(
                          hospitalModel!.avatars!,
                          width: 150,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              hospitalModel!.name!,
                              style: Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              child: Text(
                                "Vui lòng đến phòng khám với sổ khám bệnh với toa thuốc ở dưới để nhân viên có thể xác nhận và phát số.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )),
                        ],
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      Text(
                        "Lịch tái khám",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                            color: AppColors.greyColor,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Icon(Symbols.calendar_month),
                                const SizedBox(
                                  width: 8,
                                ),
                                Text(
                                    formatDate(prescriptionModel!.revisitDate!),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "Phòng ${prescriptionModel!.roomRevisit!}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "Toa thuốc",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                     
                    ],
                  ),
                ),
              ),
              SliverList.separated(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    // cái id là test thôi sau này có data thật thì
                    // qua bên cái Item này lấy id đó xong viết API data về
                    // lắp data vô
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: PrescriptionItem(
                        model: prescriptionModel!,
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const SizedBox(
                        height: 4,
                      )),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 10),
                      backgroundColor: AppColor.smoker),
                  label: Text(
                    'Báo lại cho tôi sau 10 phút',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  icon: const Icon(
                    Symbols.snooze,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ),
              const SizedBox(
                width: 14,
              ),
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 10),
                  ),
                  label: Text(
                    'Đánh dấu đã uống',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: Colors.white),
                  ),
                  icon: const Icon(
                    Symbols.check,
                  ),
                  onPressed: () {
                    // ngay chỗ này cần
                  },
                ),
              )
            ],
          ),
        ));
  }
}
