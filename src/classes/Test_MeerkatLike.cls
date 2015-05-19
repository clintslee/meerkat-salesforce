@istest
public with sharing class Test_MeerkatLike
{
	private static String response = '{\"result\":[{\"watcher\":{\"id\":\"550\",' + 
	                                 '\"username\":\"meer\",\"displyName\":\"meer\"}, ' + 
	                                 '\"title\":\"liked\",\"message\":\"liked this\"}]}';

	static testmethod void testOne()
	{
		setupData();

		Test.startTest();
		MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',response,null);
		Test.setMock(HttpCalloutMock.class,mock);

		MeerkatRestClient client = MeerkatAPI.getDefaultClient();
		MeerkatLikeList mcl = client.getBroadcast('123').getLikes();
		System.assertEquals(1,mcl.getPageData().size());

		for(MeerkatLike lik : mcl.getPageData())
		{
			System.assertEquals('',lik.getResourceLocation());
			System.assertEquals(null,lik.getResultKey());
			System.assertEquals('liked', lik.getTitle());
			System.assertEquals('liked this',lik.getMessage());

			MeerkatWatcher watcher = lik.getWatcher();
			System.assertEquals('550',watcher.getId());
		}
		Test.stopTest();
	}

	static testmethod void testTwo()
	{
		MeerkatLike lik = new MeerkatLike(MeerkatAPI.getDefaultClient());
	}

	static testmethod void setupData()
	{
		MeerkatConfig__c config = MeerkatConfig__c.getOrgDefaults();
		config.API_Key__c = '112358';
		upsert config;
	}
}