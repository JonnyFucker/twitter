package twitter.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.social.twitter.api.Twitter;
import org.springframework.social.twitter.api.impl.TwitterTemplate;

/**
 * Created by Tomek on 2016-10-18.
 */
@Configuration
public class SimpleTwitterConfig {
    private static Twitter twitter;

    public SimpleTwitterConfig() {

        if (twitter == null) {
            twitter = new TwitterTemplate("oznLh8eKfSOWWBgdCGmh2M9zY", "CO92ffOzFI9jx91r7dbMbEPQLWZjjt6B8eT8IEH9WPoDBa4R4a");
        }
    }

    @Bean
    @Scope(value = "request", proxyMode = ScopedProxyMode.INTERFACES)
    public Twitter twitter() {
        return twitter;
    }
}
