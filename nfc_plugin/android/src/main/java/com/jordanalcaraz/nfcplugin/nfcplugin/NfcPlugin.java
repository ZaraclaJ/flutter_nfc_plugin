package com.jordanalcaraz.nfcplugin.nfcplugin;

import android.annotation.TargetApi;
import android.content.Context;
import android.content.pm.PackageManager;
import android.nfc.NfcAdapter;
import android.os.Build;
import android.util.Log;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * NfcPlugin
 */
public class NfcPlugin implements MethodCallHandler {
    private static final String LOG_TAG = "NfcManager";
    private final Registrar registrar;

    /**
   * Plugin registration.
   */
  public static void registerWith(Registrar registrar) {
    final MethodChannel channel = new MethodChannel(registrar.messenger(), "nfc_plugin");
    channel.setMethodCallHandler(new NfcPlugin(registrar));
  }

  private NfcPlugin(Registrar registrar){
      this.registrar = registrar;
  }

  @TargetApi(Build.VERSION_CODES.GINGERBREAD_MR1)
  @Override
  public void onMethodCall(MethodCall call, Result result) {
      if (call.method.equals("isSupported")) {
          Log.d(LOG_TAG, "isSupported");
          boolean isSupported = this.registrar.context().getPackageManager().hasSystemFeature(PackageManager.FEATURE_NFC);
          result.success(isSupported);
      } else if (call.method.equals("isEnable")) {
          Log.d(LOG_TAG, "isAvailable");
          NfcAdapter nfcAdapter = NfcAdapter.getDefaultAdapter(this.registrar.context());
          if (nfcAdapter != null) {
              result.success(nfcAdapter.isEnabled());
          } else {
              result.success(false);
          }
      }
      else {
          result.notImplemented();
      }
  }
}
