package eu.openreq.qt.qthulhu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.support.SpringBootServletInitializer;


/**
 * This starts everything
 */
@SpringBootApplication
public class MainApp extends SpringBootServletInitializer
{
    public static void main(String[] args)
    {
        SpringApplication.run(MainApp.class, args);

    }


    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder)
    {
        return builder.sources(MainApp.class);
    }
}
