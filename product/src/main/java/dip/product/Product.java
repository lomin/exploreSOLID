package dip.product;

import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;

public class Product {

    private final String brand;
    private List<Renderable> variations = new ArrayList<>();

    public Product(String brand) {
        this.brand = brand;
    }

    public void addVariation(Renderable variation) {
        this.variations.add(variation);
    }

    public void render(Renderer renderer, DateTime time) {
        for (Renderable variation : variations) {
            variation.render(renderer, time, brand);
        }
    }

    public static interface Renderable {
        void render(Renderer r, DateTime time, String brand);
    }

    public static class Renderer {
        public void render(String string) {
            System.out.println(string);
        }
    }

}
