package dip.claim;

import org.joda.time.DateTime;

public class Claim {

    private final DateTime date;
    private final String template;

    public Claim(String template, DateTime dateTime) {
        this.template = template;
        this.date = dateTime;
    }

    public DateTime getDate() {
        return date;
    }

    public void render(ClaimRenderer renderer, DateTime time, int price, String brand) {
        renderer.render(
                template
                        .replaceAll("#year#", String.valueOf(time.getYear()))
                        .replaceAll("#price#", String.valueOf(price) + "€")
                        .replaceAll("#brand#", brand));
    }

    public static interface ClaimRenderer {

        void render(String string);
    }
}
