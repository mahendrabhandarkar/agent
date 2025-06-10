package com.plant.agent.config;

import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ModSecurityConfig {
/*
    @Bean
    public FilterRegistrationBean<ModSecurityFilter> modSecurityFilter() {
        FilterRegistrationBean<ModSecurityFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(new ModSecurityFilter());
        registrationBean.addUrlPatterns("/*"); // Apply to all URLs
        registrationBean.addInitParameter("conf", "/path/to/modsecurity.conf"); // Path to your config file
        return registrationBean;
    }
 */
}