package twitter.spring.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import twitter.spring.filters.services.ApplicationFiltersService;
import twitter.spring.filters.model.TweeterFilterModel;

import java.util.Set;

/**
 * Created by Tomek on 2016-10-18.
 */
@Log4j
@RestController
@Scope("request")
public class FiltersManagementController {
    @Autowired
    private ApplicationFiltersService applicationFiltersService;

    @RequestMapping(value = "/filters")
    public Set<TweeterFilterModel> getFilters() {
        return applicationFiltersService.getTweeterFilters();
    }

    @RequestMapping(value = "/filters/{filterValue}")
    public String getFilterSource(@PathVariable("filterValue") String filterValue) {
        return applicationFiltersService.getFilterSource(filterValue);
    }
}
