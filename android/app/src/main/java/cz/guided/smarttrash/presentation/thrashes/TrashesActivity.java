package cz.guided.smarttrash.presentation.thrashes;

import android.app.Activity;
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
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import butterknife.ButterKnife;
import cz.guided.smarttrash.R;
import cz.guided.smarttrash.domain.Trash;

import static android.content.ContentValues.TAG;

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
        GetItems();
        mAdapter = new Adapter(trashList, this);
        mRecyclerView.setAdapter(mAdapter);
    }

    List<Trash> GetItems(){
        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference reference = database.getReference();

        reference.addValueEventListener((new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                Object value = dataSnapshot.getValue();
                HashMap<String, Object> hashMap = (HashMap<String, Object>)value;
                Set set = hashMap.entrySet();
                Iterator iterator = set.iterator();
                while(iterator.hasNext()) {
                    Map.Entry mentry = (Map.Entry)iterator.next();
                    String uniqueId = (String)mentry.getKey();
                    Log.d(TAG, uniqueId);
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        }));

        return new ArrayList<Trash>();
    }
}
