package twitter.spring.controller;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.SocialException;
import org.springframework.social.twitter.api.SearchParameters;
import org.springframework.social.twitter.api.SearchResults;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import java.util.ArrayList;
import java.util.List;

/**
 * Created by Tomek on 17.10.16.
 */
@Controller
public class HomeController {
    private final Twitter twitter;
    private static final Logger logger = Logger.getLogger(HomeController.class);

    @Autowired
    public HomeController(Twitter twitter) {
        this.twitter = twitter;
    }

    @RequestMapping(value = "/tweets")
    @ResponseBody
    public List<Tweet> test(@RequestParam("tag") String tag) {
        if (!tag.startsWith("#"))
            tag = "#" + tag;

        try {
            SearchResults search = twitter.searchOperations().search(tag);
            return search.getTweets();
        } catch (SocialException e) {
            logger.error(e);
            return new ArrayList<>();
        }
    }

    @RequestMapping(value = "/person")
    @ResponseBody
    public List<Tweet> getPersonTweet(@RequestParam("name") String name) {
        try {
            List<Tweet> tweets = twitter.timelineOperations().getUserTimeline(name);
            return tweets;
        } catch (SocialException e) {
            logger.error(e);
            return new ArrayList<>();
        }
    }

    @GetMapping("/")
    public String index() {
        return "index";
    }
}
