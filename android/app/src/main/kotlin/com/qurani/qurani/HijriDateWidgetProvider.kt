package com.qurani.qurani

import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.Context
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
                val views = RemoteViews(context.packageName, R.layout.hijri_date_widget).apply {
                    setTextViewText(R.id.hijri_date,
                        prefs.getString("hijri_date", "1 Muharram 1447 AH"))
                    setTextViewText(R.id.hijri_date_arabic,
                        prefs.getString("hijri_date_arabic",
                            "\u0661 \u0645\u062d\u0631\u0645 \u0661\u0664\u0664\u0637 \u0647\u0640"))
                    setTextViewText(R.id.next_event,
                        prefs.getString("next_event_text", ""))
                }
                appWidgetManager.updateAppWidget(widgetId, views)
            } catch (e: Exception) {
                val views = RemoteViews(context.packageName, R.layout.hijri_date_widget)
                appWidgetManager.updateAppWidget(widgetId, views)
            }
        }
    }
}
