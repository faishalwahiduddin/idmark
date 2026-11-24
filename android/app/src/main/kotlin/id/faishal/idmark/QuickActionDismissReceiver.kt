package id.faishal.idmark

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class QuickActionDismissReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent?) {
        QuickActionNotificationManager.hide(context)
    }
}
