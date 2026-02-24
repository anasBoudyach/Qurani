package com.qurani.qurani

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider

class HijriDateWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.hijri_date_widget).apply {
                val hijriDate = widgetData.getString("hijri_date", "1 Muharram 1447 AH")
                val hijriDateArabic = widgetData.getString("hijri_date_arabic", "\u0661 \u0645\u062d\u0631\u0645 \u0661\u0664\u0664\u0667 \u0647\u0640")
                val nextEvent = widgetData.getString("next_event_text", "")

                setTextViewText(R.id.hijri_date, hijriDate)
                setTextViewText(R.id.hijri_date_arabic, hijriDateArabic)
                setTextViewText(R.id.next_event, nextEvent)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
