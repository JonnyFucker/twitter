package twitter.spring.filters;

import lombok.Getter;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Tomek on 2016-10-18.
 */
@Component
@Scope("session")
public class ApplicationFilters {
    private List<TweeterFilter> tweeterFilters;
    private int maxSize = 10;

    public ApplicationFilters() {
        this.tweeterFilters = new ArrayList<>(this.maxSize);
    }

    public void addFilter(TweeterFilter tweeterFilter){
        checkListSize();
        this.tweeterFilters.add(tweeterFilter);
    }

    public List<TweeterFilter> getTweeterFilters() {
        return tweeterFilters;
    }

    public void setMaxSize(int maxSize) {
        this.maxSize = maxSize;
    }

    private void checkListSize(){
        if(this.tweeterFilters.size()>maxSize){
            this.tweeterFilters.remove(0);
        }
    }
}
