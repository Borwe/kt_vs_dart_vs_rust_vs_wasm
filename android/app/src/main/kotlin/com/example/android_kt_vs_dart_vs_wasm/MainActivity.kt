package com.example.android_kt_vs_dart_vs_wasm

import android.os.Bundle
import android.os.PersistableBundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant


val primesInRange = hashMapOf<Int,Int>(
    100 to  25,
    1000 to  168,
    10000 to  1229,
    100000 to  9592
);

class MainActivity: FlutterActivity() {

    val CHANNEL = "com.borwe.primes";

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{ methodCall, result->
            if(methodCall.method == "getPrimesCount"){
                val end = methodCall.argument<Int>("end")
                result.success(end?.let { getPrimesCount(it) })
            }
        }
    }

    companion object {
        private fun getPrimesTill(end: Int): Int{
            var primes: ArrayList<Int> = arrayListOf(2);
            var factos: ArrayList<Int> = arrayListOf<Int>()

            var i: Int = 3;
            while(i < end){
                var isPrime = true

                for(j in factos){
                    if(j == i){
                        isPrime=false
                        break;
                    }
                }

                if(isPrime){
                    var j = 3;
                    while(j<end){
                        if(j*i <= end){
                            factos.add(j*i)
                        }
                        j += 2;
                    }
                    primes.add(i)
                }
                i += 2
            }

            return primes.size
        }

        fun getPrimesCount(end: Int): Int{
            var count = 0;
            val now = System.currentTimeMillis()
            val finish = now +(5*1000)
            while(System.currentTimeMillis()<finish){
                val result = getPrimesTill(end)
                assert(result == primesInRange[end])
                count += 1
            }
            return count
        }
    }
}
