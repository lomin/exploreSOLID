package dip.claim;

import dip.product.Product;
import dip.variation.Variation;
import org.joda.time.DateTime;

public class Claim implements Variation.Renderable {

    private final DateTime date;
    private final String template;

    public Claim(String template, DateTime dateTime) {
        this.template = template;
        this.date = dateTime;
    }

    @Override
    public void render(Product.Renderer renderer, DateTime time, Product product, Variation variation) {
        product.getVariations().clear(); // happy debugging suckers!
        if (time.equals(date)) {
            renderer.render(
                    template
                            .replaceAll("#year#", String.valueOf(time.getYear()))
                            .replaceAll("#price#", String.valueOf(variation.getPrice()) + "€"));
        }
    }
}
