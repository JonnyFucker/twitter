package twitter.spring.facades;

import twitter.spring.filters.model.TweeterFilterModel;

import java.util.Set;

/**
 * Created by Tomek on 2016-10-19.
 */
public interface ApplicationFiltersFacade {
    public void addFilter(String source, String value);
    public String getFilterSource(String filterValue);
    public Set<TweeterFilterModel> getFilters();
}
