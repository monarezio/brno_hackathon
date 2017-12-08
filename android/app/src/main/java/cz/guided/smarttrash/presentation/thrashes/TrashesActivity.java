package cz.guided.smarttrash.presentation.thrashes;

import android.app.Activity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.widget.EditText;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import cz.guided.smarttrash.R;
import cz.guided.smarttrash.domain.Trash;

public class TrashesActivity extends Activity {

    private RecyclerView mRecyclerView;
    private RecyclerView.Adapter mAdapter;
    private RecyclerView.LayoutManager mLayoutManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_trashes);
        ButterKnife.bind(this);
        mRecyclerView = (RecyclerView) findViewById(R.id.trashes_list);

        // use this setting to improve performance if you know that changes
        // in content do not change the layout size of the RecyclerView
        mRecyclerView.setHasFixedSize(true);

        // use a linear layout manager
        mLayoutManager = new LinearLayoutManager(this);
        mRecyclerView.setLayoutManager(mLayoutManager);

        // specify an adapter (see also next example)
        List<Trash> trashList = new ArrayList<>();
        Trash trash = new Trash("xddddd", 60, false);
        Trash trash1 = new Trash("AAAAAAAAAAAA", 0, true);
        trashList.add(trash);
        trashList.add(trash1);
        mAdapter = new Adapter(trashList, this);
        mRecyclerView.setAdapter(mAdapter);
    }
}
