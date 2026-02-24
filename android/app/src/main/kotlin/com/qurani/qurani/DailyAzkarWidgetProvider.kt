package com.qurani.qurani

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class DailyAzkarWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        val prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)

        appWidgetIds.forEach { widgetId ->
            try {
                val intent = Intent(context, MainActivity::class.java).apply {
                    putExtra("navigate_to", "azkar")
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                }
                val pendingIntent = PendingIntent.getActivity(
                    context, widgetId, intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )

                val views = RemoteViews(context.packageName, R.layout.daily_azkar_widget).apply {
                    setTextViewText(R.id.azkar_title,
                        prefs.getString("azkar_title", "Morning Azkar"))
                    setTextViewText(R.id.azkar_arabic,
                        prefs.getString("azkar_arabic",
                            "\u0623\u064e\u0635\u0652\u0628\u064e\u062d\u0652\u0646\u064e\u0627 \u0648\u064e\u0623\u064e\u0635\u0652\u0628\u064e\u062d\u064e \u0627\u0644\u0652\u0645\u064f\u0644\u0652\u0643\u064f \u0644\u0650\u0644\u0651\u064e\u0647\u0650"))
                    setTextViewText(R.id.azkar_repeat,
                        prefs.getString("azkar_repeat", ""))
                    setOnClickPendingIntent(R.id.widget_root, pendingIntent)
                }
                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (e: Exception) {
                val views = RemoteViews(context.packageName, R.layout.daily_azkar_widget)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
        }
    }
}
