package dip.claim;

import dip.product.Product;
import dip.variation.Variation;
import org.joda.time.DateTime;

public class Claim implements Variation.Renderable {

    private final DateTime date;
    private final ReplacingStrategy replacingStrategy;
    private final String template;

    public Claim(String template, DateTime dateTime, ReplacingStrategy replacingStrategy) {
        this.template = template;
        this.date = dateTime;
        this.replacingStrategy = replacingStrategy;
    }

    @Override
    public void render(Product.Renderer renderer, DateTime time, Product product, Variation variation) {
        if (time.equals(date)) {
            renderer.render(replacingStrategy.replace(template, date, product, variation));
        }
    }

    public static interface ReplacingStrategy {
        String replace(String source, DateTime date, Product product, Variation variation);
    }

    public static class ReplacingStrategyList implements ReplacingStrategy {
        private final ReplacingStrategy[] strategies;

        public ReplacingStrategyList(ReplacingStrategy... strategies) {
            this.strategies = strategies;
        }

        @Override
        public String replace(String source, DateTime date, Product product, Variation variation) {
            for (ReplacingStrategy strategy : strategies) {
                source = strategy.replace(source, date, product, variation);
            }
            return source;
        }
    }
}
