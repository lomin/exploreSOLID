package dip.product;

import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;

public class Product {

    private List<Renderable> variations = new ArrayList<>();

    public List<Renderable> getVariations() {
        return variations;
    }

    public void addVariation(Renderable variation) {
        this.variations.add(variation);
    }

    public void render(Renderer renderer, DateTime time) {
        for (Renderable variation : variations) {
            variation.render(renderer, time);
        }
    }

    public static interface Renderable {
        void render(Renderer r, DateTime time);
    }

    public static class Renderer {
        public void render(String string) {
            System.out.println(string);
        }
    }

}
