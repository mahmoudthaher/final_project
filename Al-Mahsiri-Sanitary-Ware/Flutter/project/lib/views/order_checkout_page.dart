// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:im_stepper/stepper.dart';
import 'package:project/Providers/order_provider.dart';
import 'package:project/Providers/product_provider.dart';
import 'package:project/controllers/order_controller.dart';
import 'package:project/models/address_model.dart';
import 'package:project/models/order.dart';
import 'package:project/views/summery_widget.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class OrderCheckoutPage extends StatefulWidget {
  Position location;
  OrderCheckoutPage(this.location, {super.key});

  @override
  State<OrderCheckoutPage> createState() => _OrderCheckoutPageState();
}

class _OrderCheckoutPageState extends State<OrderCheckoutPage> {
  int upperBound = 4;
  @override
  void initState() {
    super.initState();
    setState(() {
      Provider.of<OrderProvider>(context, listen: false).activeStep;
    });
  }

  @override
  Widget build(BuildContext context) {
    var activeStep =
        Provider.of<OrderProvider>(context, listen: false).activeStep;
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: const Icon(
              Icons.cancel,
              size: 30,
            ),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          title: Container(
              margin: const EdgeInsets.only(left: 30),
              child: const Center(child: Text('ملخص الطلب'))),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/2.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                IconStepper(
                  icons: const [
                    Icon(Icons.location_on_rounded),
                    Icon(Icons.location_on_rounded),
                    Icon(Icons.payment_rounded),
                    Icon(Icons.summarize)
                  ],
                  //  lineColor: Colors.red,
                  stepColor: Colors.transparent,

                  activeStepColor: Colors.transparent,
                  activeStepBorderColor: Colors.black,
                  activeStepBorderWidth: 2.0,
                  enableNextPreviousButtons: false,
                  lineLength: 35,
                  activeStep: activeStep,
                  // activeStepBorderColor: Colors.transparent,
                  //activeStepBorderColor: Colors.transparent,
                  onStepReached: (index) {
                    setState(() {
                      activeStep = index;
                    });
                  },
                ),
                Expanded(
                    child: IndexedStack(
                  index: activeStep,
                  children: [
                    GoogleMapStep(widget.location),
                    AddressFormStep(),
                    const PaymentMethodStep(),
                    SummeryStep(),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    children: [
                      previousButton(),
                      const SizedBox(
                        width: 165,
                      ),
                      nextButton(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  Widget nextButton() {
    int activeStep = Provider.of<OrderProvider>(context).activeStep;
    return SizedBox(
      width: 100,
      height: 50,
      child: InkWell(
        onTap: () {
          var productProvider =
              Provider.of<ProductProvider>(context, listen: false);
          switch (activeStep) {
            case 0:
              setState(() {
                Provider.of<OrderProvider>(context, listen: false)
                    .updateActiveStep(++activeStep);
              });

              break;
            case 1:
              if (productProvider.keyForm.currentState!.validate()) {
                setState(() {
                  Provider.of<OrderProvider>(context, listen: false)
                      .updateActiveStep(++activeStep);
                });
              }
              break;
            case 2:
              setState(() {
                Provider.of<OrderProvider>(context, listen: false)
                    .updateActiveStep(++activeStep);
              });
              break;
            case 3:
              OrderController()
                  .create(Order(
                      products: productProvider.selectedProducts,
                      address: productProvider.address,
                      paymentMethodId: productProvider.paymentMethod,
                      total: productProvider.total,
                      taxAmount: productProvider.taxAmount,
                      subTotal: productProvider.subTotal))
                  .then((value) {
                EasyLoading.dismiss();
                EasyLoading.showSuccess("تم انشاء الطلب يمكنك رؤيته في طلباتي");
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .country = "الاردن";
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .city = "";
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .area = "";
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .street = "";
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .buildingNo = "";
                Provider.of<ProductProvider>(context, listen: false)
                    .selectedProducts
                    .clear();
                Provider.of<OrderProvider>(context, listen: false).activeStep =
                    0;
                Navigator.pushNamedAndRemoveUntil(
                    context, "/bottomnavigation", (route) => false);
              }).catchError((ex) {
                EasyLoading.dismiss();
                EasyLoading.showError(ex.toString());
              });
              break;
          }
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Center(
            child: Text(
              'التالي',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget previousButton() {
    return SizedBox(
      width: 100,
      height: 50,
      child: InkWell(
        onTap:
            Provider.of<OrderProvider>(context, listen: false).activeStep == 0
                ? null
                : () {
                    var activeStep =
                        Provider.of<OrderProvider>(context, listen: false)
                            .activeStep;

                    if (activeStep > 0) {
                      setState(() {
                        Provider.of<OrderProvider>(context, listen: false)
                            .updateActiveStep(--activeStep);
                      });
                    }
                  },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black,
              width: 3.0,
            ),
            borderRadius: BorderRadius.circular(40),
          ),
          child: const Center(
            child: Text(
              'السابق',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}

class GoogleMapStep extends StatefulWidget {
  Position location;

  GoogleMapStep(this.location, {super.key});

  @override
  State<GoogleMapStep> createState() => _GoogleMapStepState();
}

class _GoogleMapStepState extends State<GoogleMapStep> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  late CameraPosition _initalPostion;
  late LatLng _requiredLocation;

  @override
  void initState() {
    super.initState();

    _initalPostion = CameraPosition(
      target: LatLng(widget.location.latitude, widget.location.longitude),
      zoom: 16,
    );
    _requiredLocation =
        LatLng(widget.location.latitude, widget.location.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return mapWidget();
  }

  Widget mapWidget() {
    double mapWidth = MediaQuery.of(context).size.width;
    double mapHeight = MediaQuery.of(context).size.height - 303;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: const Text(
              "اذا كنت تريد تعبئة المعلومات الموقع بشكل يدوي انقر هنا",
              maxLines: 1,
              style: TextStyle(
                  fontSize: 16, color: Colors.red, fontWeight: FontWeight.w600),
            ),
            onTap: () {
              setState(() {
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .country = "الاردن";
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .city = "";
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .area = "";
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .street = "";
                Provider.of<ProductProvider>(context, listen: false)
                    .address
                    .buildingNo = "";
              });

              Provider.of<ProductProvider>(context, listen: false)
                  .selectedProducts;
              var activeStep =
                  Provider.of<OrderProvider>(context, listen: false).activeStep;
              setState(() {
                Provider.of<OrderProvider>(context, listen: false)
                    .updateActiveStep(++activeStep);
              });
            },
          ),
        ),
        Stack(alignment: const Alignment(0.0, 0.0), children: <Widget>[
          SizedBox(
              width: mapWidth,
              height: mapHeight,
              child: GoogleMap(
                mapType: MapType.hybrid,
                myLocationEnabled: true,
                initialCameraPosition: _initalPostion,
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
                onCameraMove: (CameraPosition position) {
                  _requiredLocation = position.target;
                },
                onCameraIdle: () {
                  _getAddressFromLatLng();
                },
              )),
          Positioned(
            top: (mapHeight - 50) / 2,
            right: (mapWidth - 50) / 2,
            child: const Icon(
              Icons.location_on,
              size: 50,
              color: Colors.red,
            ),
          ),
        ]),
      ],
    );
  }

  Future<void> _getAddressFromLatLng() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        _requiredLocation.latitude, _requiredLocation.longitude);

    Placemark first = placemarks.first;

    AddressModel address = AddressModel();
    address.latitude = _requiredLocation.latitude;
    address.longitude = _requiredLocation.longitude;
    address.country = first.country!;
    address.city = first.locality!;
    address.area = first.subLocality!;
    address.street = first.street!;
    address.buildingNo = "";

    var productProvider = Provider.of<ProductProvider>(context, listen: false);
    productProvider.updateAddress(address);
  }
}

class AddressFormStep extends StatelessWidget {
  AddressFormStep({super.key});
  final _controllerCountry = TextEditingController();
  final _controllerCity = TextEditingController();
  final _controllerArea = TextEditingController();
  final _controllerStreet = TextEditingController();
  final _controllerBuilding = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Consumer(
              builder: (context, ProductProvider productProvider, child) {
            return formWidget(productProvider);
          }),
        ),
      ),
    );
  }

  Widget formWidget(ProductProvider productProvier) {
    _controllerCountry.text = productProvier.address.country;
    _controllerCity.text = productProvier.address.city;
    _controllerArea.text = productProvier.address.area;
    _controllerStreet.text = productProvier.address.street;
    _controllerBuilding.text = productProvier.address.buildingNo;

    return Form(
      key: productProvier.keyForm,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: TextFormField(
                controller: _controllerCountry,
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(
                    fontSize: 20, height: 2, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.name,
                cursorHeight: 50,
                cursorWidth: 2,
                onChanged: (value) {
                  productProvier.address.country = value;
                },
                decoration: const InputDecoration(
                  hintText: "الدولة",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  errorStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "رجاء ادخال الدولة";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: TextFormField(
                controller: _controllerCity,
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(
                    fontSize: 20, height: 2, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.name,
                cursorHeight: 50,
                cursorWidth: 2,
                onChanged: (value) {
                  productProvier.address.city = value;
                },
                decoration: const InputDecoration(
                  hintText: "المدينة ",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  errorStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء ادخال المدينة";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: TextFormField(
                controller: _controllerArea,
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(
                    fontSize: 20, height: 2, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.name,
                cursorHeight: 50,
                cursorWidth: 2,
                onChanged: (value) {
                  productProvier.address.area = value;
                },
                decoration: const InputDecoration(
                  hintText: "المنطقة ",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  errorStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء ادخال المنطقة";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: TextFormField(
                controller: _controllerStreet,
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(
                    fontSize: 20, height: 2, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.name,
                cursorHeight: 50,
                cursorWidth: 2,
                onChanged: (value) {
                  productProvier.address.street = value;
                },
                decoration: const InputDecoration(
                  hintText: "الشارع",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  errorStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء ادخال الشارع ";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 100,
              child: TextFormField(
                controller: _controllerBuilding,
                maxLength: 20,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: const TextStyle(
                    fontSize: 20, height: 2, fontWeight: FontWeight.w500),
                keyboardType: TextInputType.name,
                cursorHeight: 50,
                cursorWidth: 2,
                onChanged: (value) {
                  productProvier.address.buildingNo = value;
                },
                decoration: const InputDecoration(
                  hintText: "رقم البناية",
                  hintStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(40),
                    ),
                  ),
                  errorStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.w700),
                  counterText: '',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "الرجاء ادخال رقم البناية";
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentMethodStep extends StatelessWidget {
  const PaymentMethodStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ProductProvider productProvier, child) {
      return Column(children: [
        Card(
          color: const Color.fromARGB(255, 241, 239, 239),
          child: ListTile(
            onTap: () {
              productProvier.updatePaymentMethod(1);
            },
            leading: const Icon(
              Icons.attach_money_outlined,
              color: Colors.green,
            ),
            title: const Text("الدفع عند الاستلام"),
            trailing: Radio<int>(
              value: 1,
              groupValue: productProvier.paymentMethod,
              onChanged: (value) {
                productProvier.updatePaymentMethod(value!);
              },
              activeColor: Colors.black,
            ),
          ),
        ),
      ]);
    });
  }
}

class SummeryStep extends StatelessWidget {
  const SummeryStep({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child:
            Consumer(builder: (context, ProductProvider productProvier, child) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "الملخص",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 20),
                _addressWidget(productProvier),
                const SizedBox(height: 20),
                SummeryWidget()
              ]);
        }),
      ),
    );
  }
}

Widget _addressWidget(ProductProvider productProvier) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text(
        "عنوان التسليم",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("البلد",
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
          Text(productProvier.address.country,
              style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600))
        ],
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("المدينة",
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
          Text(productProvier.address.city,
              style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600))
        ],
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("المنطقة",
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
          Text(productProvier.address.area,
              style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600))
        ],
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("الشارع",
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
          Text(productProvier.address.street,
              style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600))
        ],
      ),
      const SizedBox(height: 3),
      const Divider(),
      const SizedBox(height: 3),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("رقم البناية",
              style: TextStyle(
                  fontSize: 19,
                  color: Colors.black,
                  fontWeight: FontWeight.w600)),
          Text(productProvier.address.buildingNo,
              style: const TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w600))
        ],
      )
    ],
  );
}
