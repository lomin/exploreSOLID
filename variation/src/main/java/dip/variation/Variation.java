package dip.variation;

import dip.claim.Claim;
import org.joda.time.DateTime;

import java.util.ArrayList;
import java.util.List;

public class Variation {

    private List<Claim> claims = new ArrayList<>();
    private int price = 0;

    public void addClaim(Claim claim) {
        this.claims.add(claim);
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public void render(Claim.ClaimRenderer renderer, DateTime time, String brand) {
        for (Claim claim : claims) {
            if (claim.getDate().equals(time)) {
                claim.render(renderer, time, price, brand);
            }
        }
    }
}
