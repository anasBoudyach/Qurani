package com.qurani.qurani

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
import android.content.Intent
import android.widget.RemoteViews

class DailyHadithWidgetProvider : AppWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray
    ) {
        val prefs = context.getSharedPreferences("HomeWidgetPreferences", Context.MODE_PRIVATE)

        appWidgetIds.forEach { widgetId ->
            try {
                val intent = Intent(context, MainActivity::class.java).apply {
                    putExtra("navigate_to", "ahadith")
                    flags = Intent.FLAG_ACTIVITY_NEW_TASK or Intent.FLAG_ACTIVITY_CLEAR_TOP
                }
                val pendingIntent = PendingIntent.getActivity(
                    context, widgetId, intent,
                    PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
                )

                val views = RemoteViews(context.packageName, R.layout.daily_hadith_widget).apply {
                    setTextViewText(R.id.hadith_text,
                        prefs.getString("hadith_text",
                            "\u0625\u0650\u0646\u0651\u064e\u0645\u064e\u0627 \u0627\u0644\u0623\u064e\u0639\u0652\u0645\u064e\u0627\u0644\u064f \u0628\u0650\u0627\u0644\u0646\u0651\u0650\u064a\u0651\u064e\u0627\u062a\u0650"))
                    setTextViewText(R.id.hadith_collection,
                        prefs.getString("hadith_collection", "Bukhari"))
                    setTextViewText(R.id.hadith_grade,
                        prefs.getString("hadith_grade", "Sahih"))
                    setOnClickPendingIntent(R.id.widget_root, pendingIntent)
                }
                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (e: Exception) {
                val views = RemoteViews(context.packageName, R.layout.daily_hadith_widget)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
        }
    }
}
