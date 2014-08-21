package dip.variation;

import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;
import dip.product.Product;

public class Variation implements Product.Renderable {

    private List<Renderable> claims = new ArrayList<>();

    private int price = 0;

    public int getPrice() {
        return price;
    }

    public void addClaim(Renderable claim) {
        this.claims.add(claim);
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public void render(Product.Renderer r, DateTime time, Product product) {
        for (Renderable claim : claims) {
            claim.render(r, time, product, this);
        }
    }

    public static interface Renderable {
        void render(Product.Renderer renderer, DateTime time, Product product, Variation variation);
    }
}
