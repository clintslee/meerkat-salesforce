@istest
public with sharing class Test_MeerkatRestream
{
	private static String response = '{\"result\":[{\"watcher\":{\"id\":\"550\",' + 
	                                 '\"username\":\"meer\",\"displyName\":\"meer\"}, ' + 
	                                 '\"title\":\"restreamed\",\"message\":\"retweeted this\"}]}';

	static testmethod void testOne()
	{
		setupData();

		Test.startTest();
		MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',response,null);
		Test.setMock(HttpCalloutMock.class,mock);

		MeerkatRestClient client = MeerkatAPI.getDefaultClient();
		MeerkatRestreamList mrl = client.getBroadcast('123').getRestreams();
		System.assertEquals(1,mrl.getPageData().size());

		for(MeerkatRestream rs : mrl.getPageData())
		{
			System.assertEquals('',rs.getResourceLocation());
			System.assertEquals(null,rs.getResultKey());
			System.assertEquals('restreamed', rs.getTitle());
			System.assertEquals('retweeted this',rs.getMessage());

			MeerkatWatcher watcher = rs.getWatcher();
			System.assertEquals('550',watcher.getId());
		}
		Test.stopTest();
	}

	static testmethod void testTwo()
	{
		MeerkatRestream lik = new MeerkatRestream(MeerkatAPI.getDefaultClient());
	}

	static testmethod void setupData()
	{
		MeerkatConfig__c config = MeerkatConfig__c.getOrgDefaults();
		config.API_Key__c = '112358';
		upsert config;
	}
}