package cz.guided.smarttrash.presentation.menu;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import butterknife.ButterKnife;
import butterknife.OnClick;
import cz.guided.smarttrash.R;
import cz.guided.smarttrash.presentation.analytics.AnalyticsActivity;
import cz.guided.smarttrash.presentation.thrashes.TrashesActivity;

public class MenuActivity extends Activity {
    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu);
        ButterKnife.bind(this);
    }

    @OnClick(R.id.trashesMenu)
    public void goToTrashes() {
        Intent intent = new Intent(this, TrashesActivity.class);
        startActivity(intent);
    }

    @OnClick(R.id.analyticsMenu)
    public void goToAnalytics() {
        Intent intent = new Intent(this, AnalyticsActivity.class);
        startActivity(intent);
    }

}
