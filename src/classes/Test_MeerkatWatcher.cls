@istest
public with sharing class Test_MeerkatWatcher
{
	private static String response = '{\"result\":{\"watchers\":[{\"id\":\"550\",' + 
	                                 '\"username\":\"meer\",\"displayName\":\"meer\", ' + 
	                                 '\"profileThumbImage\":\"https://static.meerkatapp.co\",' +
	                                 '\"follow\":\"https://static.meerkatapp.co\",' + 
	                                 '\"profile\":\"https://static.meerkatapp.co\",' + 
	                                 '\"photoUrl\":\"https://static.meerkatapp.co\"' +
	                                 '}]}}'; 

	static testmethod void testOne()
	{
		setupData();

		Test.startTest();
		MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',response,null);
		Test.setMock(HttpCalloutMock.class,mock);

		MeerkatRestClient client = MeerkatAPI.getDefaultClient();
		MeerkatWatcherList mwl = client.getBroadcast('123').getWatchers();
		System.assertEquals(1,mwl.getPageData().size());

		for(MeerkatWatcher watcher : mwl.getPageData())
		{
			System.assertEquals('',watcher.getResourceLocation());
			System.assertEquals(null,watcher.getResultKey());
			System.assertEquals('550', watcher.getId());
			System.assertEquals('meer', watcher.getUsername());
			System.assertEquals('meer', watcher.getDisplayName());
			System.assertEquals('https://static.meerkatapp.co', watcher.getProfileThumbImage());
			System.assertEquals('https://static.meerkatapp.co', watcher.getFollow());
			System.assertEquals('https://static.meerkatapp.co', watcher.getProfile());
			System.assertEquals('https://static.meerkatapp.co', watcher.getPhotoUrl());
		}
		Test.stopTest();
	}

	static testmethod void testTwo()
	{
		MeerkatWatcher comment = new MeerkatWatcher(MeerkatAPI.getDefaultClient());
	}

	static testmethod void setupData()
	{
		MeerkatConfig__c config = MeerkatConfig__c.getOrgDefaults();
		config.API_Key__c = '112358';
		upsert config;
	}
}