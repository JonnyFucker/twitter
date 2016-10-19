package twitter.spring.filters;

import lombok.Getter;
import lombok.Synchronized;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.*;

/**
 * Created by Tomek on 2016-10-18.
 */
@Component
@Scope("session")
public class ApplicationFilters {
    private Set<TweeterFilter> tweeterFilters;
    private int maxSize = 10;

    public ApplicationFilters() {
        this.tweeterFilters = new LinkedHashSet<>(this.maxSize);
    }

    @Synchronized
    public void addFilter(TweeterFilter tweeterFilter) {
        this.tweeterFilters.add(tweeterFilter);
        checkListSize();
    }

    public String getFilterSource(String filterValue) {
        String source = this.tweeterFilters.stream()
                .filter(filter -> filter.getValue().equals(filterValue))
                .findFirst()
                .get().getSource();
        return source;
    }

    public Set<TweeterFilter> getTweeterFilters() {
        return tweeterFilters;
    }

    public void setMaxSize(int maxSize) {
        this.maxSize = maxSize;
    }

    private void checkListSize() {
        if (this.tweeterFilters.size() > maxSize) {
            this.tweeterFilters.remove(this.tweeterFilters.iterator().next());
        }
    }
}
