/**
 *  Initial access point for obtaining a REST client 
 *  configured with an API Key.
 *
**/
public with sharing class MeerkatAPI 
{
	private static MeerkatRestClient client;

	/**
	 *  Get a MeerkatRestClient configured with your API Key.
	 *
	**/
	public static MeerkatRestClient getDefaultClient()
	{
		if(client == null) {
			MeerkatConfig__c config = getMeerkatConfig();
			client = new MeerkatRestClient(config.API_Key__c);
		}
		return client;
	}

	/**
	 *  Create a MeerkatRestClient with the given API Key.
	 *
	**/
	public MeerkatRestClient createClient(String apiKey)
	{
		return new MeerkatRestClient(apiKey);
	}

	/**
	 *  Obtain a MeerkatConfig object where the API Key is stored.
	 *
	**/
	public static MeerkatConfig__c getMeerkatConfig()
	{
		MeerkatConfig__c config = MeerkatConfig__c.getOrgDefaults();
		
		if(config == null) {
		    throw new MeerkatConfigurationException('Please enter your api key in the Meerkat Configuration custom setting.');
		}
		return config;
	}

	private class MeerkatConfigurationException extends Exception {}
}