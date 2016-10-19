package twitter.spring.controller;

import lombok.extern.log4j.Log4j;
import org.apache.commons.collections.ListUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.social.SocialException;
import org.springframework.social.twitter.api.SearchResults;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import twitter.spring.facades.ApplicationFiltersFacade;
import twitter.spring.facades.TwitterFacade;
import twitter.spring.filters.services.ApplicationFiltersService;
import twitter.spring.filters.model.TweeterFilterModel;


import java.util.List;

/**
 * Created by Tomek on 17.10.16.
 */
@Log4j
@Controller
@Scope("request")
public class MainController {

    @Autowired
    private ApplicationFiltersFacade applicationFiltersFacade;

    @Autowired
    private TwitterFacade twitterFacade;


    @RequestMapping(value = "/tweets")
    @ResponseBody
    public List<Tweet> getTweetsByTag(@RequestParam("tag") String tag) {
        applicationFiltersFacade.addFilter("tweets", tag);
        return twitterFacade.searchTweetsByTag(tag);

    }

    @RequestMapping(value = "/person")
    @ResponseBody
    public List<Tweet> getTweetsByChannel(@RequestParam("tag") String tag) {
        applicationFiltersFacade.addFilter("person", tag);
        return twitterFacade.searchTweetsByChannel(tag);
    }

    @GetMapping("/")
    public String index() {
        return "index";
    }

    @GetMapping("/clean")
    public String clean() {
        return "clean";
    }
}
