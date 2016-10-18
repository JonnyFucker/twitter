package twitter.spring.controller;

import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import twitter.spring.filters.ApplicationFilters;
import twitter.spring.filters.TweeterFilter;

import java.util.List;

/**
 * Created by Tomek on 2016-10-18.
 */
@Log4j
@RestController
@Scope("request")
public class FiltersManagment {
    @Autowired
    private ApplicationFilters applicationFilters;

    @RequestMapping(value = "/filters")
    public List<TweeterFilter> getFilters(){
        return applicationFilters.getTweeterFilters();
    }
}
