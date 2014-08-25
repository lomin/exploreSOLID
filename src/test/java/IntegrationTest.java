import dip.claim.Claim;
import dip.claim.DateReplacement;
import dip.claim.PriceReplacement;
import dip.product.Product;
import dip.variation.Variation;
import org.joda.time.DateTime;
import org.junit.Test;
import org.mockito.Mockito;

import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;

public class IntegrationTest {

    public static final DateTime DATE_2014_01_01 = new DateTime(2014, 1, 1, 0, 0);
    public static final DateTime DATE_2013_01_01 = new DateTime(2013, 1, 1, 0, 0);

    @Test
    public void integrationTest() throws Exception {
        Claim.ReplacingStrategy strategies = new Claim.ReplacingStrategyList(new DateReplacement(), new PriceReplacement());
        Product.Renderer renderer = Mockito.mock(Product.Renderer.class);
        Product product = new Product();
        Variation v1 = new Variation();
        v1.setPrice(3);
        v1.addClaim(new Claim("Nur #price# heute!", DATE_2014_01_01, strategies));
        v1.addClaim(new Claim("Nur #price# für #year#!", DATE_2013_01_01, strategies));
        product.addVariation(v1);
        Variation v2 = new Variation();
        v2.setPrice(5);
        v2.addClaim(new Claim("Unschlagbare #price# nur dieses Jahr!", DATE_2013_01_01, strategies));
        v2.addClaim(new Claim("#price# im Jahr #year#!", DATE_2014_01_01, strategies));
        product.addVariation(v2);

        product.render(renderer, DATE_2014_01_01);

        verify(renderer).render("Nur 3€ heute!");
        verify(renderer).render("5€ im Jahr 2014!");
        verifyNoMoreInteractions(renderer);
    }

}