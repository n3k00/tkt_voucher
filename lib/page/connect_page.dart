import 'package:bluetooth_print/bluetooth_print.dart';
import 'package:bluetooth_print/bluetooth_print_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tkt_voucher/controller/home_controller.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({super.key});

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  BluetoothPrint bluetoothPrint = BluetoothPrint.instance;
  bool _connected = false;
  BluetoothDevice? _device;
  String tips = "no device connected";
  HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => initBluetooth());
    checkConnect();
  }

  Future<void> initBluetooth() async {
    bluetoothPrint.startScan(timeout: Duration(seconds: 4));

    bool isConnected = await bluetoothPrint.isConnected ?? false;

    bluetoothPrint.state.listen((state) {
      print('******************* cur device status: $state');

      switch (state) {
        case BluetoothPrint.CONNECTED:
          setState(() {
            _connected = true;
            controller.isConnected.value = true;
            print("connect success");
            tips = 'connect success';
          });
          break;
        case BluetoothPrint.DISCONNECTED:
          setState(() {
            _connected = false;
            controller.isConnected.value = false;
            print("disconnect success");
            tips = 'disconnect success';
          });
          break;
        default:
          break;
      }
    });

    if (!mounted) return;

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }

  void checkConnect() async {
    bool? check = await bluetoothPrint.isConnected;
    if (check!) {
      setState(() {
        tips = "Connected";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Printer Demo'),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            bluetoothPrint.startScan(timeout: Duration(seconds: 4)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Text(tips),
                  ),
                ],
              ),
              Divider(),
              StreamBuilder(
                stream: bluetoothPrint.scanResults,
                initialData: [],
                builder: (context, snapshot) {
                  return Column(
                    children: snapshot.data!.map((d) {
                      return ListTile(
                        title: Text(d.name ?? ""),
                        subtitle: Text(d.address ?? ""),
                        onTap: () {
                          setState(() {
                            _device = d;
                          });
                        },
                        trailing:
                            _device != null && _device?.address == d.address
                                ? Icon(
                                    Icons.check,
                                    color: Colors.green,
                                  )
                                : null,
                      );
                    }).toList(),
                  );
                },
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        OutlinedButton(
                          onPressed: _connected
                              ? null
                              : () async {
                                  if (_device != null &&
                                      _device!.address != null) {
                                    setState(() {
                                      tips = 'connecting...';
                                    });
                                    await bluetoothPrint.disconnect();
                                    await bluetoothPrint.connect(_device!);
                                    print(_device?.toJson());
                                  } else {
                                    setState(() {
                                      tips = 'please select device';
                                    });
                                    print('please select device');
                                  }
                                },
                          child: Text('connect'),
                        ),
                        SizedBox(width: 10.0),
                        OutlinedButton(
                          onPressed: _connected
                              ? () async {
                                  setState(() {
                                    tips = 'disconnecting...';
                                  });
                                  await bluetoothPrint.disconnect();
                                }
                              : null,
                          child: Text('disconnect'),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        OutlinedButton(
                          onPressed: () async {
                            setState(() {
                              tips = 'Destroying...';
                            });
                            await bluetoothPrint.destroy();
                          },
                          child: Text('Destroy'),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: StreamBuilder(
        stream: bluetoothPrint.isScanning,
        initialData: false,
        builder: (context, snapshot) {
          if (snapshot.data == true) {
            return FloatingActionButton(
              onPressed: () {
                bluetoothPrint.stopScan();
              },
              backgroundColor: Colors.red,
              child: Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
              onPressed: () {
                print("Scan");
                bluetoothPrint.startScan(timeout: Duration(seconds: 4));
              },
              child: Icon(Icons.search),
            );
          }
        },
      ),
    );
  }
}
