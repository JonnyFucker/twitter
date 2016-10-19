package twitter.spring.filters.model;

import lombok.*;

/**
 * Created by Tomek on 2016-10-18.
 */

@Data
@AllArgsConstructor
public class TweeterFilterModel {
    private String source;
    private String value;
}
