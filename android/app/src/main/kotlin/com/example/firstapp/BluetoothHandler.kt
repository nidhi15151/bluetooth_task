import android.bluetooth.BluetoothAdapter
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.PluginRegistry

class BluetoothHandler(private val context: Context, private val methodChannel: MethodChannel) : MethodChannel.MethodCallHandler {
    private val bluetoothAdapter: BluetoothAdapter? = BluetoothAdapter.getDefaultAdapter()

    companion object {
        fun registerWith(registrar: PluginRegistry.Registrar) {
            val channel = MethodChannel(registrar.messenger(), "bluetooth_handler")
            channel.setMethodCallHandler(BluetoothHandler(registrar.context(), channel))
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "initBluetooth" -> initializeBluetooth(result)
            else -> result.notImplemented()
        }
    }

    private fun initializeBluetooth(result: MethodChannel.Result) {
        if (bluetoothAdapter == null) {
            result.error("BLUETOOTH_UNSUPPORTED", "Bluetooth is not supported on this device.", null)
            return
        }

        if (!context.packageManager.hasSystemFeature(PackageManager.FEATURE_BLUETOOTH_LE)) {
            result.error("BLUETOOTH_LE_UNSUPPORTED", "Bluetooth Low Energy is not supported on this device.", null)
            return
        }

        if (!bluetoothAdapter.isEnabled) {
            val enableBtIntent = Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE)
            // You might want to startActivityForResult and handle the result
            context.startActivity(enableBtIntent)
        }

        result.success("Bluetooth initialized")
    }
}
