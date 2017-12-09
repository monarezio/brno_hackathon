package cz.guided.smarttrash.presentation.analytics;

import android.app.Activity;
import android.graphics.Color;
import android.os.Bundle;
import android.support.annotation.FloatRange;
import android.support.annotation.Nullable;
import android.util.Log;

import com.github.mikephil.charting.charts.LineChart;
import com.github.mikephil.charting.components.Description;
import com.github.mikephil.charting.data.BarDataSet;
import com.github.mikephil.charting.data.BarEntry;
import com.github.mikephil.charting.data.Entry;
import com.github.mikephil.charting.data.LineData;
import com.github.mikephil.charting.data.LineDataSet;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.jjoe64.graphview.GraphView;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;
import cz.guided.smarttrash.R;
import cz.guided.smarttrash.domain.Trash;
import cz.guided.smarttrash.presentation.thrashes.Adapter;

import static android.content.ContentValues.TAG;

public class AnalyticsActivity extends Activity {
    @BindView(R.id.percentageChart)
    LineChart graphView;

    private DatabaseReference mDatabase;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_analytics);
        ButterKnife.bind(this);
        createGraph();
    }

    private void createGraph() {
        mDatabase = FirebaseDatabase.getInstance().getReference();
        DatabaseReference sortedStuff = mDatabase.child("reading").child("0x1704fd6758284L");

        List<Entry> entries = new ArrayList<Entry>();

        sortedStuff.addListenerForSingleValueEvent(
                new ValueEventListener() {
                    @Override
                    public void onDataChange(DataSnapshot snapshot) {
                        int count = 0;
                        for (DataSnapshot child : snapshot.getChildren()) {
                            System.out.println(child.child("percentage").getValue().toString());
                            entries.add(new Entry(count++, Float.parseFloat(child.child("percentage").getValue().toString())));
                        }
                        LineDataSet dataSet = new LineDataSet(entries, "Trash percentages over time"); // add entries to dataset
                        dataSet.setColor(Color.BLACK);
                        dataSet.setValueTextColor(Color.BLACK);
                        System.out.println(entries.isEmpty());
                        Description desc = new Description();
                        desc.setText("");
                        graphView.setDescription(desc);
                        if (entries.isEmpty()) {
                            graphView.clear();
                        } else {
                            // set data
                            LineData lineData = new LineData(dataSet);
                            graphView.setData(lineData);
                            graphView.invalidate();
                        }
                    }

                    @Override
                    public void onCancelled(DatabaseError databaseError) {
                        Log.w(TAG, "loadPost:onCancelled", databaseError.toException());
                    }
                });
    }
}