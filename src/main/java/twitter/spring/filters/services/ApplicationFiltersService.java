package twitter.spring.filters.services;

import lombok.Synchronized;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import twitter.spring.filters.model.TweeterFilterModel;

import javax.annotation.PostConstruct;
import java.util.*;

/**
 * Created by Tomek on 2016-10-18.
 */
@Component
@Scope("session")
public class ApplicationFiltersService {
    private Set<TweeterFilterModel> tweeterFilters;
    private int maxSize = 10;

    public ApplicationFiltersService() {
    }

    @PostConstruct
    public void init() {
        this.tweeterFilters = new LinkedHashSet<>(this.maxSize);
    }

    @Synchronized
    public void addFilter(TweeterFilterModel tweeterFilter) {
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

    public Set<TweeterFilterModel> getTweeterFilters() {
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
