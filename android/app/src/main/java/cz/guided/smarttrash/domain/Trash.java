package cz.guided.smarttrash.domain;

public class Trash {

    private String mac;
    private int percentage;
    private boolean finished;

    public Trash(String mac, int percentage, boolean finished) {
        this.mac = mac;
        this.percentage = percentage;
        this.finished = finished;
    }

    public String getMac() {
        return mac;
    }

    public int getPercentage() {
        return percentage;
    }

    public boolean isFinished() {
        return finished;
    }
}
