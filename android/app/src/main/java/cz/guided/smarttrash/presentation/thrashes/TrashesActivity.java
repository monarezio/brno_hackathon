package cz.guided.smarttrash.presentation.thrashes;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.Log;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.util.ArrayList;
import java.util.List;

import butterknife.ButterKnife;
import cz.guided.smarttrash.R;
import cz.guided.smarttrash.domain.Trash;
import cz.guided.smarttrash.presentation.analytics.AnalyticsActivity;

import static android.content.ContentValues.TAG;

public class TrashesActivity extends Activity {

    private RecyclerView mRecyclerView;
    private CustomAdapter mAdapter;
    private RecyclerView.LayoutManager mLayoutManager;

    private DatabaseReference mDatabase;

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
        Trash trash = new Trash("xddddd", 60);
        Trash trash1 = new Trash("AAAAAAAAAAAA", 0);
        trashList.add(trash);
        trashList.add(trash1);
// ...
        mDatabase = FirebaseDatabase.getInstance().getReference();

        DatabaseReference sortedStuff = mDatabase.child("analysis").child("sorted");

        sortedStuff.addValueEventListener(
                new ValueEventListener() {
                    @Override
                    public void onDataChange(DataSnapshot snapshot) {
                        trashList.clear();
                        for (DataSnapshot child : snapshot.getChildren()) {
                            String keyControl = child.getKey();
                            System.out.println(keyControl);
                            Trash tmp = new Trash(keyControl, (int) Float.parseFloat(child.child("percentage").getValue().toString()));
                            trashList.add(tmp);
                        }
                        mAdapter = new CustomAdapter(trashList, getApplicationContext());
                        mAdapter.setOnClickListener(position -> {
                            showTrash(mAdapter.getTrashes().get(position).getMac());
                        });
                        mRecyclerView.setAdapter(mAdapter);
                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {
                        Log.w(TAG, "loadPost:onCancelled", databaseError.toException());
                    }
                });

        mAdapter = new CustomAdapter(trashList, this);
        mRecyclerView.setAdapter(mAdapter);
    }

    private void showTrash(String mac) {
        Intent intent1 = new Intent(this, AnalyticsActivity.class);
        System.out.println(mac);
        intent1.putExtra("mac", mac);
        startActivity(intent1);
    }
}
