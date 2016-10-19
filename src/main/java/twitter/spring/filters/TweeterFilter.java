package twitter.spring.filters;

import lombok.*;

/**
 * Created by Tomek on 2016-10-18.
 */

@Data
@AllArgsConstructor
public class TweeterFilter {
    private String source;
    private String value;
}
