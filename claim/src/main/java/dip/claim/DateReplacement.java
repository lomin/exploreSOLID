package dip.claim;

import dip.product.Product;
import dip.variation.Variation;
import org.joda.time.DateTime;

public class DateReplacement implements Claim.ReplacingStrategy {

    @Override
    public String replace(String source, DateTime date, Product product, Variation variation) {
        return source.replaceAll("#year#", String.valueOf(date.getYear()));
    }
}
