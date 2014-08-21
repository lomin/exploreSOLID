import dip.claim.Claim;

public class Renderer implements Claim.ClaimRenderer {

    @Override
    public void render(String string) {
        System.out.println(string);
    }

}
