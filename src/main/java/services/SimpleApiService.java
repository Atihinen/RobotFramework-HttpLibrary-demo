package services;
import resources.IndexResource;

import com.yammer.dropwizard.Service;
import com.yammer.dropwizard.config.Bootstrap;
import com.yammer.dropwizard.config.Environment;

import config.SimpleApiConfiguration;

public class SimpleApiService extends Service<SimpleApiConfiguration> {
	public static void main(String args[]) throws Exception{
		new SimpleApiService().run(new String[] { "server" });
	}

	@Override
	public void initialize(Bootstrap<SimpleApiConfiguration> bootstrap) {
		bootstrap.setName("blog");
		
	}

	@Override
	public void run(SimpleApiConfiguration configuration, Environment environment)
			throws Exception {
		environment.addResource(new IndexResource(configuration));
		
		
	}
	

}