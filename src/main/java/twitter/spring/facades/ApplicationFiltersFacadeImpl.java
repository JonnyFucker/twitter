package twitter.spring.facades;

import org.springframework.beans.factory.annotation.Autowired;
import twitter.spring.filters.model.TweeterFilterModel;
import twitter.spring.filters.services.ApplicationFiltersService;

import java.util.Set;

/**
 * Created by Tomek on 2016-10-19.
 */
public class ApplicationFiltersFacadeImpl implements ApplicationFiltersFacade {

    @Autowired
    private ApplicationFiltersService applicationFiltersService;

    @Override
    public void addFilter(String source, String value) {
        applicationFiltersService.addFilter(new TweeterFilterModel(source, value));
    }

    @Override
    public String getFilterSource(String filterValue) {
        return applicationFiltersService.getFilterSource(filterValue);
    }

    @Override
    public Set<TweeterFilterModel> getFilters() {
        return applicationFiltersService.getTweeterFilters();
    }
}
