package dip.claim;

import dip.product.ReadOnlyProduct;
import dip.variation.Buyable;
import org.joda.time.DateTime;

public class PriceReplacement implements Claim.ReplacingStrategy {

    @Override
    public String replace(String source, DateTime date, ReadOnlyProduct product, Buyable variation) {
        return source.replaceAll("#price#", String.valueOf(variation.getPrice()) + "€");
    }
}
