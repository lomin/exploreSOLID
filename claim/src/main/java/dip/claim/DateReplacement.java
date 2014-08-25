package dip.claim;

import dip.product.ReadOnlyProduct;
import dip.variation.Buyable;
import org.joda.time.DateTime;

public class DateReplacement implements Claim.ReplacingStrategy {

    @Override
    public String replace(String source, DateTime date, ReadOnlyProduct product, Buyable variation) {
        return source.replaceAll("#year#", String.valueOf(date.getYear()));
    }
}
