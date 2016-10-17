package twitter.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.twitter.api.SearchResults;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

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

    @RequestMapping(value = "/tw")
    public String test(HttpServletResponse response) throws IOException {
        SearchResults search = twitter.searchOperations().search("#spring");
        System.out.println("hello world");
        System.out.println(search.getTweets().size());
        search.getTweets().forEach(t -> System.out.println(t.getText()));

        // Optional Step - format the Tweets into HTML
        return "welcome";
    }

    @GetMapping("/hello")
    public String hello(Model model) {
        model.addAttribute("name", "John Doe");
        return "welcome";
    }
}
