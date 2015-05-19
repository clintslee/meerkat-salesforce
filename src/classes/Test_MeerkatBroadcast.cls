@istest
public with sharing class Test_MeerkatBroadcast 
{
	static String response = '{\"result\":[{\"id\":\"1234\",' + 
	                         '\"broadcast\":\"https://bcast.com\",' + 
	                         '\"startTime\":1431424250723,' + 
	                         '\"influencers\":[ \"b:123456789\"]}]}';

	static testmethod void testOne()
	{
		setupData();

		Test.startTest();
		MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',response,null);
		Test.setMock(HttpCalloutMock.class,mock);

		MeerkatRestClient client = MeerkatAPI.getDefaultClient();
		MeerkatBroadcastList bcl = client.getBroadcasts();
		System.assertEquals(1,bcl.getPageData().size());

		for(MeerkatBroadcast bc : bcl.getPageData())
		{
			System.assertEquals('1234',bc.getId());
			System.assertEquals('https://bcast.com',bc.getUrl());
			System.assertEquals(DateTime.newInstance(Long.valueOf('1431424250723')),bc.getStartTime());
			System.assertEquals('b:123456789',bc.getInfluencers().get(0));
			System.assert(bc.getResourceLocation().contains(bc.getId()));
			System.assertEquals('result',bc.getResultKey());
		}
		Test.stopTest();
	}

	static testmethod void testTwo()
	{
		MeerkatBroadcast bc = new MeerkatBroadcast(MeerkatAPI.getDefaultClient());
	}

	static testmethod void setupData()
	{
		MeerkatConfig__c config = MeerkatConfig__c.getOrgDefaults();
		config.API_Key__c = '112358';
		upsert config;
	}
}