package resources;

import java.util.Arrays;
import java.util.List;

import javax.validation.Valid;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import models.Blog;

import com.yammer.metrics.annotation.Timed;

import config.SimpleApiConfiguration;

@Path("/")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class IndexResource {
	
	private final SimpleApiConfiguration conf;
	
	public IndexResource(SimpleApiConfiguration conf){
		this.conf = conf;
		Blog b = new Blog("Day 12: OpenCV--Face Detection for Java Developers",
                "https://www.openshift.com/blogs/day-12-opencv-face-detection-for-java-developers");
		conf.addBlog(b);
	}
	
	
	@GET
	@Produces(value = MediaType.APPLICATION_JSON)
    @Timed
    public List<Blog> index() {
		List<Blog> l = conf.getBlogs();
        return l;
     }
	
	@POST
	@Timed
	public Response addBlog(@Valid Blog blog){
		conf.addBlog(blog);
		return Response.ok().build();
	}
}