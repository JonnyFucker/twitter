package twitter.spring.controller;

import lombok.extern.log4j.Log4j;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.social.SocialException;
import org.springframework.social.twitter.api.SearchResults;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import twitter.spring.filters.ApplicationFilters;
import twitter.spring.filters.TweeterFilter;


import java.util.ArrayList;
import java.util.List;

/**
 * Created by Tomek on 17.10.16.
 */
@Log4j
@Controller
@Scope("request")
public class MainController {
    private final Twitter twitter;

    @Autowired
    private ApplicationFilters applicationFilters;

    @Autowired
    public MainController(Twitter twitter) {
        this.twitter = twitter;
    }

    @RequestMapping(value = "/tweets")
    @ResponseBody
    public List<Tweet> test(@RequestParam("tag") String tag) {
        if (!tag.startsWith("#"))
            tag = "#" + tag;

        applicationFilters.addFilter(new TweeterFilter("tweets", tag));

        try {
            SearchResults search = twitter.searchOperations().search(tag);
            return search.getTweets();
        } catch (SocialException e) {
            log.error(e);
            return new ArrayList<>();
        }
    }

    @RequestMapping(value = "/person")
    @ResponseBody
    public List<Tweet> getPersonTweet(@RequestParam("name") String name) {
        applicationFilters.addFilter(new TweeterFilter("person", name));
        try {
            List<Tweet> tweets = twitter.timelineOperations().getUserTimeline(name);
            return tweets;
        } catch (SocialException e) {
            log.error(e);
            return new ArrayList<>();
        }
    }

    @GetMapping("/")
    public String index() {
        return "index";
    }
}
