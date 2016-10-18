package twitter.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.twitter.api.SearchParameters;
import org.springframework.social.twitter.api.SearchResults;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;


import java.util.List;

/**
 * Created by Tomek on 17.10.16.
 */
@Controller
public class HomeController {
    private final Twitter twitter;

    @Autowired
    public HomeController(Twitter twitter) {
        this.twitter = twitter;
    }

    @RequestMapping(value = "/tweets")
    @ResponseBody
    public List<Tweet> test(@RequestParam("tag") String tag)  {
        if (!tag.startsWith("#"))
            tag = "#" + tag;

        SearchResults search = twitter.searchOperations().search(tag);
        return search.getTweets();
    }

    @RequestMapping(value = "/person")
    @ResponseBody
    public List<Tweet> getPersonTweet(@RequestParam("name") String name){
        List<Tweet> tweets = twitter.timelineOperations().getUserTimeline(name);
        return tweets;
    }

    @GetMapping("/")
    public String index() {
        return "index";
    }
}
