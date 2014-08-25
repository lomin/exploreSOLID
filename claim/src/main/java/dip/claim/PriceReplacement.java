package dip.claim;

import dip.product.Product;
import dip.variation.Variation;
import org.joda.time.DateTime;

public class PriceReplacement implements Claim.ReplacingStrategy {

    @Override
    public String replace(String source, DateTime date, Product product, Variation variation) {
        String result = source.replaceAll("#price#", String.valueOf(variation.getPrice()) + "€");
        variation.setPrice(0);
        return result;
    }
}
