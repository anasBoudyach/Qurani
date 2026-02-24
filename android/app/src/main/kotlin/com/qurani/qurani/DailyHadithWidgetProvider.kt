package com.qurani.qurani

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
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
                val views = RemoteViews(context.packageName, R.layout.daily_hadith_widget).apply {
                    setTextViewText(R.id.hadith_text,
                        prefs.getString("hadith_text",
                            "\u0625\u0650\u0646\u0651\u064e\u0645\u064e\u0627 \u0627\u0644\u0623\u064e\u0639\u0652\u0645\u064e\u0627\u0644\u064f \u0628\u0650\u0627\u0644\u0646\u0651\u0650\u064a\u0651\u064e\u0627\u062a\u0650"))
                    setTextViewText(R.id.hadith_collection,
                        prefs.getString("hadith_collection", "Bukhari"))
                    setTextViewText(R.id.hadith_grade,
                        prefs.getString("hadith_grade", "Sahih"))
                }
                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (e: Exception) {
                val views = RemoteViews(context.packageName, R.layout.daily_hadith_widget)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
        }
    }
}
