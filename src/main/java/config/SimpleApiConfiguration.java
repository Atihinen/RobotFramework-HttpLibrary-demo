package config;
import java.util.ArrayList;

import models.Blog;

import com.yammer.dropwizard.config.Configuration;

public class SimpleApiConfiguration extends Configuration {
	
	private ArrayList<Blog> blogs = new ArrayList<Blog>();
	
	
	public ArrayList getBlogs(){
		return this.blogs;
	}
	
	public void addBlog(Blog b){
		blogs.add(b);
	}

}
