package cz.guided.smarttrash.domain;

public class Trash {

    private String mac;
    private int percentage;

    public Trash(String mac, int percentage) {
        this.mac = mac;
        this.percentage = percentage;
    }

    public String getMac() {
        return mac;
    }

    public int getPercentage() {
        return percentage;
    }

}
