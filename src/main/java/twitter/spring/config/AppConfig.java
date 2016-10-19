package twitter.spring.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Scope;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.DefaultServletHandlerConfigurer;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;
import twitter.spring.facades.ApplicationFiltersFacade;
import twitter.spring.facades.ApplicationFiltersFacadeImpl;
import twitter.spring.facades.TwitterFacade;
import twitter.spring.facades.TwitterFacadeImpl;
import twitter.spring.filters.services.ApplicationFiltersService;

/**
 * Created by Tomek on 17.10.16.
 */
@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "twitter.spring")
public class AppConfig extends WebMvcConfigurerAdapter {
    @Bean
    public ViewResolver viewResolver() {
        InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
        viewResolver.setViewClass(JstlView.class);
        viewResolver.setPrefix("/WEB-INF/views/");
        viewResolver.setSuffix(".jsp");
        return viewResolver;
    }

    @Bean
    public ApplicationFiltersService applicationFilters() {
        return new ApplicationFiltersService();
    }

    @Bean
    public TwitterFacade twitterFacade() {
        return new TwitterFacadeImpl();
    }

    @Bean
    @Scope("session")
    public ApplicationFiltersFacade applicationFiltersFacade() {
        return new ApplicationFiltersFacadeImpl();
    }

    @Override
    public void configureDefaultServletHandling(DefaultServletHandlerConfigurer configurer) {
        configurer.enable();
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/resources/**").addResourceLocations("/resources/");
    }

}
