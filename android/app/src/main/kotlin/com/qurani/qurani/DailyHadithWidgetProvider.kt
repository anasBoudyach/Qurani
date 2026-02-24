package com.qurani.qurani

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class DailyHadithWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.daily_hadith_widget).apply {
                val hadithText = widgetData.getString("hadith_text",
                    "\u0625\u0650\u0646\u0651\u064e\u0645\u064e\u0627 \u0627\u0644\u0623\u064e\u0639\u0652\u0645\u064e\u0627\u0644\u064f \u0628\u0650\u0627\u0644\u0646\u0651\u0650\u064a\u0651\u064e\u0627\u062a\u0650")
                val collection = widgetData.getString("hadith_collection", "Bukhari")
                val grade = widgetData.getString("hadith_grade", "Sahih")

                setTextViewText(R.id.hadith_text, hadithText)
                setTextViewText(R.id.hadith_collection, collection)
                setTextViewText(R.id.hadith_grade, grade)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
