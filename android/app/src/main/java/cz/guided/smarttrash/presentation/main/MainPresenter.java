package cz.guided.smarttrash.presentation.main;

import android.os.Bundle;

import cz.guided.smarttrash.presentation.Presenter;

public class MainPresenter extends Presenter<MainView> {

    @Override
    protected void onCreate(Bundle savedState) {
        super.onCreate(savedState);
    }

    public void showThrashes() {
        viewIfExists().subscribe(MainView::goToMenu);
    }
}
