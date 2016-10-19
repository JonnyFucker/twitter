package twitter.spring.facades;

import lombok.extern.log4j.Log4j;
import org.apache.commons.collections.ListUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.SocialException;
import org.springframework.social.twitter.api.SearchResults;
import org.springframework.social.twitter.api.Tweet;
import org.springframework.social.twitter.api.Twitter;

import java.util.List;

/**
 * Created by Tomek on 2016-10-19.
 */
@Log4j
public class TwitterFacadeImpl implements TwitterFacade {
    @Autowired
    private Twitter twitterService;
    
    @Override
    public List<Tweet> searchTweetsByTag(String tag) {
        if (!tag.startsWith("#"))
            tag = "#" + tag;

        try {
            SearchResults search = twitterService.searchOperations().search(tag);
            return search.getTweets();
        } catch (SocialException e) {
            log.error(e);
            return ListUtils.EMPTY_LIST;
        }
    }

    @Override
    public List<Tweet> searchTweetsByChannel(String channelName) {
        try {
            List<Tweet> tweets = twitterService.timelineOperations().getUserTimeline(channelName);
            return tweets;
        } catch (SocialException e) {
            log.error(e);
            return ListUtils.EMPTY_LIST;
        }
    }
}
