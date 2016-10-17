package twitter.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.twitter.api.SearchParameters;
import org.springframework.social.twitter.api.SearchResults;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
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

    @RequestMapping(value = "/tweets/{tag}")
    @ResponseBody
    public List<Tweet> test(@PathVariable("tag") String tag) throws IOException {
        if (!tag.startsWith("#"))
            tag = "#" + tag;

        SearchResults search = twitter.searchOperations().search(tag);

/*
        List<Tweet> tweets = search.getTweets();
*/
        // tweets.forEach(tweet -> tweet.get);
        // tweets.forEach(t->t.getEntities().getUrls().forEach(e-> System.out.println(e.getUrl())));
       /* System.out.println("hello world");
        System.out.println(search.getTweets().size());
        search.getTweets().forEach(t -> System.out.println(t.getText()));
*/
        // Optional Step - format the Tweets into HTML
        return search.getTweets();
    }

    @GetMapping("/hello")
    public String hello(Model model) {
        model.addAttribute("name", "John Doe");
        return "welcome";
    }
}
