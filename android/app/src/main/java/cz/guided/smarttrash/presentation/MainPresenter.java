package cz.guided.smarttrash.presentation;

import android.os.Bundle;

public class MainPresenter extends Presenter<MainView> {

    @Override
    protected void onCreate(Bundle savedState) {
        super.onCreate(savedState);
    }

    public void login() {
        viewIfExists().subscribe(view -> {
            view.login();
        });
    }
}
