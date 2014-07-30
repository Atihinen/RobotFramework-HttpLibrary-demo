package models;

import java.util.Date;

public class Blog {
	
	private String title;
	private String url;
	private String id;
	private Date publishedOn;
	
	public Blog(){
		
	}
	
	public Blog(String title, String url) {
        super();
        this.title = title;
        this.url = url;
    }
 
    public String getId() {
        return id;
    }
 
    public String getTitle() {
        return title;
    }
 
    public String getUrl() {
        return url;
    }
 
    public Date getPublishedOn() {
        return publishedOn;
    }

}
