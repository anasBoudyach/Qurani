package com.qurani.qurani

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class HijriDateWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        val prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)

        appWidgetIds.forEach { widgetId ->
            try {
                val intent = Intent(context, MainActivity::class.java).apply {
                    putExtra("navigate_to", "hijri")
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                }
                val pendingIntent = PendingIntent.getActivity(
                    context, widgetId, intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )

                val views = RemoteViews(context.packageName, R.layout.hijri_date_widget).apply {
                    setTextViewText(R.id.hijri_date,
                        prefs.getString("hijri_date", "1 Muharram 1447 AH"))
                    setTextViewText(R.id.hijri_date_arabic,
                        prefs.getString("hijri_date_arabic",
                            "\u0661 \u0645\u062d\u0631\u0645 \u0661\u0664\u0664\u0637 \u0647\u0640"))
                    setTextViewText(R.id.next_event,
                        prefs.getString("next_event_text", ""))
                    setOnClickPendingIntent(R.id.widget_root, pendingIntent)
                }
                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (e: Exception) {
                val views = RemoteViews(context.packageName, R.layout.hijri_date_widget)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
        }
    }
}
