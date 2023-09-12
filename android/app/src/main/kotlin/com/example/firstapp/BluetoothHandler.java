package com.example.firstapp; // Replace with your Flutter package name

import android.bluetooth.BluetoothAdapter;
import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry;

public class BluetoothHandler implements MethodChannel.MethodCallHandler {
    private final Context context;
    private final MethodChannel methodChannel;
    private final BluetoothAdapter bluetoothAdapter;

    public static void registerWith(PluginRegistry.Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), "bluetooth_handler");
        channel.setMethodCallHandler(new BluetoothHandler(registrar.context(), channel));
    }

    private BluetoothHandler(Context context, MethodChannel methodChannel) {
        this.context = context;
        this.methodChannel = methodChannel;
        this.bluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
    }

    @Override
    public void onMethodCall(MethodCall call, MethodChannel.Result result) {
        switch (call.method) {
            case "initBluetooth":
                initializeBluetooth(result);
                break;
            default:
                result.notImplemented();
        }
    }

    private void initializeBluetooth(MethodChannel.Result result) {
        if (bluetoothAdapter == null) {
            result.error("BLUETOOTH_UNSUPPORTED", "Bluetooth is not supported on this device.", null);
            return;
        }

        if (!context.getPackageManager().hasSystemFeature(PackageManager.FEATURE_BLUETOOTH_LE)) {
            result.error("BLUETOOTH_LE_UNSUPPORTED", "Bluetooth Low Energy is not supported on this device.", null);
            return;
        }

        if (!bluetoothAdapter.isEnabled()) {
            Intent enableBtIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            // You might want to startActivityForResult and handle the result
            context.startActivity(enableBtIntent);
        }

        result.success("Bluetooth initialized");
    }
}
