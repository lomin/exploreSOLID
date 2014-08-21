package dip.variation;

import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;
import dip.product.Product;

public class Variation implements Product.Renderable {

    private List<Renderable> claims = new ArrayList<>();
    private int price = 0;

    public void addClaim(Renderable claim) {
        this.claims.add(claim);
    }

    public void setPrice(int price) {
        this.price = price;
    }

    @Override
    public void render(Product.Renderer r, DateTime time, String brand) {
        for (Renderable claim : claims) {
            claim.render(r, time, price, brand);
        }
    }

    public static interface Renderable {
        void render(Product.Renderer renderer, DateTime time, int price, String brand);
    }
}
