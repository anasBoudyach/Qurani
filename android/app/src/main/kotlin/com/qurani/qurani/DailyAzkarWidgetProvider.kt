package com.qurani.qurani

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class DailyAzkarWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.daily_azkar_widget).apply {
                val title = widgetData.getString("azkar_title", "Morning Azkar")
                val arabic = widgetData.getString("azkar_arabic",
                    "\u0623\u064e\u0635\u0652\u0628\u064e\u062d\u0652\u0646\u064e\u0627 \u0648\u064e\u0623\u064e\u0635\u0652\u0628\u064e\u062d\u064e \u0627\u0644\u0652\u0645\u064f\u0644\u0652\u0643\u064f \u0644\u0650\u0644\u0651\u064e\u0647\u0650")
                val repeat = widgetData.getString("azkar_repeat", "")

                setTextViewText(R.id.azkar_title, title)
                setTextViewText(R.id.azkar_arabic, arabic)
                setTextViewText(R.id.azkar_repeat, repeat)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
