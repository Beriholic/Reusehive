package com.reusehive.config;

import cn.dev33.satoken.context.SaHolder;
import cn.dev33.satoken.filter.SaServletFilter;
import cn.dev33.satoken.interceptor.SaInterceptor;
import cn.dev33.satoken.router.SaHttpMethod;
import cn.dev33.satoken.router.SaRouter;
import cn.dev33.satoken.stp.StpUtil;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
@CrossOrigin
public class SaTokenConfiguration implements WebMvcConfigurer {


    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new SaInterceptor(handle -> StpUtil.checkLogin()))
                .addPathPatterns("/**")
                .excludePathPatterns("/user/login")
                .excludePathPatterns("/user/register")
                .excludePathPatterns("/setting")
        ;

/*
        根据路由划分模块，不同模块不同鉴权
        registry.addInterceptor(new SaInterceptor(handler -> {
            SaRouter.match("/user/**", r -> StpUtil.checkPermission("user"));
        })).addPathPatterns("/**");
*/
    }

    @Bean
    public SaServletFilter getSaServletFilter() {
        return new SaServletFilter().setBeforeAuth(obj -> {
            SaHolder.getResponse()
                    // 允许指定域访问跨域资源
                    .setHeader("Access-Control-Allow-Origin", "*")
                    // 允许所有请求方式
                    .setHeader("Access-Control-Allow-Methods", "*")
                    // 允许的header参数
                    .setHeader("Access-Control-Allow-Headers", "*")
                    // 有效时间
                    .setHeader("Access-Control-Max-Age", "3600");

            // 如果是预检请求，则立即返回到前端
            SaRouter.match(SaHttpMethod.OPTIONS)
                    .free(r -> System.out.println("--------OPTIONS预检请求，不做处理"))
                    .back();
        });
    }
}



