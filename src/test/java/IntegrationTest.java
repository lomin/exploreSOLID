import dip.claim.Claim;
import dip.product.Product;
import dip.variation.Variation;
import org.joda.time.DateTime;
import org.junit.Test;

import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;
import static org.mockito.Mockito.verifyNoMoreInteractions;

public class IntegrationTest {

    public static final DateTime DATE_2014_01_01 = new DateTime(2014, 1, 1, 0, 0);
    public static final DateTime DATE_2013_01_01 = new DateTime(2013, 1, 1, 0, 0);

    @Test
    public void integrationTest() throws Exception {
        Renderer renderer = mock(Renderer.class);
        Product product = new Product("Boss");
        Variation v1 = new Variation();
        v1.setPrice(3);
        v1.addClaim(new Claim("Nur #price# heute für #brand#-Produkte!", DATE_2014_01_01));
        v1.addClaim(new Claim("Alle #brand#-Produkte: Nur #price# für #year#!", DATE_2013_01_01));
        product.addVariation(v1);
        Variation v2 = new Variation();
        v2.setPrice(5);
        v2.addClaim(new Claim("Unschlagbare #price# für #brand#-Produkte nur dieses Jahr!", DATE_2013_01_01));
        v2.addClaim(new Claim("Alle #brand#-Produkte: #price# im Jahr #year#!", DATE_2014_01_01));
        product.addVariation(v2);

        product.render(renderer, DATE_2014_01_01);

        verify(renderer).render("Nur 3€ heute für Boss-Produkte!");
        verify(renderer).render("Alle Boss-Produkte: 5€ im Jahr 2014!");
        verifyNoMoreInteractions(renderer);
    }
}
