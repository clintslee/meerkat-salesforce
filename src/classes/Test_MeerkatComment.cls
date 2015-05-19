@istest
public with sharing class Test_MeerkatComment 
{
	private static String response = '{\"result\":[{\"watcher\":{\"id\":\"550\",' + 
	                                 '\"username\":\"meer\",\"displyName\":\"meer\"}, ' + 
	                                 '\"title\":\"\",\"message\":\"a comment\"}]}';

	static testmethod void testOne()
	{
		setupData();

		Test.startTest();
		MeerkatHTTPMock mock = new MeerkatHTTPMock(200,'OK',response,null);
		Test.setMock(HttpCalloutMock.class,mock);

		MeerkatRestClient client = MeerkatAPI.getDefaultClient();
		MeerkatCommentList mcl = client.getBroadcast('123').getComments();
		System.assertEquals(1,mcl.getPageData().size());

		for(MeerkatComment comment : mcl.getPageData())
		{
			System.assertEquals('',comment.getResourceLocation());
			System.assertEquals(null,comment.getResultKey());
			System.assertEquals('', comment.getTitle());
			System.assertEquals('a comment',comment.getMessage());

			MeerkatWatcher watcher = comment.getWatcher();
			System.assertEquals('550',watcher.getId());
		}
		Test.stopTest();
	}

	static testmethod void testTwo()
	{
		MeerkatComment comment = new MeerkatComment(MeerkatAPI.getDefaultClient());
	}

	static testmethod void setupData()
	{
		MeerkatConfig__c config = MeerkatConfig__c.getOrgDefaults();
		config.API_Key__c = '112358';
		upsert config;
	}
}