@istest
public with sharing class Test_MeerkatActivity 
{
	private static String response = '{\"result\":{\"activities\":[{\"watcher\":{\"id\":\"550\",' + 
	                                 '\"username\":\"meer\",\"displyName\":\"meer\"}, ' + 
	                                 '\"title\":\"liked\",\"message\":\"liked this\"}]}}';
	
	static testmethod void testOne()
	{
		setupData();

		Test.startTest();
		MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',response,null);
		Test.setMock(HttpCalloutMock.class,mock);

		MeerkatRestClient client = MeerkatAPI.getDefaultClient();
		MeerkatActivityList mkl = client.getBroadcast('123').getActivities();
		System.assertEquals(1,mkl.getPageData().size());

		for(MeerkatActivity activity : mkl.getPageData())
		{
			System.assertEquals('',activity.getResourceLocation());
			System.assertEquals(null,activity.getResultKey());
			System.assertEquals('liked', activity.getTitle());
			System.assertEquals('liked this',activity.getMessage());

			MeerkatWatcher watcher = activity.getWatcher();
			System.assertEquals('550',watcher.getId());
		}
		Test.stopTest();
	}

	static testmethod void testTwo()
	{
		MeerkatActivity activity = new MeerkatActivity(MeerkatAPI.getDefaultClient());
	}

	static testmethod void setupData()
	{
		MeerkatConfig__c config = MeerkatConfig__c.getOrgDefaults();
		config.API_Key__c = '112358';
		upsert config;
	}
}