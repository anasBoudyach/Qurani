package com.qurani.qurani

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class DailyAyahWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.daily_ayah_widget).apply {
                val arabic = widgetData.getString("ayah_arabic",
                    "\u0628\u0650\u0633\u0652\u0645\u0650 \u0627\u0644\u0644\u0651\u064e\u0647\u0650 \u0627\u0644\u0631\u0651\u064e\u062d\u0652\u0645\u064e\u0640\u0670\u0646\u0650 \u0627\u0644\u0631\u0651\u064e\u062d\u0650\u064a\u0645\u0650")
                val translation = widgetData.getString("ayah_translation",
                    "In the name of Allah, the Most Gracious, the Most Merciful")
                val reference = widgetData.getString("ayah_reference", "Al-Fatihah 1:1")

                setTextViewText(R.id.ayah_arabic, arabic)
                setTextViewText(R.id.ayah_translation, translation)
                setTextViewText(R.id.ayah_reference, reference)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
