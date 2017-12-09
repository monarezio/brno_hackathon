package cz.guided.smarttrash.presentation.thrashes;

import android.content.Context;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import java.util.List;

import cz.guided.smarttrash.R;
import cz.guided.smarttrash.domain.Trash;


public class CustomAdapter extends RecyclerView.Adapter<CustomAdapter.ViewHolder> {
    private List<Trash> trashes;
    private RecyclerViewListener mListener = null;
    private int color1;
    private int color2;

    // Provide a reference to the views for each data item
    // Complex data items may need more than one view per item, and
    // you provide access to all the views for a data item in a view holder
    public static class ViewHolder extends RecyclerView.ViewHolder {
        // each data item is just a string in this case
        public TextView title;
        public TextView desc;

        public ViewHolder(View v) {
            super(v);
            desc = (TextView) itemView.findViewById(R.id.desc);
            title = (TextView) itemView.findViewById(R.id.title);
        }
    }

    // Provide a suitable constructor (depends on the kind of dataset)
    public CustomAdapter(List<Trash> trashesDataset, Context context) {
        trashes = trashesDataset;
        color1 = context.getResources().getColor(R.color.colorPrimary);
        color2 = context.getResources().getColor(R.color.colorPrimaryDark);
    }

    // Create new views (invoked by the layout manager)
    @Override
    public CustomAdapter.ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        // create a new view
        View itemView = LayoutInflater.from(parent.getContext())
                .inflate(R.layout.list_item, parent, false);
        // set the view's size, margins, paddings and layout parameters

        return new ViewHolder(itemView);
    }

    // Replace the contents of a view (invoked by the layout manager)
    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        // - get element from your dataset at this position
        // - replace the contents of the view with that element
        holder.itemView.setBackgroundColor(position % 2 == 0 ? color1 : color2);
        holder.title.setText(trashes.get(position).getMac());
        holder.desc.setText((trashes.get(position).getPercentage()) + "%");
        holder.itemView.setOnClickListener(v -> {
            if (mListener != null) {
                mListener.OnClickListener(position);
            }
        });
    }

    // Return the size of your dataset (invoked by the layout manager)
    @Override
    public int getItemCount() {
        return trashes.size();
    }

    public void setOnClickListener(RecyclerViewListener listener) {
        this.mListener = listener;
    }

    public List<Trash> getTrashes() {
        return trashes;
    }
}