import dip.claim.Claim;
import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;

public class Product {

    private List<Variation> variations = new ArrayList<>();

    public List<Variation> getVariations() {
        return variations;
    }

    public void addVariation(Variation variation) {
        this.variations.add(variation);
    }

    public void render(Claim.ClaimRenderer renderer, DateTime time) {
        for (Variation variation : variations) {
            variation.render(renderer, time);
        }
    }

}
