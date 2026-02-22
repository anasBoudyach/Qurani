package com.qurani.qurani

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class PrayerTimeWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.prayer_time_widget).apply {
                val prayerName = widgetData.getString("prayer_name", "Dhuhr")
                val prayerTime = widgetData.getString("prayer_time", "12:30 PM")
                val countdown = widgetData.getString("prayer_countdown", "")

                setTextViewText(R.id.prayer_name, prayerName)
                setTextViewText(R.id.prayer_time, prayerTime)
                setTextViewText(R.id.prayer_countdown, countdown)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
