package twitter.spring.facades;

import org.springframework.social.twitter.api.Tweet;

import java.util.List;

/**
 * Created by Tomek on 2016-10-19.
 */
public interface TwitterFacade {
    List<Tweet> searchTweetsByTag(String tag);
    List<Tweet> searchTweetsByChannel(String channelName);
}
