package com.qurani.qurani

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
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
                val views = RemoteViews(context.packageName, R.layout.daily_azkar_widget).apply {
                    setTextViewText(R.id.azkar_title,
                        prefs.getString("azkar_title", "Morning Azkar"))
                    setTextViewText(R.id.azkar_arabic,
                        prefs.getString("azkar_arabic",
                            "\u0623\u064e\u0635\u0652\u0628\u064e\u062d\u0652\u0646\u064e\u0627 \u0648\u064e\u0623\u064e\u0635\u0652\u0628\u064e\u062d\u064e \u0627\u0644\u0652\u0645\u064f\u0644\u0652\u0643\u064f \u0644\u0650\u0644\u0651\u064e\u0647\u0650"))
                    setTextViewText(R.id.azkar_repeat,
                        prefs.getString("azkar_repeat", ""))
                }
                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (e: Exception) {
                val views = RemoteViews(context.packageName, R.layout.daily_azkar_widget)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
        }
    }
}
